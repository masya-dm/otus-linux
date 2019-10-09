#!/bin/bash

yum install -y nano rsyslog
yes | cp -f /vagrant/conf/client/rsyslog.cong /etc/
systemctl restart rsyslog.service
