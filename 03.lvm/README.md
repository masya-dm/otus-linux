**ДЗ №3**

Прикладываю 3 файл заполненый утилитой script.  

В первом файле _00 запись действий до первой перезагрузки машины а именно  
 - создание pv на /dev/sdb 
 - создание vg_root и lv_root v vg_root размером 100% свободного пространства
 - создание на lv_root файловой системы
 - монтирование его в /mnt 
 - далее dump раздела / средствами xfsdump
 - монтировнание /dev /proc /sys /boot и /run в /mnt
 - chroot и найстройка grub в новом окружении и редактирование /boot/grub2/grub.cfg

Во втором файле _01 запись действий после первой перезагрузки. Здесь удаляется старый разде / и создаётся новый размером 8G, монтируется в mnt и весь вся процедура dump, mount и настройка grub обратную сторону. 
    Так же в этом файле созадётся раздел /var средствами lvm нгастроивается его зеркалирование. Так же прописывается раздел в fstab для автоматического монтировния при загрузке системы.
    
В третьем файле _02 запись вывода команд после второй перезагруки. Здесь удаляется временный vg_root И собирается home создаётся раздел для snapshot и выполныется восстановление удалённых из /home файлов.
