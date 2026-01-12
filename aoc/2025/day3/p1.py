with open("input.txt", "r") as f:
    data = [line.strip() for line in f.readlines()]
total = 0
def get_biggest_number(arr) -> int:
    max_num = 0
    index = 0
    counter = 0
    for el in arr:
        num = int(el)
        if num > max_num:
            max_num = num
            index = counter
        counter += 1
    return index

for bank in data:
    max_num_1_index = get_biggest_number(bank)
    index_2 = 0
    full_number = 0
    if max_num_1_index == (len(bank) - 1):
        index_2 = get_biggest_number(bank[:max_num_1_index])
        full_number = int("".join(bank[index_2]+bank[max_num_1_index]))
    else:
        index_2 = get_biggest_number(bank[max_num_1_index:])
        full_number = int("".join(bank[max_num_1_index]+bank[index_2]))
    total += full_number
    print(f"full_number: {full_number}")
print(total)
