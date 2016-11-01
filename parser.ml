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

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
 open Ast 
# 25 "parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* PLUS *);
  258 (* MINUS *);
  259 (* TIMES *);
  260 (* DIVIDE *);
  261 (* ASN *);
  262 (* NULL *);
  263 (* TRUE *);
  264 (* FALSE *);
  265 (* INT *);
  266 (* STR *);
  267 (* FLT *);
  268 (* BOOL *);
  269 (* SEMICOLON *);
    0|]

let yytransl_block = [|
  270 (* NUM_LITERAL *);
  271 (* FLOAT_LITERAL *);
  272 (* VARIABLE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\003\000\003\000\003\000\003\000\
\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\012\000\003\000\004\000\009\000\010\000\008\000\
\011\000\006\000\007\000\005\000\018\000\000\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\
\016\000\017\000\000\000"

let yydgoto = "\002\000\
\013\000\014\000\015\000"

let yysindex = "\009\000\
\014\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\015\000\255\254\000\000\
\014\255\014\255\014\255\014\255\014\255\000\000\010\255\010\255\
\000\000\000\000\030\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\004\255\006\255\
\000\000\000\000\003\255"

let yygindex = "\000\000\
\000\000\000\000\019\000"

let yytablesize = 40
let yytable = "\017\000\
\018\000\019\000\020\000\021\000\014\000\014\000\015\000\015\000\
\014\000\001\000\015\000\022\000\019\000\020\000\016\000\013\000\
\014\000\000\000\015\000\003\000\004\000\005\000\006\000\007\000\
\008\000\009\000\000\000\010\000\011\000\012\000\017\000\018\000\
\019\000\020\000\021\000\023\000\024\000\025\000\026\000\027\000"

let yycheck = "\001\001\
\002\001\003\001\004\001\005\001\001\001\002\001\001\001\002\001\
\005\001\001\000\005\001\013\001\003\001\004\001\000\000\013\001\
\013\001\255\255\013\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\255\255\014\001\015\001\016\001\001\001\002\001\
\003\001\004\001\005\001\017\000\018\000\019\000\020\000\021\000"

let yynames_const = "\
  EOF\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  ASN\000\
  NULL\000\
  TRUE\000\
  FALSE\000\
  INT\000\
  STR\000\
  FLT\000\
  BOOL\000\
  SEMICOLON\000\
  "

let yynames_block = "\
  NUM_LITERAL\000\
  FLOAT_LITERAL\000\
  VARIABLE\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'exprs) in
    Obj.repr(
# 26 "parser.mly"
                  (0)
# 128 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 29 "parser.mly"
                    (0)
# 135 "parser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 33 "parser.mly"
               (0)
# 141 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 34 "parser.mly"
                (0)
# 147 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 35 "parser.mly"
                 (0)
# 154 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 36 "parser.mly"
                   (0)
# 161 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 37 "parser.mly"
                    (0)
# 168 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parser.mly"
               (0)
# 174 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "parser.mly"
               (0)
# 180 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 42 "parser.mly"
               (0)
# 186 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 43 "parser.mly"
               (0)
# 192 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 44 "parser.mly"
               (0)
# 198 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 47 "parser.mly"
                    (0)
# 206 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 48 "parser.mly"
                    (0)
# 214 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 49 "parser.mly"
                     (0)
# 222 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 50 "parser.mly"
                     (0)
# 230 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 51 "parser.mly"
                     (0)
# 238 "parser.ml"
               : 'expr))
(* Entry prgm *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let prgm (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
