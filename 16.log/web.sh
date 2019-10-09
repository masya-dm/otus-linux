#!/bin/bash

yum install -y epel-release nginx nano rsyslog
yes | cp -f /vagrant/conf/client/nginx.conf /etc/nginx
yes | cp -f /vagrant/conf/client/rsyslog.cong /etc/
cp -f /vagrant/conf/client/audit.conf /etc/rsyslog.d/
cp -f /vagrant/conf/client/nginx_error.conf /etc/rsyslog.d/
systemctl restart nginx.service && systemctl restart rsyslog.service
