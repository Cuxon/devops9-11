# Практическая работа №10

Учебное Flask-приложение: Pylint → pytest → Docker build → smoke-test → GHCR.

- Проверка жизнеспособности: `/health`, ответ `{"status":"ok"}`.
- Главная: `/`, сведения о службе и версии.
- Workflow: [`../.github/workflows/ci.yml`](../.github/workflows/ci.yml).
- Образ: `ghcr.io/cuxon/devops9-11`, теги полного SHA и `latest`.
- OCI source label связывает пакет с `Cuxon/devops9-11`.

Вместо отдельного репозитория из методички используется папка `practice-10` общего репозитория. Команды проверки выполняются из этой папки; Docker context — эта же папка. Рабочая документация №9 остаётся в `practice-09`.

В PR выполняются проверки, сборка и запуск контейнера. Шаги Tag/Login/Push выполняются только по push в main. Имя образа приводится к нижнему регистру. Токен передаётся через env и stdin; персональный токен не нужен.

## Зависимости

`app/requirements.txt` содержит Flask и Gunicorn для запуска. `requirements-dev.txt` содержит Pylint и pytest для CI. Инструменты проверки не включаются в Docker-образ.

Точка входа `app.app:app` — пакет `app`, модуль `app.py`, объект Flask `app`. Контейнер работает от пользователя `app`.

## Статус учебного эксперимента

Первый инцидент воспроизведён: GHCR отклонил push сообщением `installation not allowed to Create organization package`. Заданию `image` добавлено `packages: write`; задания `lint` и `test` сохраняют только `contents: read`. Восстановление публикации проверяется новым запуском после слияния исправления.
