**Nginx**

1. Скомандовать **Vagrant up**.
2. Припивать в **hosts web-srv** с **host_vagrant_ip**.
3. Шагнуть браузером на **http://web-srv**.  \
При запросе клиентом **/** будет проверена **coockie** с названием **server** и содержанием **web-srv**, если её не будет у клиента, то он будет перенаправлен на **/reg** где ему будет добавлена нужная **cookie** и он будет напревлен обратно в **/**.
![alt text](https://github.com/masya-dm/otus-linux/blob/master/26.nginx/return.jpg)