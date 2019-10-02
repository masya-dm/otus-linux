FROM nginx:alpine

RUN apk update -f && apk upgrade -f

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /data/www/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

