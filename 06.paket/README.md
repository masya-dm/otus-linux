**nginx и mc**
- Скопировать файл otus.repo в /etc/yum.repos.d 
- Просмотр содержимого репозитория yum repo-pkgs otus-repo list. Через обычный yum list available почему видиться только nginx. Пробовал настроить yum но так и не осилил. 
- Установка пакетов из репозитория yum repo-pkgs otus-repo install.
- nginx собран --with-openssl, mc собран без поддержки smb.
- Dockerfile писал первый раз ;) но вроде всё вышло как надо. Качает пакеты, создаёт репозиторий  и тд. 
  - cd ./docker
  - docker build -t otus:v1 .
  - docker run -d -p 80:80 otus:v1 
  - Репозиторий будет доступен по адресу http://dockerhost_ip/repo
