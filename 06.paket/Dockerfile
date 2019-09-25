FROM centos:centos7

RUN yum install -y wget openssl sed createrepo &&\
    yum -y autoremove &&\
    yum clean all &&\
    wget https://nginx.org/packages/rhel/7/x86_64/RPMS/nginx-1.16.1-1.el7.ngx.x86_64.rpm &&\
    rpm -iv nginx-1.16.1-1.el7.ngx.x86_64.rpm &&\
    wget -P /data/www/repo http://81.3.176.218:5002/repo/mc-4.8.7-11.el7.x86_64.rpm &&\
    wget -P /data/www/repo http://81.3.176.218:5002/repo/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm &&\
    createrepo /data/www/repo

COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

