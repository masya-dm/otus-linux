1. Увеличил количество дисков в Vagrant файл. 
2. Проверил Vagrant файл командой vagrant validate и запустил vagrant up. 
3. После скачивания бокса, его запуска  и применения настроек залогинился проверил vagrant global-status и залогинился vagrant ssh id_machine.
4. sudo -i после чего с помощью команд lshw -short | grep disk и lsblk проверил все ли диски из Vagrant файла подключились к системе.
5. Собрал raid 10 командой mdadm --create --verbose /dev/md10 -l 10 -n 4 /dev/sd{b,c,d,e}
6. Проверил всё ли в порядке командами cat /proc/mdstat, mdadm -D /dev/md10.
7. Решил проверить соберётся ли raid без добавления о нём информации в /etc/mdadm/mdadm.conf, перезагрузил машину не создавая указанный файл. Перезагрузка показала что всё успешно собралось ))Попробовал выключить и включить.
	И тоже раид собирался. 
8. Пометил один из дисков массива как сбойный - mdadm /dev/md10 -f /dev/sdd и полностью удалил его из массива mdadm /dev/md10 -r /dev/sdd. 
9. Вернул диск в массив mdadm /dev/md10 -a /dev/sdd, проверил что всё собралось.
10. Создал файл mdadm.conf с использованием echo "DEVICE partitions" > /etc/mdadm/mdadm.conf и mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf 
