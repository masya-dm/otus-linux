#!/bin/bash

f=`find ./ -type f -name '*.log' -mtime -1 -printf "%f" | sed -n '1'p` 	# Переменной f присваивается результат выполнения поиска в текущей директории файлов с маской *.log изменнёных за последние 24 часа. 
							     		# -print "%f" выводит только название файла. sed выводит только первую строку.
n_st=`wc -l $f | awk {'print $1'}`; 					# Пременной n_st присваивается результат подсчёта количества строк в файле, awk выводит только первый столбец. 
res=./mail.txt								# Временный файл для сбора отчёта. После отправки письма уджаляется.

function X_ips {
ips=();		# Массив для несортированных ip адресов
uni=();		# Массив для сортированных ip адресов
a=`sed -n ''$n_st_l','$n_st''p $f | awk {'print $1'}`# sed выводит строки с первой,если первый запуск скрипта, и до подсчитаной в переменной n_st, awk обрезает первый столбец, результат помещается в перменную а, там они живут большой строкой.
for i in echo $a ;  do ips+=($i); done;	# Заполнение массива ips в цикле. Если попросить echo $a, то большая строка переменной a побьётся по пробелу на строки и их можно будет в цикле записать в массив. 					
					# Запись ips+=($i) говорит о том что при каждоой новой строке из $a добавлять новый элемент массива. хоетл было сделать это в одну строку, без выделения переменной a,
					# но потратил много времении и не заборол таки историю с экранированием параметров у sed.
uni=($(printf "%s\n" "${ips[@]}" | sort | uniq -c | sort -rn| head -n "$1";)) # С помощью команды printf выводятся все элементы массива, разделённые переходом на новую строку \n, список сортируется, вычитываются уникальные значения и 
									      # количество их повторений, опять сортируется в обратном порядке - первым станем с наибольшим число повторений и head выводит только указанное при запуске
									      # количество ip адресов. В получившемся масиве данные живут в виде (колличество_повторений ip-адрес).
echo -e " \n	Top "$1" IP\n  "  >> $res; #Добавляет в файл отчёта две новые строки, а между ними Top указанных в параметре скрипта адресов. 
printf "|%s|%s\n--------------------\n" ${uni[@]} >> $res; # ptintf говорит как выводить данные из массива, первая %s это количество повторений, вторая %s эта ip-адрес. Между так называемы элементы таблицы.
							   # Всю эту историю с массивами я затеял чтоб попробовать порисовать таблички с результатами выборок. Вышло так себе, а времени ушло капец. 
							   # Если тот же набор sort, uniq и head применить просто к указанному столбцу, то тоже отсортирует, но хотелось таблички. 
}

function Y_url {
ips=();
uni=();
a=`sed -n ''$n_st_l','$n_st''p $f | awk {'print $11'}`# Здесь всё тоже самое, но для столбца номер 11 из лог файла. 
for i in echo $a ;  do ips+=($i); done;
uni=($(printf "%s\n" "${ips[@]}" | sort | uniq -c | sort -rn| head -n "$1";)) # head тоже берёт $1 параметр, но тут счёт идёт по количеству параметров переданных функции.
echo -e " \n	Top "$1" URL\n  "  >> $res;
printf "|%s|%s\n--------------------\n" ${uni[@]} >> $res;
}
 
function A_code {
    ips=();
    uni=();
    a=`sed -n ''$n_st_l','$n_st''p $f | awk {'print $9'}` # Для 9-го столбца.
    for i in echo $a ;  do ips+=($i); done;
    uni=($(printf "%s\n" "${ips[@]}" | sort | uniq -c | sort -rn;))
    echo -e " \n	All Answer Code\n  "  >> $res;
    printf "|%s|%s\n--------------------\n" ${uni[@]} >> $res;
}

function Err_4 {
    echo -e " \n	All Error\n   "  >> $res;
    sed -n ''$n_st_l','$n_st''p $f | grep -e "404" >> $res # Поиск строк содержащих ошибку 404.
}

function stat_d {
    D1=`sed -n "$n_st_l"p $f |awk {'print $4'} | sed -e 's/^.//' -e 's!/! !' -e 's!/! !' -e 's!:! !'` # Форматирование даты начала обрабатываемого периода, для вставки в отчет. sed удаляет певый символ строки и убирает / 
    D2=`sed -n "$n_st"p $f |awk {'print $4'} | sed -e 's/^.//' -e 's!/! !' -e 's!/! !' -e 's!:! !'`   # тоже для последней строки. 
    echo -e "====$D1 - $D2====\n " > $res;
}

function nt_do {
    echo "Нечего делать"  | mail -s "Статистика" -r nginx@$HOSTNAME $1; #Отправка сообщения о том что нет данных для обработки скриптом. 
# > $res; cat $res							#Сработает при равенстве общего количества строк в файле и количества уже обработанных строк.
#    rm -rf $res
}

function s_mail {
    cat $res  | mail -s "Статистика" -r nginx@$HOSTNAME $1
    rm -rf $res
}

if [ -z $1 ]; 					#Проверка наличия входных параметров.
    then echo "Не задан первый параметр";	#$1 - количество ip адресов с наибольшим количеством запросов, 10 - первые 10 и тд.
elif [ -z $2 ]; 				#$2 - количество запрашиваемых адресов. 5 - первые 5. 
    then echo "Не задан второй параметр";	#$3 - email оправлять отчёт.
elif [ -z $3 ];					
    then echo "Не задан третий параметр";	
else 

if [ "$f" != "$f_l" ];	# Проверка работали ли уже мы с этим файлом. Сравнивается имя обрабатываемого файла. Если это первый запуск скрипта, то результат будет true. Переменная f_l экпортируется в конце этой секции. 
    then n_st_l=1; 	# Задаётся номер начальной строки.
    stat_d; 		# Функция описывающая обрабатываемый временной интервал.
    X_ips $1;		# Функция подсчитывающая top ip адресов с наибольшим количеством запросов, ей передаётся первый параметр скрипта.
    Y_url $2;		# Функция подсчитывающая top запрашиваемых адресов,ей передаётся второй параметр скрипта.
    A_code;		# Функция всех кодов ответа.
    Err_4;		# Функция всех ошибок.
    export n_st_l=$n_st;# После все выборок номер последней обработанной строки присваивается переменной n_st_l и экпортируется в env для последующих запусков скрипта.
    export f_l=$f	# Тоже самое для имени файла. 
    s_mail $3;		# Функция отправки письма с третьим параметром скрипта.
else 			# Если имя файла из переменной f совпадает с именем из f_l то выполняется проверка количества обработанных строк. 
if [ $n_st_l -eq $n_st ]; then nt_do $3; # Если количество обработанных строк совпадает, то есть с момента последнего запуска скрипта строк не добавилось, то вызывается функция отправки письма с телом что делать неего.
else 			# Если количество обратботанных строк не совпадает то повторяется блок вызовов функций, но не указывается номер начально строки. Он возьмётся из n_st_l из env.
    stat_d; 		# 
    X_ips $1;		#
    Y_url $2;		#
    A_code;		#
    Err_4;		#
    export n_st_l=$n_st;#
    export f_l=$f	#
    s_mail $3;		#
fi;
fi;
fi;