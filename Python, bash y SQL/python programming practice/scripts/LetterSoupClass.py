
#clase con metodos integrados y constructor

class LetterSoup:
    ruta = str
    soup = []
    soup_cols = None
    soup_rows = None
    invalidsoup=0
    
    def __init__(self,ruta):
        self.ruta = ruta
        
        file = open(ruta,'r')   #establecemos una coxeion con el archivo en el disco de la maquina, una vez abierto el archivo podremos leerlo, con meotods como readlines, o relizando bucles que vayan recorriendo las lineas del archivo
        soup = []
        
        for line in file:      #Recorremos cada linea del archivo en un buclefor, y pasamos todos sus caracteres de cadena de caracteres , como elementos de una lista.Asi generamos la lista de listas con lo que contiene el documento de la sopa
            soup.append(list(line))
        file.close()     #cortamos la conexion con el archivo del disco para que pueda ser abierto por otros programas
        for row in soup:     #recorremos cada lista de la lista de listas pattern, con el fin de eliminar los saltos de linea '\n'
            if '\n' in row:
                row.remove('\n')        
            while '\t' in row:   #recorremos cada lista de la lista de listas pattern, y eliminamos todos los '\t' que puedan hbaer con un while
                row.remove('\t')
        for row in soup: #comprobación de si hay espacios en la sopa, si existen espacios , en cuanto se detecte uno ,space=True y se rompera el bucle, en caso de no haber en toda la sopa ,space = False
            if ' ' in row:
                space = True
                break
            else:
                space = False
        for l in soup:#Comprobamos si todas las longitudes de las rows son iguales ,aqui no he llamado a la funcion num_cols de la manera LetterSoup(ruta).num_cols(), porque si haces eso en un metodo __init__ se produce una llamada recursiva infinita del __innit__ y tendriamos error
            if len(soup[0]) == len(l):
                longitudes = True
            else:
                longitudes = False
                break 
        self.soup = soup 
        if (longitudes == False) or space == True :    #si la sopa no siene todas las filas de igual longitud, es decir esta incompleta, o contiente espacioes en esta, se lo notificaremos al usuario.
            print('Your soup {} is invalid , because not all rows have the same length, or because the soup contains spaces.(If you have included spaces in the soup as characters that admit any alphanumeric character, change the " " into ".")'.format(ruta))
            print('You can try the method .repair_invalidsoup() in order to delete ilogical spaces,turn spaces into points, and get all the rows with the same leght in the soup {}'.format(ruta)) #damos la opcion al usuario de reparar la sopa , dandole a conocer el metodo implementado llamado .repair_invalidsoup()
            invalidsoup = 1     #si la sopa no es valida por lo anteriormente dicho, establecemos el atributo de clase invalidsoup como 1, indicando que es una sopa no valida
            self.invalidsoup=invalidsoup
        else:
            invalidsoup = 0
            self.invalidsoup=invalidsoup
            
    def repair_invalidsoup(self):    #el metodo implementado repair_invalidsoup() eliminara los espacios ilogicos,cambiar los espacios por puntos y nos deolvera una sopa totalmente valida que tendra todas sus filas con la misma longitud 
        if self.invalidsoup == 1:
            for row in self.soup:    #En este bucle eliminamos todos los espacios terminales
                while row[-1] == ' ':
                    row.pop()
                    
            lengths= []
            for n,lista in enumerate(self.soup):   #Aquí añadimos a una lista cada lista de la sopa con su indice y longitud asociados
                lengths.append((len(lista),n,lista))
            lengths.sort()    #aqui ordenamos la lista creada, en funcion de la longitud de cada lista(fila de la sopa), ya que la longitud de la fila es el primer elemento en cada una de las listas generadas en el paso anterior)
            longest= lengths [-1][1]    #una vez ordenada la lista de listas lengths, guardamos en un avariable el indice, de la lista con mayor longitud
            for row in self.soup:     #Seguidamente haremos que la sopa tenga todas sus filas de la misma longitud, en base a la fila mas larga
                while len(row) < len(self.soup[longest]):
                    row.append('.')
                    
            for r,row in enumerate(self.soup):#Como ultimo paso reemplazaremos los espacion internos de la sopa , por '.'
                for e,element in enumerate(row):
                    if element == ' ':
                        self.soup[r][e] = '.'
                        
            self.invalidsoup = 0
        if self.invalidsoup == 0:
            print('your soup is already valid')
            
                    
                    
    def __repr__(self):      #al definir el metodo especial __repr__ modificaremos el comportamiento de print , al hacer print del objeto de esta clase, con el fin de mostrar con el print lo que nosotros deseemos.Por efecto al hacer print de un objeto si no hemos definido __repr__ o __print__ , nos mostrara la direccion del objeto per se como instancia.
        if self.invalidsoup == 1:    #Impedimos que se muetre la sopa con este metodo en caso de que la sopa no sea valida
            return 'InvalidSoup from {}'.format(self.ruta)
            
        else:
            return 'This object is a LetterSoup'.format(print(*self.soup,sep='\n'))# si la sopa es valida, nos la motrara alineada,con saltos de linea como separador de cada fila
         
    def num_cols(self):#Metodo para comprbar el numero de columnas en la sopa
            soup = self.soup
            try:
                for l in soup:     #recorriendo cada lista(fila) en la sopa veremos si todas tienen la misma longitud o no
                    if len(soup[0]) == len(l):
                        longitudes = True
                    else:
                        return -1       #si las filas tienen diferente longitud el metodo devolvera -1 tras su llamada.(se rompe el bucle)
                        longitudes = False
                        break 
                if longitudes == True:
                    soup_cols = len(soup[0])
                    self.soup_cols=soup_cols
                    return soup_cols  #si todas las filas tienen la misma longitud,devolvemos el numero de columnas, ademas asignaremos este valor a un atributo de clase, denominado num_cols
            except:    #capturamos cualquier error, con una excepccion,para que la ejecucion del codigo no se interrumpa 
                print('Please, introduce a valid soup')    
    
    def num_rows(self):
        if self.invalidsoup == 1: #en el método para obtener numero de filas, ponemos un filtro preliminar con un IF, para que si la sopa no es valida, este metodo no se ejecute(en num_cols no añadimos esta sentencia condicional preliminar, ya que la propia funcion num_cols está hecha para decirnos si hay una igualdad de longitud en todas las filas, asi que no nos interesa bloquear su ejecución)
            print('this method can not be applied if the soup is invalid')
        else:
            soup=self.soup 
            try:
                soup_rows = len(soup)
                self.soup_rows = soup_rows 
                return soup_rows  #devolvemos el numero de filas
            except:  #excepcion para que en caso de haber algun error no se detenga la ejecucion del codigo restante
                print('Please, introduce a valid soup')

    def at(self,r,c):   #Con este método mostramos el elemento que se encuentra en una posicion dada de la sopa
        if self.invalidsoup == 1:   #impedimos que el metodo funcione si la sopa no es valida
            print('this method can not be applied if the soup is invalid')
        else:
            try:
                soup = self.soup
                return (soup[r][c])
            except IndexError:   #Excepcion para los casos en los que los argumentos que se pasen al metodo, sean posiciones fuera del rango de la sopa
                print('Error!The positions introduced are out of the range of the soup')
          
            




                

