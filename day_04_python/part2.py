import common


def main():
    data = common.get_input()
    count = 0
    while True:
        positions = []
        for y in range(len(data)):
            for x in range(len(data[y])):
                if data[y][x] == '@':
                    if common.get_surround_count(data, pos=(x, y)) < 4:
                        count += 1
                        positions.append((x, y))
        for (x, y) in positions:
            data[y][x] = '#'
        if len(positions) == 0:
            break
    print("Result:", count)


if __name__ == '__main__':
    main()
