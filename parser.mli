type token =
  | EOF
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | L_PAREN
  | R_PAREN
  | L_BRACE
  | R_BRACE
  | L_BRACKET
  | R_BRACKET
  | ASN
  | NULL
  | TRUE
  | FALSE
  | OR
  | AND
  | NOT
  | IF
  | ELSE
  | ELIF
  | INT
  | STR
  | FLT
  | BOOL
  | SEMICOLON
  | NUM_LITERAL of (int)
  | FLOAT_LITERAL of (float)
  | VARIABLE of (string)

val prgm :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
