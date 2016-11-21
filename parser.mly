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
%token INT STR FLT BOOL BLOB VOID
%token SEMICOLON COMMA COLON
%token FUNCTION STIMULUS RETURN

%token <int> NUM_LITERAL
%token <float> FLOAT_LITERAL
%token <string> STRING
%token <string> ID

/* Associativity definitions */
%right ASN
%left OR AND
%left EQ NEQ
%left LT LEQ GT GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT

%start program
%type <Ast.program> program

%%

program:
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
	| kv_pair COMMA kv_pairs 	{$1 :: $3}

kv_pair:
	| expr COLON expr			{$1, $3}

arr:
	| expr COMMA					{$1}

typ:
	 	INT                 {Int}
	| FLT                 {Float}
	| STR                 {Str}
	| BOOL                {Bool}
	| BLOB								{Blob}
	| NULL								{Null}
	|	VOID								{Void}

expr:
		/* Literals */
	| TRUE								{BoolLit(true)}
	| FALSE								{BoolLit(false)}
	| ID									{Id($1)}
	| NUM_LITERAL					{NumLit($1)}
	| FLOAT_LITERAL				{FloatLit($1)}
	| STRING 							{StringLit($1)}

	/* Logical Operators */
	| NOT expr						{Unop(Not, $2)}
	| expr AND expr				{Binop($1, And, $3)}
	| expr OR	expr				{Binop($1, Or, $3)}

  /* Comparators */
  | expr EQ expr				{Binop($1, Equal, $3)}
  | expr NEQ expr				{Binop($1, Neq, $3)}
  | expr LT expr 				{Binop($1, Less, $3)}
  | expr LEQ expr				{Binop($1, Leq, $3)}
  | expr GT expr				{Binop($1, Greater, $3)}
  | expr GEQ expr				{Binop($1, Geq, $3)}

	/* Arithmetic Operators */
	| ID ASN expr					{Assign($1, $3)}
	| expr PLUS expr			{Binop($1, Add, $3)}
	| expr MINUS expr			{Binop($1, Sub, $3)}
	| expr TIMES expr			{Binop($1, Mult, $3)}
	| expr DIVIDE expr		{Binop($1, Div, $3)}
	/* Function Call */
	| ID L_PAREN actuals_opt R_PAREN { Call($1, $3) }

	/* Arrays */
	| L_BRACKET arr R_BRACKET 	{$2}

	/* Blob definion */
	| L_BRACE kv_pairs R_BRACE	{MapLit($2)}

actuals_opt:
		/* nothing */	{ [] }
	| actuals_list	{ List.rev $1 }

actuals_list:
		expr 	{ [$1] }
	| actuals_list COMMA expr { $3 :: $1 }