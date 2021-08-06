from LetterSoupClass import *
from PatternClass import *

print("\n\n   TEST 1")
p1 = Pattern(filename="Data/p1.txt")
print(p1)
s1 = LetterSoup("Data/soup1.txt")
print(s1)
print("All fix matches:\n", p1.all_matches(s1))
print("All flexible matches:\n", p1.all_matches(s1,flex=True)) 

print("\n\n   TEST 2")
s2 = LetterSoup("Data/soup2.txt")
print(p1)
print(s2)
print("All fix matches:\n", p1.all_matches(s2))
print("All flexible matches:\n", p1.all_matches(s2,flex=True)) 

print("\n\n   TEST 3  USING A DICTIONARY")
p3= Pattern(filename="Data/p3.txt",dictfilename="Data/dict one.txt")
s3 = LetterSoup("Data/soup3.txt")
print(p3)
print(s3)
print("All fix matches:\n", p3.all_matches(s3))
print("All flexible matches:\n", p3.all_matches(s3,flex=True)) 


print("\n\n   TEST 4  USING PATTERN WITH SPECIAL SYMBOL ^ ")
p4= Pattern(filename="Data/p4.txt",dictfilename="Data/dict one.txt")
s3 = LetterSoup("Data/soup3.txt")
print(p4)
print(s3)
print("All fix matches:\n", p4.all_matches(s3))
print("All flexible matches:\n", p4.all_matches(s3,flex=True)) 

