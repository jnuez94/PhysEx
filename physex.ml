let _ =
	let lexbuf = Lexing.from_channel stdin in
		let ast = Parser.prgm Scanner.token lexbuf in
			Semantic.checker ast;
