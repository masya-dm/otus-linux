**docker**

- Создание образа, копирование nginx.conf и index.html
  - cd ./docker
  - docker build -t otus.nginx.alpine:v1 .
  - docker run -d -p 80:80 otus.nginx.alpine:v1
  - docker ps -a
- Добавление на dockerhub
  - docker login 
  - docker images
  - docker tag 028c7450bbf1 151082/otus.nginx.alpine:v1
  - docker push 151082/otus.nginx.alpine
- Проверка
  - docker system prune -fa
  - docker pull 151082/otus.nginx.alpine:v1
  - docker run -d -p 80:80 151082/otus.nginx.alpine:v1  

Можно сразу только последнюю команду.
