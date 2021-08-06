def load_dictionary(rutaD = None):
    if rutaD==None:
        return {}
    else:
        file = open (rutaD, 'r')
        diclist = []
        dictionary ={}
        for line in file:
            if line[0] != '#' and line != '\n':
                diclist.append(list(line))        
        for element in diclist:
            while '\t' in element:
                 element.remove('\t')
            while '\n' in element:
                 element.remove('\n')
            while ',' in element:
                 element.remove(',')
            while ' ' in element:
                element.remove(' ')
        while [] in diclist:
            diclist.remove([])
        for element in diclist:
            i = element.index(':')
            key = ','.join(element[0:i])
            value = element [i+1:]
            dictionary[key] = value
        return dictionary
    
