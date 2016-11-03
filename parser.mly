%{ open Ast %}

/* Token definitions */
%token EOF
%token PLUS MINUS TIMES DIVIDE
%token EQ NEQ LT LEQ GT GEQ
%token L_PAREN R_PAREN L_BRACE R_BRACE L_BRACKET R_BRACKET
%token ASN PLSASN SUBASN MULASN DIVASN
%token NULL TRUE FALSE
%token OR AND NOT
%token IF ELSE ELIF FOR WHILE
%token INT STR FLT BOOL BLOB
%token SEMICOLON COMMA COLON
%token FUNC

%token <int> NUM_LITERAL
%token <float> FLOAT_LITERAL
%token <string> VARIABLE

/* Associativity definitions */
%right ASN
%left OR AND
%left EQ NEQ
%left LT LEQ GT GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT

%start prgm
%type <Ast.program> prgm

%%

prgm:
	| decls EOF						{0}

decls:
    /* nothing */ {0}
  | decls fdecl {0}
  | decls exprs {0}

fdecl:
  FUNC VARIABLE L_PAREN formals_opt R_PAREN L_BRACE stmt_list R_BRACE {0}

formals_opt:
    /* nothing */ {0}
  | formal_list {0}

formal_list:
    expr  {0}
  | formal_list COMMA expr {0}

stmt_list:
    /* nothing */ {0}
  | stmt_list exprs {0}

exprs:
	|	expr SEMICOLON  {0}

	/* Conditional */
	| IF L_PAREN expr R_PAREN L_BRACE expr R_BRACE	{0}
	|	IF L_PAREN expr R_PAREN L_BRACE expr R_BRACE ELSE L_BRACE expr R_BRACE	{0}
	| IF L_PAREN expr R_PAREN L_BRACE expr R_BRACE ELIF L_PAREN expr R_PAREN L_BRACE expr R_BRACE {0}

	/* Loops */
	| WHILE L_PAREN expr R_PAREN L_BRACE expr R_BRACE {0}
	| FOR L_PAREN expr SEMICOLON expr SEMICOLON expr R_PAREN L_BRACE expr R_BRACE {0}

	
kv_pairs:
		/* nothing */										{0}
	| expr COLON expr COMMA kv_pairs	{0}

expr:
	/* Literals */
	| TRUE								{0}
	| FALSE								{0}
	| VARIABLE						{0}
	| NUM_LITERAL					{0}
	| FLOAT_LITERAL				{0}

	/* Primitives */
  | INT                 {0}
  | FLT                 {0}
  | STR                 {0}
  | BOOL                {0}
	| BLOB								{0}
	| NULL								{0}

	/* Logical Operators */
	| NOT expr						{0}
	| expr AND expr				{0}
	| expr OR	expr				{0}

  /* Comparators */
  | expr EQ expr				{0}
  | expr NEQ expr				{0}
  | expr LT expr 				{0}
  | expr LEQ expr				{0}
  | expr GT expr				{0}
  | expr GEQ expr				{0}

	/* Arithmetic Operators */
	| VARIABLE ASN expr				{0}
	| expr PLUS expr			{0}
	| expr MINUS expr			{0}
	| expr TIMES expr			{0}
	| expr DIVIDE expr		{0}

	/* Arrays */
	| L_BRACKET expr R_BRACKET {0}

	/* Blob definion */
	| L_BRACE kv_pairs R_BRACE	{0}
