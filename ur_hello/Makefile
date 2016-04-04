.PHONY: clean build
all: run

clean:
	rm -rf *~
	rm -rf \#*

distclean: clean
	rm -rf ur_hello.exe

ur_hello.exe:
	urweb -dbms sqlite ur_hello

init_sql:
	rm -rf ur_hello
	sqlite3 ur_hello<ur_hello.sql

build: ur_hello.exe init_sql

run: ur_hello.exe
	./ur_hello.exe -p 9999

