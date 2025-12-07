with open("input.txt") as f:
    grid = f.read().splitlines()

H = len(grid)
W = len(grid[0])

blocks = {}
for x, ch in enumerate(grid[0]):
    if ch == "S":
        blocks[x] = 1

for y in range(1, H):
    new_blocks = {}

    for x, count in blocks.items():
        cell = grid[y][x]

        if cell == "^":
            new_blocks[x - 1] = new_blocks.get(x - 1, 0) + count
            new_blocks[x + 1] = new_blocks.get(x + 1, 0) + count
        else:
            new_blocks[x] = new_blocks.get(x, 0) + count

    blocks = new_blocks

print(sum(blocks.values()))
