%{ open Ast %}

/* Token definitions */
%token EOF
%token PLUS MINUS TIMES DIVIDE
%token L_PAREN R_PAREN L_BRACE R_BRACE L_BRACKET R_BRACKET
%token ASN
%token NULL TRUE FALSE
%token OR AND NOT
%token IF ELSE ELIF
%token INT STR FLT BOOL
%token SEMICOLON

%token <int> NUM_LITERAL
%token <float> FLOAT_LITERAL
%token <string> VARIABLE

/* Associativity definitions */
%right ASN
%right NOT
%left OR AND
%left PLUS MINUS
%left TIMES DIVIDE

%start prgm
%type <Ast.program> prgm

%%

prgm:
	| exprs EOF						{0}

exprs:
	|	expr SEMICOLON			{0}

expr:
	/* Literals */
	| TRUE								{0}
	| FALSE								{0}
	| VARIABLE						{0}
	| NUM_LITERAL					{0}
	| FLOAT_LITERAL				{0}

	/* Primitives */
	| FLT									{0}
	| INT									{0}
	| STR 								{0}
	| BOOL								{0}
	| NULL								{0}

	/* Logical Operators */
	| NOT expr						{0}
	| expr AND expr				{0}
	| expr OR	expr				{0}

	/* Arithmetic Operators */
	| expr ASN expr				{0}
	| expr PLUS expr			{0}
	| expr MINUS expr			{0}
	| expr TIMES expr			{0}
	| expr DIVIDE expr		{0}

	/* Arrays */
	| L_BRACKET expr R_BRACKET {0}

	/* Conditional */
	| IF L_PAREN expr R_PAREN L_BRACE expr R_BRACE	{0}
	|	IF L_PAREN expr R_PAREN L_BRACE expr R_BRACE ELSE L_BRACE expr R_BRACE	{0}
	| IF L_PAREN expr R_PAREN L_BRACE expr R_BRACE ELIF L_PAREN expr R_PAREN L_BRACE expr R_BRACE {0}
