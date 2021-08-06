from LetterSoupClass import *
from PatternDictionary import *
    
class Pattern:
    filename = str
    pattern = []
    pattern_cols = None
    pattern_rows = None
    invalidpattern = 0  
    dictionary = {}
    dictfilename = 0
    
    def __init__(self,filename,dictfilename = 0):
        self.filename = filename
        file = open(filename, 'r')     #establecemos una coxeion con el archivo en el disco de la maquina, una vez abierto el archivo podremos leerlo, con meotods como readlines, o relizando bucles que vayan recorriendo las lineas del archivo
        pattern = []
        for line in file:     #vamos recorriendo cada linea del archivo
            pattern.append(line.split())    #para cada linea con el meodo split, las cadenas de caracteres de la linea se añadiran como elementos de una lista, split cogera por defecto el sepadador espacio, asique los espacios delimitaran los elementos de la lista, con append añadimos esa lista obtenida a la lista de lista que queremos crear denominaa pattern
        file.close()     #cortamos la conexion con el archivo del disco para que pueda ser abierto por otros programas
        for row in pattern:   #recorremos cada lista de la lista de listas pattern, con el fin de eliminar los saltos de linea '\n'
            if '\n' in row:
                row.remove('\n')
            while '\t' in row:    #al recorrer la lista de lista, eliminamos todos los '\t' que pueda haber con un while.
                row.remove('\t')      
        for l in pattern:     #Comprobamos si todas las longitudes de las rows son iguales ,aqui no he llamado a la funcion num_colsp de la manera pattern(ruta).num_colsp(), porque si haces eso en un metodo __init__ se produce una llamada recursiva infinita del innit y tendriamos error
                if len(pattern[0]) == len(l):
                    longitudes = True
                else:
                    longitudes = False     #caso de que se detecte que alguna lista tiene longitud diferente al resto, pasamos la variable longitudes a False, y rompemos el bucle, para que no pueda volverese a cambiar a True , en iteraciones proximas del bucle, quedando asila variable longitudes en false indicandonos que no todas las listas tienen la misma longitud
                    break 
        self.pattern=pattern
        if (longitudes == False):    #si el patron no tiene la misma lingitud en todas sus listas, le asignaremos a un atributo de la clase pattern llamado 'invalidpattern' un 1,indicando que el patron no es valido
            print('Your pattern is invalid , because not all rows have the same length.')
            invalidpattern = 1
            self.invalidpattern=invalidpattern
        else:
            invalidpattern = 0    # en caso de que el patron sea valido y todas las longitudes de las filas sean iguales, el atributo 'invalidpattern' tendra asignado valor 0, indicando asi que no es un patron invalido
            self.invalidpattern = invalidpattern
        try:
            if dictfilename != 0:    #si en la llamada de __init__ hemos pasado algun argumento a dictfilename(que por defecto sera opcional con un valor 0),cargaremos un diccionario asociado al objeto patron que estamos creando.Dicho diccionario cargado, se asignara en el atributo de clase 'dictionary'
                self.dictionary=load_dictionary(dictfilename)    #llamada a la funcion importada load_dictionary del modulo PatternDictionary , para cargar el diccionario a partir de un archivo de texto
                self.dictfilename = dictfilename
        except:
            print('please, introduce a valid dictionary route for the pattern')         #hacemos un try , en caso de haber un error en la carga del deccionario, ejecunamos un mensaje en la excepcion, evitando asi que deje de ejecutarse el codigo restante del programa
            
       
        
        
    def __repr__(self):      #al definir el metodo especial __repr__ modificaremos el comportamiento de print , al hacer print del objeto de esta clase, con el fin de mostrar con el print lo que nosotros deseemos.Por efecto al hacer print de un objeto si no hemos definido __repr__ o __print__ , nos mostrara la direccion del objeto per se como instancia.
        if self.invalidpattern == 1:      #aqui bloqueamos el uso de esta funcion en caso de que el patron no se a valido
            return 'InvalidPattern'
        else:
            return 'This object is a Pattern'.format(print(*self.pattern,sep='\n'))     #si el patron es vaido ,se mostrara ordenador con sus filas alineadas y con un separador '\n'
        
        
        
    def num_colsp(self):    #Metodo para comprbar el numero de columnas en el patron
        pattern = self.pattern
        try:
            for l in pattern:    #recorriendo cada lista(fila) en el patron veremos si todas tienen la misma longitud o no
                if len(pattern[0]) == len(l):
                    longitudes = True
                else:
                    return -1     #si las filas tienen diferente longitud el metodo devolvera -1 tras su llamada.(se rompe el bucle)
                    longitudes = False
                    break 
            if longitudes == True:
                pattern_cols = len(pattern[0])
                self.pattern_cols=pattern_cols
                return pattern_cols    #si todas las filas tienen la misma longitud,devolvemos el numero de columnas, ademas asignaremos este valor a un atributo de clase, denominado num_colsp
        except:
            print('Please, introduce a valid pattern')    #capturamos cualquier error, con una excepccion,para que la ejecucion del codigo no se interrumpa 
        
        
        
    def num_rowsp(self):
       if self.invalidpattern == 1:
           print('this method can not be applied if the pattern is invalid')    #en el metodo para obtener numero de filas, ponemos un filtro preliminar con un IF, para que si el patron no es valido, este metodo no se ejecute(en num_colsp no añadimos esta sentencia condicional preliminar, ya que la propia funcion num_colsp esta hecha para decirnos si hay una igualdad de longitud en todas las filas, asi que no nos interesa bloquear su ejecucion)
       else:
           pattern=self.pattern
           try:
               pattern_rows = len(pattern)
               self.pattern_rows = pattern_rows 
               return pattern_rows     #devolvemos el numero de filas
           except:     #excepcion para que en caso de haber algun error no se detenga la ejecucion del codigo restante
               print('Please, introduce a valid pattern')
    
    
    
    
    #He definido una metodo para cada rotación, y simetrias.Todas las rotaciones en grados , son hacia la izquierda, es decir en sentido contrario a las agujas del reloj           
    #En todas las rotaciones he ido recorriendo elemento por elemento de cada lista en la lista de listas, en el orden que me interesaba , para que al ir añadiendo los elementos que recorria a la lista de listas resultante, esta devolviera el resultado deseado 
    def rotate90(self):
        if self.invalidpattern == 1:
            print('this method can not be applied if the pattern is invalid')     #bloqueamos la ejecucion del metodo en caso de que el patron no sea valido
        else:
            pattern = self.pattern
            iterator=list(range(-len(pattern[0]),0))     #he creado un iterador para ir dando los indices a las columnas en el orden que me convenia recorrer los elementos de la lista de listas del patron, el iterador lo he creado previamente , para poder aplicarle luego [::-1], y recorrerlo en sentido inverso, que es el que realmente me interesaba.ejemplo.quiero un iterador en el bucle que vaya desde -1 a -7, range(-1,-8) no sive, pero si hago una lista de range(-7,0), y luego la recorro en sentido inverso(lista[::-1]), podre ir dando indices -1,-2,-3,-4,-5,-6,-7 en cada iteración del bucle 
            rotated90= []
            for c in iterator[::-1]:     #valores que ira tomando el indice referente a las columnas al recorrer el patron con slicing
                lists=[]
                for r in range(len(pattern)):    #valores que ira tomando el indice referente a las filas  al recorrer el patron con slicing
                    lists.append(pattern[r][c])    
                rotated90.append(lists)
            return rotated90      #devolvemos la lista de listas con los elementos en el orden que nos interesa, con la rotacion del patron realizada 90º a la izquierda



    def rotate180(self):
        if self.invalidpattern == 1:
            print('this method can not be applied if the pattern is invalid')
        else:
            pattern = self.pattern
            rotated180=[]
            for r in pattern[::-1]:    #para generar una rotacion de 180 grados en el patron , solamente tuve que recorrer las listas del patron en sentido inverso, y los elementos de las listas tambien en sentido inverso.
                rotated180.append(r[::-1])
            return rotated180    #devolvemos la lista de listas con los elementos en el orden que nos interesa, con la rotacion del patron realizada 90º a la izquierda



    def rotate270(self):
        if self.invalidpattern == 1:
            print('this method can not be applied if the pattern is invalid')
        else:
            pattern = self.pattern
            rotated270=[]
            iterator2=list(range(-len(pattern),0))    #en este caso cree una variable iterador para las filas
            for c in range(len(pattern[0])):
                lists=[]
                for r in iterator2[::-1]:
                    lists.append(pattern[r][c])     #como antes, recorremos los elementos en el orden deseado con los valores que van tomando la variable c(para columnas) y r(para filas) en dos bucleas for anidados, vamos añadiendo los valores a una nueva lista de listas, en este caso sera la rotacion270 grados hacia la izquierda del patron(se equivale a una rotacion de 90º hacia la derecha)
                rotated270.append(lists)
            return rotated270



    def axial(self):
        if self.invalidpattern == 1:
            print('this method can not be applied if the pattern is invalid')
        else:
            pattern = self.pattern
            axialsym = []
            for r in pattern:
                axialsym.append(r[::-1])    #para hacer la simetria axial solamente hacemos una lista de listas, en la que los elementos de cada lista estaran invertidos, pero las listas estaran en el orden original
            return axialsym



    def axial90(self):
        if self.invalidpattern == 1:
            print('this method can not be applied if the pattern is invalid')
        else:
            axial=Pattern(self.filename).axial()    #para hacer la rotacion de 90º de la simetria axial, primeramente llamamos al metodo interno de la simetria axial,el cual nos devuelve una lista de listas, la cual rotaremos de la misma forma que hicimos con el codigo de la rotacion de 90ª previamente mostrado.
            iterator=list(range(-len(axial[0]),0))
            axial90= []
            for c in iterator[::-1]:    #volvemos a escribir el codigo para rotar 90º y no llamamos al metodo rotata90, porque estos metodos funcionan con respecto a un objeto , utilizando el atributo patron de dicho objeto, al haber usado ya el metodo .axial() lo que obtenemos es una lista de listas, a esa lista de listas no le podemos aplicar el metodo .rotate90() porque no es un objeto per se.
                lists=[]
                for r in range(len(axial)):
                    lists.append(axial[r][c])    
                axial90.append(lists)
            return axial90    #nos devuleve una lista de listas de la simetria axial del patron rotada hacia izquierda 90º
        
        
    
    def axial180(self):
        if self.invalidpattern == 1:
            print('this method can not be applied if the pattern is invalid')
        else:
            axial=Pattern(self.filename).axial()    #llamamos al metodo .axial() para obtener la lista de listas de simetria axial del patron
            axial180=[]
            for r in axial[::-1]:   #a esa lista de listas resultante le aplicamos la rotacion de 180ª
                axial180.append(r[::-1])
            return axial180   #se devuelve una lista de listas de la simetria axial del patron rotada 180º



    def axial270(self):
        if self.invalidpattern == 1:
            print('this method can not be applied if the pattern is invalid')
        else:
            axial=Pattern(self.filename).axial()    #de la misma forma que en los anteriores , llamamos al metodo  .axial() y en base a la lista de listas resultante, ejecutamos el codigo para rotarla 270º hacia la izquierda(o 90ª a la derecha en su defecto)
            axial270=[]
            iterator2=list(range(-len(axial),0))
            for c in range(len(axial[0])):
                lists=[]
                for r in iterator2[::-1]:
                    lists.append(axial[r][c])    
                axial270.append(lists)
            return axial270   #nos devuelve la lista de listas de la simetria vertical del patron rotada 270º hacia la izquierda



    def single_cell_match(self,pattern_cell,soup_cell,LetterSoup,pattern): #Al definir el metodo implemente los parametros de esta forma, porque hacia mas flexible el uso de mi codigo en este metodo, y para que la implementacion de este metodo al resto de metodos matching(definidos posteriormente) resultara mas sencilla con respecto a las funciones que ya tenia predefinidas
        if LetterSoup.invalidsoup == 1:
          print('this method can not be applied if the soup is invalid'  )    #comprobamos si la sopa no es valida mediante el atributo invalidsoup de la clase LetterSoup para evitar la ejecucion de este metodo en caso de que así sea
        elif self.invalidpattern == 1:
          print('this method can not be applied if the pattern is invalid')    #comprobamos si el patron no es valido con el atributo invalidpattern , para evitar ejecutar el metodo en ese caso
        else:
            soup = LetterSoup.soup
            rp,cp=pattern_cell     #hacemos asignacion multiple de variables a partir de listas pasadas como argumentos del metodo(estas listas, son las coordenadas, del patron y de la sopa respectivamente)
            rs,cs=soup_cell
            if pattern [rp][cp][0] == '^' and pattern [rp][cp][-1] in self.dictionary:     #comprobamos si la celda del patron contiene un simbolo ^ en su primera posicion de la string y si el segundo elemento de la string se encuentra incluido en el diccionario
                if soup[rs][cs] not in self.dictionary[pattern[rp][cp][-1]] :    #Comprobamos que el valor de la celda de la sopa,no este dentro de los valores contenidos en la clave especificca del diccionario,si se cumple esta condicion, se devuelve True
                    return True
                else:
                    return False
            elif pattern [rp][cp][0] != '^' and pattern[rp][cp] in self.dictionary:   #en caso de que no este el simbolo ^,comprobamos si el valor de la celda se encuentra en el diccionario como clave.Para que se ejecutaran la condicion anterior o esta obviamente tendria que haber un diccionario cargado con el patron, sino , estas condiciones directamente se refutaran.
                if soup[rs][cs] in self.dictionary[pattern[rp][cp]] or pattern[rp][cp] == '.' or soup[rs][cs] == '.':    #comprovamos que el valor de la celda de la sopa , se encuentre dentro de los valores contenidos en la clave del diccionario determinada por el valor de la celda patron, si se cumple, se devolvera True
                    return True
                else:
                    return False
            elif (pattern[rp][cp] == soup[rs][cs]) or pattern[rp][cp] == '.' or soup[rs][cs] == '.':    #en caso de que el valor de la celda no este en un diccionario, simplemente comprobamos a si es igual que el de la sopa, si la celda del patron es '.' o la celda de la sopa es  '.' , tambien se devolveria True
                return True
            else:
                return False

               
           
    def matching_at(self,row,col,LetterSoup):
      if LetterSoup.invalidsoup == 1:
          print('this method can not be applied if the soup is invalid')#comprobamos si la sopa o el patron no son validos, para impedir la ejecución del metodo en caso de que sea asi
      elif self.invalidpattern == 1:
          print('this method can not be applied if the pattern is invalid')
      else:
          pattern = self.pattern
          soup = LetterSoup.soup
          rowsp = Pattern(self.filename).num_rowsp()
          colsp = Pattern(self.filename).num_colsp()
          try:
                match=0
                for r in range(len(pattern)):    #para cada posicion en el patron comprobamos que coincida con la posicion correspondiente en la sopa, partiendo de unas coordenadas en la sopa definidas por los parametros row y col
                    for c in range(len(pattern[0])):    #hacemos dos bucles for anidados para ir comprobando cada celda del patron con la de la sopa , utilizando el metodo single_cell_match
                        if Pattern(self.filename,self.dictfilename).single_cell_match([r,c],[row+r,col+c],LetterSoup,pattern) == True:
                            match += 1    #con cada coindicencia de .single_cell_match sumamos un punto a la variable match
                        else:
                            break    #en caso de que alguna celda no tenga coincidencia, se rompe el bucle, no es necesario continuar recorriendolo
                if match == (len(pattern))*(len(pattern[0])):   #SI el numero de matchers sea igual , al numero de elementos que tiene el patron(filas+columnas) se mostara al usuario que el patron coincide en la sopa en la posicion dada y se devolvera True
                    print('The pattern has been found in the soup at',[row,col])
                    return True
                else:   #por otra parte , si el numero de matches no coincide con el numero total de elementos del patron, quiere decir que no todas sus celdas han coincidido con la sopa en una determinada posicion, y se deolvera False
                    return False
          except IndexError:
              print('Error!The positions introduced are out of the range of the soup')    
            
            
            
    def pat_variations(self):     #Diccionario con todas las variaciones posibles del patron
        pat_variations = {'pattern':self.pattern,'rotated90':Pattern(self.filename).rotate90(),'rotated180':Pattern(self.filename).rotate180(),'rotated270':Pattern(self.filename).rotate270(),'axial':Pattern(self.filename).axial(),'axial90':Pattern(self.filename).axial90(),'axial180':Pattern(self.filename).axial180(),'axial270':Pattern(self.filename).axial270() }
        return pat_variations 
         
    def flex_matching_at(self,row,col,LetterSoup):
        if LetterSoup.invalidsoup == 1:
          print('this method can not be applied if the soup is invalid')   #Comprobación preliminar de que tanto la sopa como el patron sean valido, con el fin de ejecutar el codigo si esto es así
        elif self.invalidpattern == 1:
          print('this method can not be applied if the pattern is invalid')
        else:
            allvariations = Pattern(self.filename).pat_variations() 
     #En los casos en los que las variaciones del patron , sean patrones identicos a este patron original, las tendremos que eliminar del diccionario 'variations', para eviter matches duplicados
     #Por ejemplo, en patrones con una sola fila ,el patron original es identico a la simetria axial rotada 180º,la rotacion del patron 90º es identica a la rotacion 270º de la simetria, el patron rotado 180º es identico a la simetria axial del patron, y el patron rotado 270 es identico a la axial rotada 90º, conclusion:en ese caso tendriamos que eliminar la mitad de las variaciones, porque se nos generarias diversas duplicaciones en los matches
            variations = {}
            for clave,valor in allvariations.items():#con este bucle vamos llenando un diccionario nuevo , de manera de que no se repitan los valores de los items del diccionario original,eliminando asi los duplicaods
                if valor not in variations.values():
                    variations[clave]=valor
            hits = []
            hitcount = 0 # En esta variable almacenaremos cuantas variaciones tienen match con la sopa en la posicion dada por col y row
            for v in variations: #Para cada variacion del diccionario sin duplicaciones comprobaremos ti este tiene un match con la sopa
                pattern = variations[v]
                soup = LetterSoup.soup
                rowsp = len(pattern)
                colsp = len(pattern[0])
                try:
                    match=0
                    for r in range(len(pattern)): #Comprobacion de si la variación tiene match con la sopa verificando celda a celda, de la misma manera que se describe en el metodo .matching_at()
                        for c in range(len(pattern[0])):
                            if Pattern(self.filename,self.dictfilename).single_cell_match([r,c],[row+r,col+c],LetterSoup,pattern) == True:
                                match += 1
                            else:
                                break
                    if match == (len(pattern))*(len(pattern[0])):
                        print('The {} has been found in the soup at {}'.format(v,[row,col]))
                        hitcount +=1
                    else:
                        continue
                except IndexError:   #En la excepcion indexerror continuamos el bucle for de las variaciones, ya que en determinados casos , para una posicion en la sopa , algunas variaciones pueden coincidir con la sopa a la vez que otras pueden estar fuera del sango de la sopa, lo que no generaria un error y nos detendria la ejecucion del codigo.Por lo cual no podemos dejar de comprobar las variaciones en esa posicion a pesar de que algunas nos den error por encontrarse fuera del rango de la sopa.Es por esto que tenemos una excepcion para IndexError que continuara las iteraciones del bucle
                     continue  
            if hitcount == 0:   #Si ninguna variacion tiene match con la sopa , devolveremos False
                return False
            if hitcount > 0:   #Si hay variaciones que han tenido match con la sopa, devolveremos el numero de variaciones que han tenido match
                return hitcount
           
    def all_matches(self, LetterSoup,flex=False ):
        if LetterSoup.invalidsoup == 1:
          print('this method can not be applied if the soup is invalid')   #Comprobación preliminar de que tanto la sopa como el patron sean valido,para evitar ejecutar el metodo si esto no se cumple
        elif self.invalidpattern == 1:
          print('this method can not be applied if the pattern is invalid')
        else:
            if flex  == False:    #si flex es False(siendo su valor por defecto como argumento opcional), se iran comprobando si el patron coincide en todas las posiciones de la sopa en las cuales el patron no se salga del rango de la sopa
                pattern = self.pattern
                soup = LetterSoup.soup
                Maxcols = LetterSoup.num_cols()
                Maxrows = LetterSoup.num_rows()
                rowsp = Pattern(self.filename).num_rowsp()
                colsp = Pattern(self.filename).num_colsp()
                hitslist=[]
                for row in range(0,(Maxrows-rowsp)+1):    #Con estos rangos en los bucles for anidados, nos aseguramos que solo se recorra en las posiciones en las que entra el patron.
                    for col in range(0,(Maxcols-colsp)+1):
                        if Pattern(self.filename,self.dictfilename).matching_at(row,col,LetterSoup) == True: 
                            hitslist.append([row,col])    #Para cada posicion recorrida en la sopa, se llamara al metodo matching_at, si este devuelve true , añadiremos a la lista hitlist la posicion en la cual ha habido una coincidencia del patron.
                        else:
                            continue
                return hitslist    #Finalmente se devuelve la lista que mostrara las posiciones en la sopa en las que coincidia el patron
            elif flex == True:    #En el caso de que flex sea igual a False, se irando recorriendo las posiciones en las que el patron no se sale del rango de la sopa, y comprobando si existen coincidencias del patron y todas su variaciones(no suplicadas)
                pattern = self.pattern
                soup = LetterSoup.soup
                Maxcols = LetterSoup.num_cols()
                Maxrows = LetterSoup.num_rows()
                rowsp = Pattern(self.filename).num_rowsp()
                colsp = Pattern(self.filename).num_colsp()
                hitslist=[]
                for row in range(0,(Maxrows-rowsp)+1):
                    for col in range(0,(Maxcols-colsp)+1):
                        count = Pattern(self.filename,self.dictfilename).flex_matching_at(row,col,LetterSoup) #En las posiciones que se recorren de la sopa , esta vez sse ejecuta el metodo flex_maching_at en vez el metodo matching_at(este metodo nos devuelve False , si ninguna variacion tuvo coincidencia en esa posicion o el numero de variaciones que han tenido match)
                        if count != False: 
                            hitslist.append([row,col,'x{}'.format(count)]) #si el metodo flex_matching_at no nos devuelve false, enconces añadiremos a la lista hitlist, la posicion de la sopa en la que hemos encontrado coincidencia, y cuantas variaciones (no dupllicadas) han tenido coincidencia
                return hitslist