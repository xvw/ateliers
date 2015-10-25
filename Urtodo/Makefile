DBNAME = todolist
URP    = todo

.PHONY: init clean
all: run
build: recompile

init:
	rm -rf $(DBNAME)

clean:
	rm -rf *~
	rm -rf \#*
	rm -rf *.exe
	rm -rf *.sql

compile:
	urweb -dbms sqlite $(URP)

recompile: init compile
	sqlite3 $(DBNAME) <$(URP).sql

run:
	./$(URP).exe -p 9999
