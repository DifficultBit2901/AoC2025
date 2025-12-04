clean: bin
	rm -rf bin/*

bin:
	mkdir bin

bin/p1: bin part1.c common.c common.h
	cc part1.c common.c -o bin/p1

bin/p2: bin part2.c common.c common.h
	cc part2.c common.c -o bin/p2

p1t: bin/p1
	./bin/p1 test.txt

p1: bin/p1
	./bin/p1 input.txt

p2t: bin/p2
	./bin/p2 test.txt

p2: bin/p2
	./bin/p2 input.txt

