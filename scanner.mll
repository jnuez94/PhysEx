{ open Parser }

rule token =
	parse [' ' '\t' '\r' '\n']	{ token lexbuf }
	|	eof												{ EOF }
	| ';'												{ SEMICOLON }

	| ['0'-'9']+ as lit																												{ NUM_LITERAL(int_of_string lit) }
	| ['0'-'9']+ '.' ['0'-'9'] as lit																					{ FLOAT_LITERAL(float_of_string lit) }
	| ['$' '_' 'a'-'z' 'A'-'Z'] ['$' '_' '-' 'a'-'z' 'A'-'Z' '0'-'9']* as lit	{ VARIABLE(int_of_char lit.[1] - 48) }

	| "null"	{ NULL }
	| "true"	{ TRUE }
	| "false"	{ FALSE }

	|	'=' { ASN }
	| '+'	{ PLUS }
	| '-' { MINUS }
	| '*' { TIMES }
	| '/' { DIVIDE }

	| '(' { LPR }
	| ')' { RPR }
	| '{' { LBR }
	| '}' { RBR }

	| "||"	{ OR }
	| '!'		{ NOT }
	| "&&"	{ AND }

	| "int"			{ INT }
	| "string"	{ STR }
	| "float"		{ FLT }
	| "bool"		{ BOOL }

	| "if"			{ IF }
	| "else"		{ ELSE }
	| "else if"	{ ELIF }
