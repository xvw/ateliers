.PHONY: npi np
all: np npi

%.cmo : %.ml
	ocamlc -c $(<)

npi: parser.cmo
	ocamlc $(<) $(@).ml -o $(@)

np: parser.cmo
	ocamlc $(<) $(@).ml -o $(@)

clean:
	rm -rf *.cm*
	rm -rf npi
	rm -rf np
	rm -rf *~
