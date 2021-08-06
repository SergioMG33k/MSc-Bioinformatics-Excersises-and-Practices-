Sergio Muñoz González

INTRODUCCÓN:
Los scripts presentados para la práctica final del módulo de programación de la asignatura "PROGRAMACIÓN, LINUX Y BASES DE DATOS", sirven para cargar sopas y patrones, realizar búsquedas de patrones en sopas específicas, obtener información de ambos tipos de objetos,
y disponer de métodos internos para manipular dichos objetos,como puede ser realizar rotaciones en patrones.

ARCHIVOS Y CONTENIDO:
En la carpeta scripts, se encuentran:
	-El script de la clase sopa 'LetterSoupClass.py' 
	-El script de la clase patrón 'PatternClass.py'
	-El script 'PatternDictionary.py' con la función para cargar diccionarios
	-El archivo 'SoupLetterClass_and_PatternClass_Test.py' en el cual se encuentra la prueba final de todos los métodos y funcionalidades del código 
	-Los scripts 'PatternEvaluador.py' y 'PatternDictionaryTest.py', para realizar una comprobación rápida de la funcionalidad del código.
	-El archivo 'Soup_and_pattern_functions-py', en el que se encuentran las funciones preliminares a partir de las cuales se creó el código para la práctica final-con el fin de tener fácil acceso a las funciones de las entregas anteriores, y poder ver los cambios y evolución de estas

Dentro de la carpeta scripts, se encuentra la carpeta Data , en la que están los siguientes archivos .txt:
	-p1,p2,p3,soup1,soup2,soup3,bad-cols-soup:archivos de patrones y sopas disponibles en moodle
	-Dict one:archivo diccionario disponible en moodle
	-PatternEvaluador - SalidaEsperada
	-brokensoup1,brokensoup2:dos sopas no validadas con espacios ilógicos y filas con diferentes longitudes.Estas sopas han sido creadas para poner a prueba un método implementado , denominado repair_invalidsoups
	-aapattern,aasoup,aminoacid-groups:Patron,sopa creados para hacer pruebas con el diccionario de aminoácidos entregado por el profesor.

EMPLEO:
	Primeramente se deberán de cargar las sopas, patrones y diccionarios a partir de los documentos de texto de los que se dispongan, generando así objetos de las clases LetterSoup o Pattern.
	Ha de tenerse en cuenta que los patrones y las sopas deberante tener la misma longitud en todas sus filas,se deberá de evitar que estos estén truncados, o que existan espacios en estos, no obstante hay métodos implementados para lidiar con esto.
	Se debe de mantener la carpeta Data(contenedora de los archivos de texto), dentro de la carpeta en la que están los scripts, para no tener que modificar las rutas puestas en las pruebas de codigo
	Una vez cargados, se pueden utilizar diferentes métodos de clase, para ver el número de columnas, de filas, inspeccionar el contenido de celdas concretas, rotar patrones, etc.
	La principal funcionalidad de los scripts es la capacidad para buscar coincidencias de un patrón en una sopa específica.Como se ha mencionado los scripts además incluyen métodos para rotar patrones,
	y por tanto será posible con otros métodos de clase encontrar todas las posiciones en la sopa en las cuales el patrón o alguna de sus variaciones (rotaciones, simetrias...) coinciden.

OBJETIVOS DE LA PRÁCTICA
	Todos los puntos de la práctica han sido realizados, y los resultados de las funcionalidades y métodos que se exigían en la elaboración de la práctica son los esperados.
	Todo el código de los scripts está comentado detalladamente dentro de estos, explicando cualquier aspecto, variación o paso de este.

IMLEMENTACIONES Y VARIACIONES EN EL CÓDIGO.
	-Todas las funciones para obtener cualquier rotación y/o simetría del patrón fueron definidas previamente en la práctica 3, estas rotaciones fueron realizadas hacia la izquierda (sentido anti-horario), en vez de hacia la derecha, no obstante, 
	como he definido métodos para obtener directamente cualquiera de las variaciones del patrón (sin la necesidad de tener que realizar rotaciones iteradas para alcanzar una determinada rotación o simetría rotada), 
	con el método para rotar 270 grados hacia la izquierda el patrón, al final conseguimos el resultado del patrón rotado 90 grados hacia la derecha, y si quisiéramos obtener el patrón rotado 270 grados hacia la derecha, simplemente podriamos aplicar el método para rotar 90 grados(que rotaría 90 grados hacia la izquierda, por lo que es equivalente).
	Por lo tanto es solo como están definidos los nombres de los métodos, ya que sirven para realizar cualquiera de las rotaciones independientemente del sentido en el que se hagan.

	-Se ha implementado un método interno para la clase LetterSoup, llamado 'repair_invalidsoup()', que permite reparar una sopa inicialmente no válida, eliminando espacios ilógicos, sustituyendo espacios internos por '.', y consiguiendo una sopa válida haciendo que todas sus filas tengan la misma longitud.
