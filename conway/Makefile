.PHONY: clean
DEP = lazyList zipper planeZipper

all: game

% : src/%.ml src/%.mli
	ocamlc -I src -c src/$(@).mli
	ocamlc -I src -c src/$(@).ml

game: $(DEP)
	ocamlc -c -I src src/$(@).mli
	ocamlc -c -I src src/$(@).ml
	ocamlc -I src lazyList.cmo zipper.cmo planeZipper.cmo src/$(@).ml -o game

run: game
	ocaml -I src lazyList.cmo zipper.cmo planeZipper.cmo game.cmo

clean:
	rm -rf *~
	rm -rf \#*
	rm -rf */*~
	rm -rf */\#*
	rm -rf src/*.cm*
	rm -rf game
