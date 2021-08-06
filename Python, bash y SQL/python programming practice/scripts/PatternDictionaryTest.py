#!/usr/bin/env python
# coding: utf-8
from PatternDictionary import *

d0 = load_dictionary()
print(d0)
d1 = load_dictionary("Data/dict one.txt")
print(d1)
d2 = load_dictionary("Data/aminoacid-groups.txt")
print(d2)

"""
Salida esperada (excepto saltos de linea
añadidos aquí por legibilidad:

d0 = load_dictionary()
print(d0)

{}

d1 = load_dictionary("Data/dict one.txt")
print(d1)

{'v': ['A', 'E', 'I', 'O', 'U'], 'c': ['C', 'K', 'Q'],
 'b': ['B', 'P', 'D', 'M'], 'z': ['C', 'Z', 'S']}

d2 = load_dictionary("Data/aminoacid-groups.txt")
print(d2)

{'a': ['D', 'N'], 'g': ['E', 'Q'], 'i': ['I', 'L'],
 'h': ['S', 'T', 'H', 'N', 'Q', 'E', 'D', 'K', 'R'],
 'd': ['V', 'I', 'L', 'F', 'W', 'Y', 'M'],
 'r': ['F', 'W', 'Y', 'H'],
 'n': ['V', 'I', 'L', 'M'], 's': ['P', 'G', 'A', 'S'],
 '+': ['K', 'R', 'H'], '-': ['D', 'E']}

"""
