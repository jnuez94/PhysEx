build:
	ocamllex scanner.mll
	ocamlyacc -v parser.mly
	ocamlc -c ast.ml
	ocamlc -c parser.mli
	ocamlc -c scanner.ml
	ocamlc -c parser.ml
	ocamlc -c semantic.ml
	ocamlc -c physex.ml
	ocamlc -o physex parser.cmo scanner.cmo ast.cmo semantic.cmo physex.cmo

clean:
	ocamlbuild -clean
	rm -rf scanner.ml parser.ml parser.mli
	rm -rf *.cmx *.cmi *.cmo *.cmx *.o
	rm -rf physex *.pd
