.PHONY: clean build
all: run

clean:
	rm -rf *~
	rm -rf \#*

distclean: clean
	rm -rf ur_hello3.exe

ur_hello3.exe:
	urweb -dbms sqlite ur_hello3

init_sql:
	rm -rf ur_hello3
	sqlite3 ur_hello3<ur_hello3.sql

build: ur_hello3.exe init_sql

run: ur_hello3.exe
	./ur_hello3.exe -p 9999

