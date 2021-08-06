#TODAS LAS FUNCIONES AQUI DESCRITAS, TANTO LAS FUNCIONES PARA SOPAS COMO PARA PATRONES ,SON VERSIONES PRELIMINARES QUE POSTERIORMENTE SE ADAPTARAN A CADA CLASE COMO METODOS Y SUFRIENDO LAS MODIFICACIONES PERTINENTES.

#FUNCIONES PARA LA SOPA:

soup = [
    [ 'C', 'A', 'A', 'O', 'C', 'A'],
    [ 'C', 'S', 'O', 'C', 'A', 'C'],
    [ 'O', 'A', 'S', 'A', 'S', 'O'],
    [ 'O', 'C', 'O', 'C', 'A', 'C'],
    [ 'C', 'A', 'C', 'O', 'S', 'O'],
    [ 'O', 'S', 'A', 'S', 'A', 'C'],
    [ 'A', 'A', 'C', 'O', 'C', 'A']
]


#definicion funcion conteo de columnas    
def num_cols(soup):
    for l in soup:
        if len(soup[0]) == len(l):
            lengths = True
        else:
            lengths = False
            return -1
            break 
    if lengths == True:
        soup_cols = len(soup[0])
        return soup_cols
 
        
#definicion funcion conteo de filas     
def num_rows(soup):
    soup_rows = len(soup)
    return soup_rows

        
#definicion función matching_at con funciones num_rows y num_cols integradas en su defincion-comprobacion de patron
def matching_at(row,col,soup):
    try:
        Maxcols=num_cols(soup)
        Maxrows=num_rows(soup)
    except:
        print('Please, introduce a valid soup')
    print('Verifying pattern at position ['+str(row)+','+str(col)+']')
    if (row+2 > Maxrows-1) or (col+2 > Maxcols-1):
        print('The positions introduced are out of the range of the soup') #Aqui prevenimos que haya un IndexError
    else:
        try:
            if     soup[row][col] == 'C' \
               and soup[row][col+1] == 'A' \
               and soup[row+1][col+1] == 'S' \
               and soup[row+1][col+2] == 'O' \
               and soup[row+2][col+1] == 'A':
                return True
            else :
                return False   
        except IndexError:
            print('Error!The positions introduced are out of the range of the soup') #Aqui directamente capturamos el IndexError en caso de que salte(es otra forma de afrontar el problema menos especifica)


#Definicion de la funcion par retorno de valor de la sopa en una posicion dada
def at(soup,r,c):
    try:
        return (soup[r][c])
    except IndexError:
        print('Error!The positions introduced are out of the range of the soup')
                


#Definición de la funcion para cargar la sopa
def load_soup(ruta):
    file = open(ruta,'r')
    soup = []  
    for line in file:
        soup.append(list(line))    
    for row in soup:
        if '\n' in row:
            row.remove('\n')        
        while '\t' in row:
            row.remove('\t')
    for row in soup: #comprobación de si hay espacios en la sopa, si existen espacios , en cuanto se detecte uno space=True y se rompera el bucle, en caso de no haber en toda la sopa ,space = False
            if ' ' in row:
                space = True
                break
            else:
                space = False
    if (num_cols(soup) == -1) or (space == True):  #si la sopa no siene todas las filas de igual longitud, es decir esta incompleta, o contiente espacioes en esta, se lo notificaremos al usuario.
        print('Your soup is invalid , because not all rows have the same length, or because the soup contains spaces.(If you have included spaces in the soup as characters that admit any alphanumeric character, change the " " into ".")')
    return soup

  

#FUNCIONES PARA PATRONES:


#Función para conteo de filas en el patron  
def num_rowsp(pattern):
    pattern_rows = len(pattern)
    return pattern_rows


#Funcion para el conteo de columnas en el patron    
         
def num_colsp(pattern):
    for row in pattern:
        if len(pattern[0]) == len(row):
            lengths = True
        else:
            return -1
            lengths = False
            break 
    if lengths == True:
        pattern_cols = len(pattern[0])
        return pattern_cols
            
#Función parra cargar un patron
def load_pattern(rutapatron):
    file = open(rutapatron, 'r')
    pattern = []
    for line in file:
        pattern.append(line.split())
    for row in pattern:
        if '\n' in row:
            row.remove('\n')
        while '\t' in row:
            row.remove('\t')
    if (num_colsp(pattern) == -1):
        print('please,enter a valid pattern')
        return None
    return pattern


pattern = load_pattern('C:/Users/Sergio/Desktop/data/pattern 1.txt')  

#Función matching_at() modificada para aceptar patrones diferentes

def matching_at2(pattern,row,col,soup):
    if num_cols(soup) == -1:
        print('Some colum elements are missed in the soup')
    elif num_colsp(pattern) == -1:
        print('Some colum elements are missed in the pattern')
    else:
        Maxcols = num_cols(soup)
        Maxrows = num_rows(soup)
        rowsp = num_rowsp(pattern)
        colsp = num_colsp(pattern)
        if ((len(soup [row][0:col]) + colsp) > Maxcols) or (len(soup[0:row]) + rowsp > Maxrows):
            print('The positions introduced are out of the range of the soup')
        else:
            try:
                match=0
                for r in range(len(pattern)):
                    for c in range(len(pattern[0])):
                        if (pattern[r][c] == soup[row+r][col+c]) or pattern[r][c] == '.':
                            match += 1
                        else:
                            break
                if match == (len(pattern))*(len(pattern[0])):
                    return True
                else:
                    return False
            except IndexError:
                print('Error!The positions introduced are out of the range of the soup')

#Función single_cell_match:
def single_cell_match(pattern_cell,soup_cell):
    try:
        if (pattern_cell == soup_cell) or pattern_cell == '.':
            return True
        else:
            return False
    except:
        ('please,introduce the parameters appropiately-eg.pattern[r][c],soup[r][c]')


    

#Funciones rotaciones y simetria axial
def rotate90(pattern):
    iterator=list(range(-len(pattern[0]),0))
    rotated90= []
    for c in iterator[::-1]:
        lists=[]
        for r in range(len(pattern)):
            lists.append(pattern[r][c])    
        rotated90.append(lists)
    return rotated90

def rotate180(pattern):
    rotated180=[]
    for r in pattern[::-1]:
        rotated180.append(r[::-1])
    return rotated180

def rotate270(pattern):
    rotated270=[]
    iterator2=list(range(-len(pattern),0))
    for c in range(len(pattern[0])):
        lists=[]
        for r in iterator2[::-1]:
            lists.append(pattern[r][c])    
        rotated270.append(lists)
    return rotated270

def axial(pattern):
    axialsym = []
    for r in pattern:
        axialsym.append(r[::-1])
    return axialsym

def axial90(pattern):
    axial90=rotate90(axial(pattern))                      
    return axial90

def axial180(pattern):
    axial180=rotate180(axial(pattern))
    return axial180

def axial270(pattern):
    axial270=rotate270(axial(pattern))
    return axial270



