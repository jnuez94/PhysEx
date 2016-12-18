%{
open Ast
%}

%token SEMICOLON L_PAREN R_PAREN L_BRACE R_BRACE L_BRACKET R_BRACKET COMMA
%token PLUS MINUS TIMES DIVIDE ASN PLSASN SUBASN MULASN DIVASN NOT
%token EQ NEQ LT LEQ GT GEQ TRUE FALSE AND OR NULL
%token RETURN IF ELSE FOR WHILE INT BOOL VOID STR FLT BLOB
%token STIM FUNC COLON
%token <int> NUM_LITERAL
%token <float> FLOAT_LITERAL
%token <string> STRING
%token <string> ID
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%right ASN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT NEG

%start program
%type <Ast.program> program

%%

program:
	decls EOF { $1 }

decls:
	 /* nothing */ { [], [] }
	| decls fdecl { fst $1, ($2 :: snd $1) }
	| decls vdecl { ($2 :: fst $1), snd $1 }

fdecl:
	typ FUNC ID L_PAREN formals_opt R_PAREN L_BRACE vdecl_list stmt_list R_BRACE {{
		typ = $1;
		fname = $3;
		formals = $5;
		locals = List.rev $8;
		body = List.rev $9
	}}

formals_opt:
	  /* nothing */ { [] }
	| formal_list   { List.rev $1 }

formal_list:
		typ ID                   { [($1,$2)] }
	| formal_list COMMA typ ID { ($3,$4) :: $1 }

typ:
		INT { Int }
	| FLT 	{ Float }
	| BOOL { Bool }
	| VOID { Void }
	| STR   { Str }
	| INT TIMES {Int_p}

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }

vdecl:
   typ ID SEMICOLON { ($1, $2) }

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMICOLON { Expr $1 }
  | RETURN SEMICOLON { Return Noexpr }
  | RETURN expr SEMICOLON { Return $2 }
  | L_BRACE stmt_list R_BRACE { Block(List.rev $2) }
  | IF L_PAREN expr R_PAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF L_PAREN expr R_PAREN stmt ELSE stmt    { If($3, $5, $7) }
  | FOR L_PAREN expr SEMICOLON expr SEMICOLON expr R_PAREN stmt
     { For($3, $5, $7, $9) }
  | WHILE L_PAREN expr R_PAREN stmt { While($3, $5) }

kv_pairs:
	| kv_pair COMMA kv_pairs {$1 :: $3}

kv_pair:
	| expr COLON expr {$1, $3}

expr:
	/* Literals */
   	TRUE             { BoolLit(true) }
  | FALSE            { BoolLit(false) }
  | ID               { Id($1) }
  | FLOAT_LITERAL 		{ FloatLit($1) }
  | NUM_LITERAL       { NumLit($1) }
  | STRING       { StringLit($1) }

  /* Unary Operators */
  | MINUS expr %prec NEG { Unop(Neg, $2) }
  | NOT expr         { Unop(Not, $2) }

  /* Logical Operators */
  | expr AND    expr { Binop($1, And,   $3) }
  | expr OR     expr { Binop($1, Or,    $3) }

  /* Comparators */
  | expr EQ     expr { Binop($1, Equal, $3) }
  | expr NEQ    expr { Binop($1, Neq,   $3) }
  | expr LT     expr { Binop($1, Less,  $3) }
  | expr LEQ    expr { Binop($1, Leq,   $3) }
  | expr GT     expr { Binop($1, Greater, $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3) }

  /* Arithmetic Operators */
  | ID ASN expr   { Assign($1, $3) }
  | expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr TIMES  expr { Binop($1, Mult,  $3) }
  | expr DIVIDE expr { Binop($1, Div,   $3) }

  /* Arrays */
  | ID ASN L_BRACKET expr R_BRACKET		{ ArrayInit($1, $4) }
  | ID L_BRACKET expr R_BRACKET ASN expr { ArrayAsn($1, $3, $6) }
  | ID L_BRACKET expr R_BRACKET					{ ArrayRead($1, $3) }

  | ID L_PAREN actuals_opt R_PAREN { Call($1, $3) }
  | L_PAREN expr R_PAREN { $2 }

  /* TODO: Redefine Blob */

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
