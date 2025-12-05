data = ""

with open("input.txt", "r") as f:
    data = f.read()
    data = data.split("\n")
counter = 0
lock = 0
def updateCounter():
      if lock == 0:
          counter += 1
def rotateL(getal):
    lock += getal % 99
    updateCounter()
def rotateR(getal):
    lock -= getal % 99
    updateCounter()

for item in data:
      if item[0] == "L":
          rotateL(item[1:])
      else:
          rotateR(item[1:])

print(counter)
