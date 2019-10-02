**docker**

- Создавал образ с использование Dockerfile.
  - cd ./docker
  - docker build -t otus.nginx.alpine:v1 .
  - docker run -d -p 80:80 otus.nginx.alpine:v1
  - docker ps -a
- Добавление на dockerhub
  - docker login -> **login,pass доступны после регистрации на https://hub.docker.com/**
  - docker images -> **здесь можно посмотреть id созданого образа**
  - docker tag image_id 151082/otus.nginx.alpine:v1 
  - docker push 151082/otus.nginx.alpine
- Проверка
  - docker pull 151082/otus.nginx.alpine:v1
  - docker run -d -p 80:80 151082/otus.nginx.alpine:v1 ->  **можно одну эту команду без предыдущей**.  

https://cloud.docker.com/u/151082/repository/list

Образ это набор слоёв которые описывают в **Dockerfile** и далее собирают командой **docker build**.  
Условно говоря контейнер создают из образа командой **docker run**. Контейнер это запущенный экземпляр образа.  


Можно ли в контейнере собрать ядро? - Делал домашку по пакетам и репозиториям оттуда остался образ, доставил в него необходимый для сборки ядра софт, загрузил исходники и тд, ну и самое простенькое ядро собралосью  
Так что да, собрать ядро можно.
