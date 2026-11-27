# Практическая работа №11

Ansible: роли base, ssh, nginx и app, bootstrap → prod, идемпотентность, drift и read-only аудит.

Проект: [ansible/](ansible/). Запускать команды из этого каталога — здесь расположен ansible.cfg.

## Адаптация для Multipass

Поддерживаются Ubuntu 24.04 AMD64 и ARM64. Архитектура Docker-репозитория выбирается по фактам VM. Образ работы №10 опубликован для обеих платформ.

В SSH AllowUsers сохранён ubuntu для управления Multipass; пользователь приложения остаётся app, пользователь автоматизации — devops, первичный пользователь по методичке — student. Перед запуском следует проверить, существует ли student на чистом снимке Multipass; пароль и закрытый ключ в Git не помещаются.

Inventory содержит последний известный адрес учебной VM — после восстановления снимка его нужно проверить. Парольный bootstrap выполняется с --ask-pass и --ask-become-pass. Если sshpass недоступен, предусмотренный методичкой вариант — заранее установить публичный ключ студенту через консоль, затем использовать ключ и --ask-become-pass.

## Запуски

```sh
cd practice-11/ansible
ansible-galaxy collection install -r requirements.yml
ansible-inventory -i inventory/bootstrap.ini --graph
ansible-inventory --graph
ansible-playbook -i inventory/bootstrap.ini site.yml --syntax-check
ansible-playbook site.yml --syntax-check
ansible-playbook -i inventory/bootstrap.ini site.yml --ask-pass --ask-become-pass
ansible-playbook site.yml
ansible-playbook verify.yml
```

Полный сценарий и доказательства выполнения сохраняются вне публичного сайта работы №9. Текущие файлы — подготовленная конфигурация, запуск на VM ещё не выполнен.
