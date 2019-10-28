**iptables**

- **knocking port** сделал для двух портов - первый **12222**, второй **18223**, после стука в них можно подключаться на **22** порт **inetRouter**.
  - **vagrant ssh centralRouter**
  - **sudo -i**
  - **/vagrant/knock.sh 192.168.255.1 12222 18223**
  - **ssh vagrant@192.168.255.1 -i /vagrant/vagrant.key**
- **inetRouter**
  - добавил проброс порта в **vagrant**  box.vm.network "forwarded_port", guest: 80, host:8080
  - добавил маршрут в сеть 192.168.0.0/24
  - три правила в таблицу **nat**.
  - **http://ext_vagrant_ip:8080**.
