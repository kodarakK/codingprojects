import math

with open("input.txt") as f:
    data = f.readlines()


k = 0
columns = []
str = ""
for i in range(len(data[0]) - 1):
    num = ""
    for k in range(len(data)):
        num += data[k][i]
    columns.append(num)
a = []
b = []
for num in columns:
    if num == "     ":
        a.append(b)
        b = []
        continue
    b.append(num)
if b:
    a.append(b)

total = 0
for row in a:
    op = row[0][-1]
    row[0] = row[0][:-1]
    int_row = [int(el) for el in row]
    if op == "+":
        total += sum(int_row)
    else:
        total += math.prod(int_row)

print(total)
