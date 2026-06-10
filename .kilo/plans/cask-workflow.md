# Plan: Workflow `.github/workflows/cask.yml` для публикации в Homebrew/homebrew-cask

## Цель
Создать GitHub Actions workflow, который автоматически публикует crocson cask в официальный репозиторий `Homebrew/homebrew-cask` через PR (по аналогии с `scoop.yml` и `publish` job в `latest.yml`).

## Workflow: `.github/workflows/cask.yml`

### Триггер
- `workflow_dispatch` (ручной запуск, как scoop.yml)
- Опциональный параметр `force_submit` для повторной отправки PR

### Env
- `MANIFEST: crocson` (имя cask)

### Job: `publish-to-homebrew-cask`

**Step 1: Checkout** — клонировать `abakum/homebrew-tap`

**Step 2: Extract version from Cask** — извлечь версию из `Casks/crocson.rb`
```bash
VERSION=$(grep -oP 'version "\K[^"]+' Casks/crocson.rb)
```

**Step 3: Extract hashes from Cask** — извлечь SHA256 для arm и intel
```bash
ARM_SHA=$(grep -oP 'arm:\s+"\K[a-f0-9]+' Casks/crocson.rb)
INTEL_SHA=$(grep -oP 'intel:\s+"\K[a-f0-9]+' Casks/crocson.rb)
```
(Берём только arm/intel, Linux-хеши игнорируются)

**Step 4: Check if cask already exists in homebrew-cask** — через GitHub API проверить наличие `Casks/c/crocson.rb` в `Homebrew/homebrew-cask`
- Если существует → `exists=true` (update)
- Если нет → `exists=false` (new cask)

**Step 5: Fork Homebrew/homebrew-cask** — `gh repo fork Homebrew/homebrew-cask --clone=false`

**Step 6: Clone fork and prepare cask** — клонировать форк, создать ветку `crocson-VERSION`, сгенерировать чистый cask-файл:

Генерация cask-файла через heredoc или Ruby-скрипт:
```ruby
cask "crocson" do
  arch arm: "arm64", intel: "amd64"

  version "VERSION"
  sha256 arm:   "ARM_SHA",
         intel: "INTEL_SHA"

  url "https://github.com/abakum/crocson/releases/download/v#{version}/crocson-#{arch}.dmg"
  name "crocson"
  desc "GUI for croc — secure file transfer tool"
  homepage "https://github.com/abakum/crocson"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "crocson.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", staged_path/"crocson.app"]
  end

  zap trash: "~/Library/Preferences/fyne/com.github.abakum.crocson/preferences.json"
end
```

Файл кладётся по пути: `Casks/c/crocson.rb`

**Step 7: Create Pull Request** — создать PR в `Homebrew/homebrew-cask`:
- Новый cask: title `crocson VERSION (new cask)`
- Обновление: title `crocson VERSION`
- body: описание, ссылки, автоматизация

### Секрет
- Нужен `CASK_TOKEN` — Personal Access Token с правами `public_repo` (аналог `SCOOT_TOKEN` / `WINGET_TOKEN`)

### Отличия от scoop.yml
1. Целевой репозиторий: `Homebrew/homebrew-cask` (не ScoopInstaller/Extras)
2. Файл генерируется из шаблона (удаляются Linux-хеши)
3. Путь: `Casks/c/crocson.rb` (по первой букве)
4. Формат: Ruby (не JSON)

### Примечание
- homebrew-cask принимает **только macOS** casks — Linux-хеши (`arm64_linux`, `x86_64_linux`) не нужны
- `postflight` с `xattr -d com.apple.quarantine` — допустим в homebrew-cask (используется многими cask'ами)
- Для первого PR (new cask) мейнтейнеры homebrew могут запросить изменения

## Файлы для создания/изменения
1. **Создать** `.github/workflows/cask.yml` — новый workflow
