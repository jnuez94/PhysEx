%{ open Ast %}

/* Token definitions */
%token EOF
%token PLUS MINUS TIMES DIVIDE
%token ASN
%token NULL TRUE FALSE
%token INT STR FLT BOOL
%token SEMICOLON

%token <int> NUM_LITERAL
%token <float> FLOAT_LITERAL
%token <string> VARIABLE

/* Associativity definitions */
%right ASN
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

	/* Operations */
	| expr ASN expr				{0}
	| expr PLUS expr			{0}
	| expr MINUS expr			{0}
	| expr TIMES expr			{0}
	| expr DIVIDE expr		{0}
