let _ =
	let lexbuf = Lexing.from_channel stdin in
		let ast = Parser.program Scanner.token lexbuf in
			Semantic.checker ast;

	print_string (Llvm.string_of_llmodule (Codegen.translate ast))
