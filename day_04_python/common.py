import sys

def get_input():
    data = []
    if len(sys.argv) < 2:
        print("Usage:", sys.argv[0], "<input-file>")
        return []

    with open(sys.argv[1]) as f:
        for line in f:
            data.append(list(line))
    
    return data


def get_surround_count(data, pos=(0, 0)):
    offsets = [(x, y) for x in range(-1, 2) for y in range(-1, 2) if not (x == 0 and y == 0)]
    count = 0
    for offset in offsets:
        x = pos[0] + offset[0]
        y = pos[1] + offset[1]
        if 0 <= y < len(data) and 0 <= x < len(data[y]):
            if data[y][x] == '@':
                count += 1
    return count
