#!/bin/bash
#------functions
search () {
    echo -e "Ingrese su busqueda\nEjemplo: UPC o descripcion"
    read toSearch
    retString=$(grep "$toSearch" db-bodega.txt)
    echo $retString
}

disLayout () {
    read cont
    items=$(grep $cont db-bodega.txt)
    echo $items > draw.txt
    read -a layout <<<$(cat draw.txt)

    count=0
    for i in "${layout[@]}";
    do
	if [[ "$i" =~ "$cont" ]];
	then
	    echo $i
	    let count=count+1

	    if [ "$count" -ge 2 ];
	    then
		echo "|----|" 
		let count=count-2
	    fi
	fi
    done
}
#-------Main
mainMenu=1
clear
while [ $mainMenu = 1 ]
do
    echo "Ingrese la informacion en orden, o -h para ayuda"
    echo "<UPC> <cont/area> <dep> <pos> <desc>"
    read item
    case $item in
	"-h")
	    echo -e "Opciones\n-h) ayuda\n-s) buscar item\n-d) mostrar contenedor\n-q) salir";;
	"-s")
	    search ;;
	"-d")
	    disLayout ;;
	"-q")
	    echo "saliendo!!" && break;;
	#aqui podriamos utilizar el comando awk para ampliar la informacion
	* )
	    echo $item >> db-bodega.txt && echo "hecho! ";;
     esac
done
