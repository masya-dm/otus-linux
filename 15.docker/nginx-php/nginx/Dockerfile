FROM nginx:latest
EXPOSE 80
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.php /var/www/
CMD ["nginx", "-g", "daemon off;"]


