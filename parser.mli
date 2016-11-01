type token =
  | EOF
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | ASN
  | NULL
  | TRUE
  | FALSE
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
