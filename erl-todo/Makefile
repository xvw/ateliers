EBIN = ebin
SRC  = src
SH   = todo.sh
INC  = include
DEPS = boot.beam initialize.beam

all: $(DEPS) folders

install: all
	erl -I $(INC) -pa $(EBIN) -s initialize do_once -noshell
	chmod +x $(SH)

folders:
	mkdir -p $(EBIN)

%.beam : $(SRC)/%.erl folders
	erlc -I $(INC) -pa $(EBIN) -o $(EBIN) $(<)

clean:
	rm -rf todo.sh
	rm -rf ebin/*.beam
	rm -rf erl_crash.dump
