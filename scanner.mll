{ open Parser }

rule token = parse
		[' ' '\t' '\r' '\n']	{ token lexbuf }
	|	"//"									{ comment lexbuf}

	|	eof												{ EOF }
	|	':'												{ COLON }
	| ';'												{ SEMICOLON }
	| ','												{ COMMA }

	| ['0'-'9']+ as lit																												{ NUM_LITERAL(int_of_string lit) }
	| ['0'-'9']+ '.' ['0'-'9'] as lit																					{ FLOAT_LITERAL(float_of_string lit) }
	| ['$' '_' 'a'-'z' 'A'-'Z'] ['$' '_' '-' 'a'-'z' 'A'-'Z' '0'-'9']* as lit { ID(lit) }

	| "null"	{ NULL }
	| "true"	{ TRUE }
	| "false"	{ FALSE }

	|	'=' { ASN }
	| '+'	{ PLUS }
	| '-' { MINUS }
	| '*' { TIMES }
	| '/' { DIVIDE }

	| '(' { L_PAREN }
	| ')' { R_PAREN }
	| '{' { L_BRACE }
	| '}' { R_BRACE }
	| '[' { L_BRACKET }
	| ']' { R_BRACKET }

	| "||"	{ OR }
	| '!'		{ NOT }
	| "&&"	{ AND }

	| "int"			{ INT }
	| "string"	{ STR }
	| "float"		{ FLT }
	| "bool"		{ BOOL }
	| "blob"		{ BLOB }

	| "if"			{ IF }
	| "else"		{ ELSE }
	| "else if"	{ ELIF }

	| "for"			{ FOR }
	| "while"		{ WHILE }

	| "return"		{ RETURN }
	| "function"	{ FUNCTION }
	| "stimulus"	{ STIMULUS }

and comment = parse
		['\r' '\n']		{ token lexbuf }
