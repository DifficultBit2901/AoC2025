clean: bin
	rm -rf bin/*

bin:
	mkdir bin

bin/part1: bin
	rustc part1.rs -o bin/part1

p1t: bin/part1
	./bin/part1 test.txt

p1: bin/part1
	./bin/part1 input.txt

bin/part2: bin
	rustc part2.rs -o bin/part2

p2t: bin/part2
	./bin/part2 test.txt

p2: bin/part2
	./bin/part2 input.txt
