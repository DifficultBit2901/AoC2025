clean: bin
	rm bin/*

bin:
	mkdir bin

bin/part1: bin
	zig build-exe part1.zig
	mv part1 bin/part1

p1: bin/part1
	./bin/part1 input.txt

p1t: bin/part1
	./bin/part1 test.txt

bin/part2: bin
	zig build-exe part2.zig
	mv part2 bin/part2

p2: bin/part2
	./bin/part2 input.txt

p2t: bin/part2
	./bin/part2 test.txt
