bin:
	@mkdir bin

clean: bin
	rm -rf bin/*

bin/part1: bin part1.c3 common.c3
	c3c compile part1.c3 common.c3 --output-dir bin

p1: bin/part1
	./bin/part1 input.txt

p1t: bin/part1
	./bin/part1 test.txt

bin/part2: bin part2.c3 common.c3
	c3c compile part2.c3 common.c3 --output-dir bin

p2: bin/part2
	./bin/part2 input.txt

p2t: bin/part2
	./bin/part2 test.txt
