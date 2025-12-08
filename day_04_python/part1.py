import common


def main():
    data = common.get_input()
    count = 0
    for y in range(len(data)):
        for x in range(len(data[y])):
            if data[y][x] == '@':
                if common.get_surround_count(data, pos=(x, y)) < 4:
                    count += 1
    print("Result:", count)


if __name__ == '__main__':
    main()
