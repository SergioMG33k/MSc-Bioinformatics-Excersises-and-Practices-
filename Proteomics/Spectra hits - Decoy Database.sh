#!/bin/bash

conda create -y -n intro_proteomics #partiendo de que se tiene conda instalado
                                    # la opcion -y (yes), indica que no se pregunte por la confirmacion en la instalacion 
                                    #la opcion -n(o -name), es para indicar el nombre del environment

source activate intro_proteomics

conda install -y proteowizard #Se es necesario tener el canal de Bioconda habilitado
			      #Para instalar este paquete y posteriores
			      #no lo utilizamos en el script , pero lo dejamos instalado en el environment, por si el usuario quiere hacer transformaciones de formato con msconvert de los archivos de spectras

cat data/PXD000618/files #se muestra el contenido de files 

wget -i data/PXD000618/files -P data/PXD000618  #se descargan los archivos a partir de las URL contenidas en files, -P, para incicar el path donde se guardaran los archivos descargados

mkdir -p resources/proteome #con la opcion -p, creamos todos los directorios indicados en la ruta en un paso
wget ftp://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000005640_9606.fasta.gz -P resources/proteome #descargamos el proteoma humano en formato .gz , y con -P indicamos el path de salida de la descarga
gunzip resources/proteome/UP000005640_9606.fasta.gz  #descomprimimos el archivo .gz, con gunzip, y nos quedamos con con el proteoma en formato fasta , en la carpeta donde esta el .gz por defecto(ya que no se indica una ruta diferente)

conda install -y decoypyrat   #instalamos el paquete decoypyrat en el environment, para poder realizar la decoy database de manera local a partir del proteoma
decoypyrat resources/proteome/UP000005640_9606.fasta -o resources/proteome/UP000005640_9606.decoy.fasta --decoy_prefix DECOY #generamos una base de datos con los decoy , generados a partir del fasta del proteoma original , con la opccion --decoy prefix, establecemos un prefico para marca a los elementos "señuelo"(DECOYS), y asi saber cuando el hit ha sido contra un señuelo o contra un target mas adelante, con el fin de ayudarnos a estimar por ejemplo el FDR
cat resources/proteome/UP000005640_9606.fasta resources/proteome/UP000005640_9606.decoy.fasta > resources/proteome/UP000005640_9606.target-decoy.fasta #generamos el conjunto de datos en los que se combinan los target del fasta original y los DECOYS , generados en el comando anterior

conda install -y crux-toolkit #instalamos el paquete crux
crux comet --num_threads 3 --spectrum_batch_size 5000 --output-dir output/comet --overwrite T --output_txtfile 0 data/PXD000618/*.mgf resources/proteome/UP000005640_9606.target-decoy.fasta
#con crux comet , hacemos una busqueda de matches enfrentando los spectras a la decoy database creada previamente , y obtendremos los hits contra esta base de datos.Con las opcion --num_threads, nosotros podemos dividir la tarea en varios trabajos(hilos)paralelos, y mediante la opcion --spectrum_bath_size 5000, nosotros indicamos que se tiene que ir ir comprobando los spectran contra la base de datos de 5000 en 5000, esta manera conseguimos que no se sature la RAM, y no se "mate", el proceso
crux assign-confidence --output-dir output/assign-confidence --overwrite T --decoy-prefix DECOY_ output/comet/*.pep.xml  
crux percolator --output-dir output/percolator --overwrite T --decoy-prefix DECOY_ output/comet/*.pep.xml 
#Con los ultimos dos comandos nosotros utilizamos las funcionalidades de crux, assign-confidence y percolator, para analizar los xml obtenidos en el comet y obtener diferentes datos estadisticos,mediante los que podemos extraer , FDS, Q-mean, entre otros.La opcion --overwrite utilizada en diferentes comandos, es para indicar , que si el output donde se generaran los archivos ya existe, se sobreescrbia(mostrando un wrning), y de tal manera no muestre un error diciendo que ya existe y se interrumpa la ejecución del codigo
