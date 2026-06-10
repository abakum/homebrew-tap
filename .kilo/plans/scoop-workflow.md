# Plan: Workflow scoop.yml для публикации в ScoopInstaller/Extras

## Цель
Создать `.github/workflows/scoop.yml` — GitHub Actions workflow для ручной отправки PR с манифестом `bucket/crocson.json` в `ScoopInstaller/Extras`.

## Триггеры
Только **workflow_dispatch**:
- `force_submit` (boolean, default false) — пересоздать PR даже если он уже существует

## Workflow: publish-to-scoop

### Переменные окружения
- `GH_TOKEN: ${{ secrets.SCOOP_TOKEN }}` — PAT с правами `public_repo`
- `MANIFEST: crocson` — имя манифеста

### Шаги

1. **Checkout** этого репозитория (`actions/checkout@v4`)

2. **Extract version** — `jq -r '.version' bucket/crocson.json` → `$VERSION`

3. **Check if manifest exists in Extras** — через `gh api` проверить наличие файла `bucket/crocson.json` в `ScoopInstaller/Extras`. Результат: `IS_NEW` (true/false)

4. **Fork ScoopInstaller/Extras** — `gh repo fork ScoopInstaller/Extras --clone=false`

5. **Clone fork, copy manifest, commit, push**
   - Клонировать форк (shallow)
   - Создать ветку `crocson-<version>`
   - Скопировать `bucket/crocson.json` → `bucket/crocson.json` в форке
   - Если diff пустой — завершить
   - Commit: `git commit -m "crocson: <Add|Update to> version <version>"`
   - Push в форк

6. **Create PR** в `ScoopInstaller/Extras`:
   - Если `IS_NEW=true`: title `crocson: Add version <version>`, body описывает приложение
   - Если `IS_NEW=false`: title `crocson: Update to version <version>`, body с кратким описанием изменений
   - Если PR уже существует — пропустить (или пересоздать при `force_submit`)

## Как получить SCOOP_TOKEN
1. GitHub → Settings → Developer settings → Personal access tokens → **Tokens (classic)** → Generate new token
2. Отметить scope: `public_repo`
3. Скопировать токен
4. В этом репозитории: Settings → Secrets and variables → Actions → New repository secret → Name: `SCOOP_TOKEN`, Value: <токен>

## Итог
Один новый файл: `.github/workflows/scoop.yml`
