FROM debian:buster
RUN apt-get update && apt-get upgrade -y && apt-get install nginx -y

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /data/www/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
	 
