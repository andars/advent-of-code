.PHONY: test run

test:
	./task.rb sample.txt

run:
	./task.rb input.txt

asm:
	perl task.pl < input.txt > task.s
	as task.s -o task.o
	ld task.o -o task
	./task
