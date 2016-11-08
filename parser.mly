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
%token FUNCTION STIMULUS RETURN

%token <int> NUM_LITERAL
%token <float> FLOAT_LITERAL
%token <string> ID

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
	| decls EOF	{$1}

decls:
    /* nothing */ {[], []}
  | decls fdecl		{ fst $1, ($2 :: snd $1) }
  | decls vdecl 	{ ($2 :: fst $1), snd $1}

fdecl:
  FUNCTION ID L_PAREN formals_opt R_PAREN L_BRACE vdecl_list stmt_list R_BRACE {{
		fname = $2;
		formals = $4;
		locals = List.rev $7;
		body = List.rev $8;
	}}

formals_opt:
    /* nothing */		{[]}
  | formal_list			{List.rev $1}

formal_list:
    typ ID 											{[($1, $2)]}
  | formal_list COMMA typ ID	{($3, $4) :: $1}

vdecl_list:
		/* nothing */			{[]}
	|	vdecl_list vdecl	{$2 :: $1}

vdecl:
		typ ID SEMICOLON {($1, $2)}

stmt_list:
    /* nothing */		{[]}
  | stmt_list stmt {$2 :: $1}

stmt:
		expr SEMICOLON  			{Expr $1}
	| RETURN SEMICOLON			{Return Noexpr}
	| RETURN expr SEMICOLON	{Return $2}

	/* Conditional */
	| IF L_PAREN expr R_PAREN L_BRACE stmt R_BRACE	{If ($3, $6, Block([]))}
	|	IF L_PAREN expr R_PAREN L_BRACE stmt R_BRACE ELSE L_BRACE stmt R_BRACE	{If ($3, $6, $10)}
	/*| IF L_PAREN expr R_PAREN L_BRACE stmt R_BRACE ELIF L_PAREN stmt R_PAREN L_BRACE stmt R_BRACE {0}*/

	/* Loops */
	| WHILE L_PAREN expr R_PAREN L_BRACE stmt R_BRACE {While($3, $6)}
	| FOR L_PAREN expr SEMICOLON expr SEMICOLON expr R_PAREN L_BRACE stmt R_BRACE {For ($3, $5, $7, $10)}


kv_pairs:
		/* nothing */										{[],[],[],[],[]}
	| expr COLON expr COMMA kv_pairs	{0}

typ:
	 	INT                 {Int}
	| FLT                 {Float}
	| STR                 {String}
	| BOOL                {Bool}
	| BLOB								{Blob}
	| NULL								{Null}

expr:
	/* Literals */
	| TRUE								{BoolLit(true)}
	| FALSE								{BoolLit(false)}
	| ID									{Id($1)}
	| NUM_LITERAL					{NumLit($1)}
	| FLOAT_LITERAL				{FloatLit($1)}

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
	| ID ASN expr		{0}
	| expr PLUS expr			{0}
	| expr MINUS expr			{0}
	| expr TIMES expr			{0}
	| expr DIVIDE expr		{0}

	/* Arrays */
	| L_BRACKET expr R_BRACKET {0}

	/* Blob definion */
	| L_BRACE kv_pairs R_BRACE	{0}
