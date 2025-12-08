with open("test_input.txt", "r") as f:
    data = [line.strip() for line in f.readlines()]


def parse_data(data):
    return [list(map(int, line.split(","))) for line in data]


def get_distance(point1, point2):
    print(point1)
    print(point2)
    return (
        abs(point1[0] - point2[0])
        + abs(point1[1] - point2[1])
        + abs(point1[2] - point2[2])
    )


distances = []

for i in range(len(data)):
    for j in range(i + 1, len(data)):
        distances.append(get_distance(data[i], data[j]))

for distance in distances:
    print(distance)
