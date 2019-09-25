**nginx и mc**
- Скопировать файл otuerfd cs.repo в /etc/yum.repos.d 
- Просмотр содержимого репозитория yum repo-pkgs otus-repo list. Через обычный yum list available почему видиться только nginx. Пробовал настроить yum но так и не осилил. 
- Установка пакетов из репозитория yum repo-pkgs otus-repo install.
- nginx собран --with-openssl, mc собран без поддержки smb.
- Dockerfile писал первый раз ;) но вроде всё вышло как надо. Собирает образ, качает пакеты и создаёт репозиторий.
