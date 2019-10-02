**docker**

- Создавал образ с использование Dockerfile, в котором прописывал копирование конфига nginx и страницы по умолчанию 
  - cd ./docker
  - docker build -t otus.nginx.alpine:v1 .
  - docker run -d -p 80:80 otus.nginx.alpine:v1
  - docker ps -a
- Добавление на dockerhub
  - docker login **(login,pass доступны после регистрации на https://hub.docker.com/)**
  - docker images **здесь можно посмотреть id созданого образа**
  - docker tag image_id 151082/otus.nginx.alpine:v1 
  - docker push 151082/otus.nginx.alpine
- Проверка
  - docker system prune -fa **тут надо осторожней, команда потрёт все незапущенные image в системе**
  - docker pull 151082/otus.nginx.alpine:v1
  - docker run -d -p 80:80 151082/otus.nginx.alpine:v1  


