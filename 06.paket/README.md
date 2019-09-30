**nginx и mc**
- Скопировать файл otus.repo в /etc/yum.repos.d 
- Просмотр содержимого репозитория yum repo-pkgs otus-repo list. Через обычный yum list available почему видиться только nginx. Пробовал настроить yum но так и не осилил. 
- Установка пакетов из репозитория yum repo-pkgs otus-repo install.
- nginx собран --with-openssl, mc собран без поддержки smb.  

**docker**  
- docker pull 151082/masya-dm:otus.hw.1
- docker run -it 08105a86bd42 /bin/bash
  - mc -V 
  - nginx -v
