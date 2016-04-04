.PHONY: clean build
all: run

clean:
	rm -rf *~
	rm -rf \#*

distclean: clean
	rm -rf ur_hello2.exe

ur_hello2.exe:
	urweb -dbms sqlite ur_hello2

init_sql:
	rm -rf ur_hello2
	sqlite3 ur_hello2<ur_hello2.sql

build: ur_hello2.exe init_sql

run: ur_hello2.exe
	./ur_hello2.exe -p 9999

