%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF ASN SEQ 
%token MULTASN DIVASN PLUSASN SUBASN NE EQ LT LTE GT GTE
%token OR AND NOT IF ELSE ELIF WHILE FOR FUNC STIM INT CHAR
%token STR FLT BOOL BLOB

% <int> LITERAL
% <int> VARIABLE

%left SEQ 
%right ASN
%left PLUS MINUS
%left TIMES DIVIDE

%start expr
%type < Ast.expr > expr

%%

expr:
expr	PLUS 		expr	{ Binop($1, Add, $3) }
| expr	MINUS 		expr	{ Binop($1, Sub, $3) }
| expr	TIMES		expr	{ Binop($1, Mul, $3) }
| expr	DIVIDE		expr	{ Binop($1, Div, $3) }
| LITERAL					{ Lit($1) }
| VARIABLE					{ Var($1) }
| expr	SEQ			expr	{ Seq($1, $3) }
| VARIABLE ASN		expr	{ Asn($1, $3) }
| expr
| logic_expr AND	logic_expr 	{ logic_binop($1, And, $3) }
| logic_expr OR	logic_expr 	{ logic_binop($1, Or, $3) }