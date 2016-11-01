type token =
  | EOF
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | LPR
  | RPR
  | LBR
  | RBR
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

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
 open Ast 
# 35 "parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* PLUS *);
  258 (* MINUS *);
  259 (* TIMES *);
  260 (* DIVIDE *);
  261 (* LPR *);
  262 (* RPR *);
  263 (* LBR *);
  264 (* RBR *);
  265 (* ASN *);
  266 (* NULL *);
  267 (* TRUE *);
  268 (* FALSE *);
  269 (* OR *);
  270 (* AND *);
  271 (* NOT *);
  272 (* IF *);
  273 (* ELSE *);
  274 (* ELIF *);
  275 (* INT *);
  276 (* STR *);
  277 (* FLT *);
  278 (* BOOL *);
  279 (* SEMICOLON *);
    0|]

let yytransl_block = [|
  280 (* NUM_LITERAL *);
  281 (* FLOAT_LITERAL *);
  282 (* VARIABLE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\002\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\007\000\011\000\014\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\012\000\003\000\004\000\000\000\000\000\009\000\
\010\000\008\000\011\000\006\000\007\000\005\000\024\000\000\000\
\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\002\000\000\000\000\000\000\000\019\000\
\020\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\022\000\000\000\
\000\000\000\000\023\000"

let yydgoto = "\002\000\
\015\000\016\000\017\000"

let yysindex = "\009\000\
\097\255\000\000\000\000\000\000\000\000\097\255\009\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\028\000\
\038\255\197\255\097\255\000\000\097\255\097\255\097\255\097\255\
\097\255\097\255\097\255\000\000\123\255\002\255\002\255\000\000\
\000\000\193\255\000\255\000\255\029\255\097\255\137\255\246\254\
\039\255\040\255\097\255\097\255\151\255\165\255\000\000\042\255\
\097\255\179\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\003\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\054\255\070\255\000\000\
\000\000\025\255\081\255\092\255\000\000\000\000\000\000\021\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\250\255"

let yytablesize = 211
let yytable = "\018\000\
\021\000\022\000\023\000\024\000\023\000\024\000\041\000\042\000\
\013\000\001\000\013\000\013\000\029\000\019\000\030\000\031\000\
\032\000\033\000\034\000\035\000\036\000\021\000\021\000\021\000\
\021\000\013\000\021\000\020\000\021\000\021\000\016\000\039\000\
\016\000\021\000\021\000\038\000\045\000\046\000\021\000\022\000\
\023\000\024\000\050\000\021\000\044\000\043\000\025\000\016\000\
\049\000\000\000\026\000\027\000\000\000\000\000\017\000\017\000\
\000\000\000\000\000\000\017\000\028\000\017\000\017\000\000\000\
\000\000\000\000\017\000\017\000\000\000\000\000\018\000\018\000\
\000\000\000\000\000\000\018\000\017\000\018\000\018\000\000\000\
\000\000\000\000\018\000\018\000\000\000\000\000\015\000\000\000\
\015\000\015\000\000\000\000\000\018\000\015\000\015\000\000\000\
\000\000\014\000\000\000\014\000\014\000\000\000\000\000\015\000\
\014\000\014\000\003\000\004\000\005\000\000\000\000\000\006\000\
\007\000\000\000\014\000\008\000\009\000\010\000\011\000\000\000\
\012\000\013\000\014\000\021\000\022\000\023\000\024\000\000\000\
\037\000\000\000\000\000\025\000\000\000\000\000\000\000\026\000\
\027\000\021\000\022\000\023\000\024\000\000\000\000\000\000\000\
\040\000\025\000\000\000\000\000\000\000\026\000\027\000\021\000\
\022\000\023\000\024\000\000\000\000\000\000\000\047\000\025\000\
\000\000\000\000\000\000\026\000\027\000\021\000\022\000\023\000\
\024\000\000\000\048\000\000\000\000\000\025\000\000\000\000\000\
\000\000\026\000\027\000\021\000\022\000\023\000\024\000\000\000\
\000\000\000\000\051\000\025\000\000\000\000\000\000\000\026\000\
\027\000\021\000\022\000\023\000\024\000\021\000\022\000\023\000\
\024\000\025\000\000\000\000\000\000\000\026\000\027\000\000\000\
\000\000\026\000\027\000"

let yycheck = "\006\000\
\001\001\002\001\003\001\004\001\003\001\004\001\017\001\018\001\
\006\001\001\000\008\001\009\001\019\000\005\001\021\000\022\000\
\023\000\024\000\025\000\026\000\027\000\001\001\002\001\003\001\
\004\001\023\001\006\001\000\000\008\001\009\001\006\001\038\000\
\008\001\013\001\014\001\007\001\043\000\044\000\001\001\002\001\
\003\001\004\001\049\000\023\001\005\001\007\001\009\001\023\001\
\007\001\255\255\013\001\014\001\255\255\255\255\001\001\002\001\
\255\255\255\255\255\255\006\001\023\001\008\001\009\001\255\255\
\255\255\255\255\013\001\014\001\255\255\255\255\001\001\002\001\
\255\255\255\255\255\255\006\001\023\001\008\001\009\001\255\255\
\255\255\255\255\013\001\014\001\255\255\255\255\006\001\255\255\
\008\001\009\001\255\255\255\255\023\001\013\001\014\001\255\255\
\255\255\006\001\255\255\008\001\009\001\255\255\255\255\023\001\
\013\001\014\001\010\001\011\001\012\001\255\255\255\255\015\001\
\016\001\255\255\023\001\019\001\020\001\021\001\022\001\255\255\
\024\001\025\001\026\001\001\001\002\001\003\001\004\001\255\255\
\006\001\255\255\255\255\009\001\255\255\255\255\255\255\013\001\
\014\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\008\001\009\001\255\255\255\255\255\255\013\001\014\001\001\001\
\002\001\003\001\004\001\255\255\255\255\255\255\008\001\009\001\
\255\255\255\255\255\255\013\001\014\001\001\001\002\001\003\001\
\004\001\255\255\006\001\255\255\255\255\009\001\255\255\255\255\
\255\255\013\001\014\001\001\001\002\001\003\001\004\001\255\255\
\255\255\255\255\008\001\009\001\255\255\255\255\255\255\013\001\
\014\001\001\001\002\001\003\001\004\001\001\001\002\001\003\001\
\004\001\009\001\255\255\255\255\255\255\013\001\014\001\255\255\
\255\255\013\001\014\001"

let yynames_const = "\
  EOF\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  LPR\000\
  RPR\000\
  LBR\000\
  RBR\000\
  ASN\000\
  NULL\000\
  TRUE\000\
  FALSE\000\
  OR\000\
  AND\000\
  NOT\000\
  IF\000\
  ELSE\000\
  ELIF\000\
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
# 31 "parser.mly"
                  (0)
# 211 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
                    (0)
# 218 "parser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 38 "parser.mly"
               (0)
# 224 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parser.mly"
                (0)
# 230 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 40 "parser.mly"
                 (0)
# 237 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 41 "parser.mly"
                   (0)
# 244 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 42 "parser.mly"
                    (0)
# 251 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parser.mly"
               (0)
# 257 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "parser.mly"
               (0)
# 263 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "parser.mly"
               (0)
# 269 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "parser.mly"
               (0)
# 275 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 49 "parser.mly"
               (0)
# 281 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 52 "parser.mly"
                 (0)
# 288 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 53 "parser.mly"
                    (0)
# 296 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 54 "parser.mly"
                   (0)
# 304 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 57 "parser.mly"
                    (0)
# 312 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 58 "parser.mly"
                    (0)
# 320 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 59 "parser.mly"
                     (0)
# 328 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 60 "parser.mly"
                     (0)
# 336 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 61 "parser.mly"
                     (0)
# 344 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 66 "parser.mly"
                                (0)
# 352 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 67 "parser.mly"
                                                  (0)
# 361 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 11 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 8 : 'expr) in
    let _10 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _13 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 68 "parser.mly"
                                                               (0)
# 371 "parser.ml"
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
