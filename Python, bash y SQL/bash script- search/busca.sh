#!/bin/bash
if [ ! $# -eq  3 ]; then
	 echo -e "Faltan parametros, es necesario indicar [rutabusqueda][regexp][archivosalida]"
	exit
fi

if [ ! -d "$1" ]; then
	echo "El parametro 1 debe ser un directorio valido"
	exit
fi

if [ -z "$2" ]; then
	echo "Parametro 2 no valido"
	exit
fi

if [ -z "$3" ]; then
	echo "Parametro 3 no valido"
	exit
fi

if [ -f "$3" ]; then
	echo "El archivo $3 ya exite¿desea sobreescribirlo?y/n"
	read resp
	if [ $resp = "y" ]; then
		rm "$3"
	elif [$resp = "n" ];then
		exit
	else
		echo "Respuesta no valida"
		exit
	fi 
fi

tmpfile=$(mktemp /tmp/abc-busca.XXXXXX)
alldirs=$(find $1/* -type f)

for directory in $alldirs
do
	((allcounts=0))
	for  cadena in $2
	do
		count=$(grep -o  $cadena $directory | grep -c $cadena)
		((allcounts=$allcounts+$count))
	done
	basename_file=$(basename $directory)
	dir_file=$(dirname $directory)
	if [ $allcounts -gt 0 ]; then
		echo "$basename_file	$dir_file	$allcounts" >>$tmpfile
	fi
done

sort -n -r -k3 $tmpfile >$3

rm $tmpfile
