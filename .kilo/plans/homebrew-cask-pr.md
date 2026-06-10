# Plan: Подача crocson в Homebrew/homebrew-cask

## Контекст
Создать cask-файл для PR в официальный репозиторий `Homebrew/homebrew-cask` на основе существующего `Casks/crocson.rb`.

## Шаги

### 1. Создать файл `Casks/crocson-official.rb`
На основе текущего `Casks/crocson.rb` с изменениями:

- **Удалить** строки `arm64_linux` / `x86_64_linux` из `sha256`
- **Удалить** комментарии `# typed: false` и `# frozen_string_literal: true` (не нужны в homebrew-cask)
- **Добавить** `depends_on macos: ">= :high_sierra"` если fyne требует определённую версию macOS (опционально, уточнить)
- Оставить всё остальное как есть

Итоговое содержимое:

```ruby
cask "crocson" do
  arch arm: "arm64", intel: "amd64"

  version "1.11.62"
  sha256 arm:   "179c3332c08a977807ac744b9e3fa7e79fa50b827ce2063d2398d39a3f327895",
         intel: "c8f361b7af1cfe942593bfa1b10187f0c880b49a95c151c8ce3c12671c26e386"

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

### 2. Локальная проверка
```bash
brew audit --cask --online Casks/crocson-official.rb
brew style --cask Casks/crocson-official.rb
```

### 3. Подача PR в Homebrew/homebrew-cask
```bash
# Форкнуть https://github.com/Homebrew/homebrew-cask
# Клонировать форк
# Создать ветку: git checkout -b crocson
# Скопировать файл как: Casks/c/crocson.rb
# Коммит + пуш
# Открыть PR с названием: "crocson 1.11.62 (new cask)"
```

## Примечания
- В официальном homebrew-cask файл лежит по пути `Casks/c/crocson.rb` (по первой букве)
- Файл в tap (`abakum/homebrew-tap`) остаётся без изменений — Linux-хеши нужны для Linux-пользователей
