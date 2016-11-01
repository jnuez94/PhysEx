%{ open Ast %}

%token LBR LPR RBR RPR SEMICOLON
%token PLUS MINUS TIMES DIVIDE EOF ASN COMMA 
%token MULTASN DIVASN PLUSASN SUBASN NE EQ LT LTE GT GTE
%token OR AND NOT NEG IF ELSE ELIF WHILE FOR FUNC STIM INT CHAR
%token STR FLT BOOL BLOB

% <int> LITERAL
% <int> VARIABLE

%right ASN
%left OR
%left AND
%left EQ NEQ
%left LT GT LTE GTE
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT NEG

%start expr
%type < Ast.expr > expr

%%

expr:
  expr PLUS expr { 0 }
| expr MINUS expr { 0 }
| expr TIMES expr	{ 0 }
| expr DIVIDE expr { 0 }
| expr COMMA expr	{ 0 }
| NEG	expr { 0 }
|	asn
|	loop  (* This might conflict with asn imagine int a = for() loop *)
| LITERAL { 0 }
| VARIABLE { 0 }


asn:
  VARIABLE ASN expr { 0 }
| VARIABLE MULTASN expr { 0 }
|	VARIABLE DIVASN expr { 0 }
|	VARIABLE PLUSASN expr { 0 }
|	VARIABLE SUBASN expr { 0 }
| VARIABLE ASN l_expr { 0 }
 

l_expr:
 	NOT l_expr			{ 0 }
| l_expr AND l_expr { 0 }
| l_expr OR	l_expr { 0 }
| BOOL
(* Some of the missing logical expressions *)
| l_expr LT l_expr { 0 }
| l_expr GT l_expr { 0 }
| l_expr LTE l_expr { 0 }
| l_expr GTE l_expr { 0 }
| l_expr EQ l_expr { 0 }
| l_expr NEQ l_expr { 0 }
| expr  

loop:
  IF LPR l_expr RPR LBR expr RBR { 0 }
(* Might need to check this for loop this looks like
	 for (int var = 1; var < 5; =){} *)
| FOR LPR asn SEMICOLON l_expr SEMICOLON ASN RPR LBR expr RBR { 0 }
|	WHILE LPR l_expr RPR LBR expr RBR { 0 }
(* Is there a better way to do this? *)
|	IF LPR l_expr RPR LBR expr RBR ELSE LBR expr RBR { 0 }
| IF LPR l_expr RPR LBR expr RBR ELIF LPR l_expr RPR LBR expr RBR { 0 }
(* Added if elif else *)
| IF LPR l_expr RPR LBR expr RBR ELIF LPR l_expr RPR LBR expr RBR ELSE LBR expr RBR { 0 } 

program: decls EOF { 0 }

decls: { 0 }
| decls vdecl { 0 }
| decls fdecl { 0 }
| decls expr { 0 }

fdecl:
(* 
  Probably don't need to delete this, but might be better to 
  combine vdecl_list and stmt_list. Thoughts?
 *)
FUNC VARIABLE LPR formal_list RPR LBR vdecl_list stmt_list RBR { 0 }

formal_list: 
typ VARIABLE { 0 }
| formal_list COMMA typ VARIABLE { 0 }

typ: INT { 0 }
| CHAR { 0 }
| STR { 0 }
| BLOB { 0 }
| FLT
| BOOL { 0 }
| NULL { 0 }

vdecl_list: { 0 }
| vdecl_list vdecl { 0 }

vdecl: typ VARIABLE SEMICOLON { 0 }

stmt_list: {0}
| expr {0}
