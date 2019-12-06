import os

def getHex(x):
  print('v2.0 raw')
  f = open(x, "r")
  lines = f.readlines()
  for l in lines:
    x = l.find('0x')
    print(l[x+2:x+10])
  f.close()

def addencode(file, fileOutput):
  f = open(file, "r")
  r = open(fileOutput,'w')
  lines = f.readlines()
  for l in lines:
    x = l.find('@')
    if(x is not -1):
      l = l[:x]
    l = l.strip()
    if(l == '' or l.find('.print')>=0):
      continue
    if l[0]=='.':
      r.write(l+'\n')
    else:
      r.write('.encode '+l+'\n')
  f.close()
  r.close()

fileAsm = input()
addencode(fileAsm,'encodedAsm.asm')
os.system(r'interpreter encodedAsm.asm > encodedBubbleHex.txt')
getHex('encodedBubbleHex.txt')

os.remove("encodedAsm.asm")
os.remove('encodedBubbleHex.txt')