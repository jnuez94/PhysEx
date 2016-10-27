%{ open Ast %}

%token LBR LPR RBR RPR SEMICOLON
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
	expr	PLUS 	expr	{ 0 }
| 	expr	MINUS 	expr	{ 0 }
| 	expr	TIMES	expr	{ 0 }
| 	expr	DIVIDE	expr	{ 0 }
| 	expr	SEQ		expr	{ 0 }
|	asn
|	loop
| 	LITERAL					{ 0 }
| 	VARIABLE				{ 0 }


asn:
	VARIABLE 	ASN			expr	{0}
| 	VARIABLE 	MULTASN 	expr 	{0}
|	VARIABLE 	DIVASN 		expr 	{0}
|	VARIABLE 	PLUSASN 	expr 	{0}
|	VARIABLE 	SUBASN 		expr 	{0}
|   VARIABLE	ASN         l_expr 	{0}


l_expr:
 	NOT 		l_expr			{ 0 }
| 	l_expr 		AND		l_expr 	{ 0 }
| 	l_expr 		OR		l_expr 	{ 0 }
| 	BOOL

loop:
	IF 	LPR l_expr 	RPR LBR expr RBR { 0 }
| 	FOR LPR asn SEMICOLON l_expr ASN RPR LBR expr RBR { 0 }
|	WHILE LPR l_expr RPR LBR expr RBR { 0 }
|	IF 	LPR l_expr 	RPR LBR expr RBR ELSE LBR expr RBR { 0 }
| 	IF 	LPR l_expr 	RPR LBR expr RBR ELIF LPR l_expr RPRLBR expr RBR { 0 }
