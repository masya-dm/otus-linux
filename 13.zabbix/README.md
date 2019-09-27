**zabbix**

Для комплексного экрана использовал графики из стандартного шаблона **Template OS Linux + шаблон Iostat-Disk-Utilization-Template**.  

**Настройка мониторинга дисков.**
- git clone https://github.com/lesovsky/zabbix-extensions.git
- cd ./zabbix-extensions/files/iostat/  

На стороне zabbix сервера: 
 - **iostat-disk-utilization-template.xml** импортируем через web интерфейс - **Настройка->Шаблоны->Импорт**.
 - Присоединяем его к наблюдаемому хосту - **Настрока->Узлы сети->Выбрать хост->Шаблоны->Соеденить с новыми шаблонами->Выбрать шаблон Iostat-Disk-Utilization-Template->Добавить->Обновить**.  

На стороне клиента:
 - Установить пакет sysstat -> **yum install -y sysstat**.
 - **cd ./zabbix-extensions/files/iostat/**
 - Содержимое iostat.conf скопировать либо в конец файла **/etc/zabbix/zabbix_agentd.conf** либо файл целиком положить в **/etc/zabbix/zabbix_agentd.conf.d/** и  
в раскоментировать строку **Include=/etc/zabbix/zabbix_agentd.conf** в файле **/etc/zabbix/zabbix_agentd.conf**.
 - Скопировать директорию ./scripts в /usr/libexec/zabbix-extensions/ или любую другую директорию, не забыв поправить пути до них в iostat.conf
 - Добавить в cron, **crontab -e -> * * * * * /usr/libexec/zabbix-extensions/scripts/iostat-collect.sh /tmp/iostat.out 60 &>/dev/null**
 - Перезапустить агента zabbix ->  **systemctl restart zabbix-agent.service**  

Примерно через час с небольшим можно будет добавлять графики в комлексный экран наблюдаемого хоста. 
За ошибками и прочим можно смотреть через интерфейс zabbix server - Мониторинг->Последние данные->Наблюдаемый хост->Iostat. 
