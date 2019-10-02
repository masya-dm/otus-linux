FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /data/www/index.html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

