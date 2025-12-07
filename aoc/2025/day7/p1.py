with open("test_input.txt") as f:
    data = f.readlines()

count = 0
for i in range(len(data)):
    for j in range(len(data[0]) - 2):
        if i == 0:
            if data[i][j] == "S":
                data[i + 1] = data[i + 1][:j] + "|" + data[i + 1][j + 1 :]
        if data[i][j] == "^" and data[i - 1][j] == "|":
            count += 1
            data[i + 1] = data[i + 1][: j - 1] + "|.|" + data[i + 1][j + 2 :]
        if i != len(data) - 1 and data[i][j] == "|" and data[i + 1][j] == ".":
            data[i + 1] = data[i + 1][:j] + "|" + data[i + 1][j + 1 :]


for line in data:
    print(line)
print(count)

with open("output.txt", "w") as f:
    for line in data:
        f.write(line)
