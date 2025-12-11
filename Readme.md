# Advent of Code 2025

A collections of my solutions for each of the 12 days of 2025's *Advent of Code*.
I had the goal of using a different language for each day.

## Running

To run a program you can cd into a day's directory. Each day has the following structure:
- A file called "common" with the languages extension containing code for both parts
- A file called "part1" and one called "part2" with the languages extension, each containing a main function and the code for the specified part
- input.txt and test.txt, containing the puzzle *input* and the *test* example
- A GNU Makefile with the following rules/targets:
    - p1: Builds the part 1 code (if needed) and runs it with the puzzle input
    - p1t: Builds the part 1 code (if needed) and runs it with the test example
    - p2: Builds the part 2 code (if needed) and runs it with the puzzle input
    - p2t: Builds the part 2 code (if needed) and runs it with the test example
    - clean: Removes build artefacts
- Both part 1 and part 2 take a file path and treat it as the puzzle input, outputting the result to standard out

Everything was tested to work on linux, other OSs aren't guaranteed to work

## Dependencies/Requirements

### Day 1
- C3 Compiler

### Day 2
- gcc 

### Day 3
- Zig Compiler

### Day 4
- python3

### Day 5
- Rust Compiler
