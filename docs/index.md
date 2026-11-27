# DevOps Operations Handbook

Учебный сайт документации, собираемый из Markdown и публикуемый через GitHub Actions.

**Версия: 2.** Обновление после исправления ссылки.

## Контур поставки

1. Изменение предлагается через Pull Request в `main`.
2. Pylint проверяет Python-код.
3. После слияния в `main` MkDocs собирает статический сайт.
4. GitHub Pages публикует артефакт сборки.

Адрес сайта после публикации: https://cuxon.github.io/devops9-11/.
Фактический URL проверьте в окружении `github-pages` после успешного deploy.
