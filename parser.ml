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

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
 open Ast 
# 37 "parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* PLUS *);
  258 (* MINUS *);
  259 (* TIMES *);
  260 (* DIVIDE *);
  261 (* L_PAREN *);
  262 (* R_PAREN *);
  263 (* L_BRACE *);
  264 (* R_BRACE *);
  265 (* L_BRACKET *);
  266 (* R_BRACKET *);
  267 (* ASN *);
  268 (* NULL *);
  269 (* TRUE *);
  270 (* FALSE *);
  271 (* OR *);
  272 (* AND *);
  273 (* NOT *);
  274 (* IF *);
  275 (* ELSE *);
  276 (* ELIF *);
  277 (* INT *);
  278 (* STR *);
  279 (* FLT *);
  280 (* BOOL *);
  281 (* SEMICOLON *);
    0|]

let yytransl_block = [|
  282 (* NUM_LITERAL *);
  283 (* FLOAT_LITERAL *);
  284 (* VARIABLE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\000\000"

let yylen = "\002\000\
\002\000\002\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\002\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\007\000\011\000\014\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\012\000\003\000\004\000\000\000\000\000\
\009\000\010\000\008\000\011\000\006\000\007\000\005\000\025\000\
\000\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\002\000\021\000\000\000\
\000\000\000\000\019\000\020\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\023\000\000\000\000\000\000\000\024\000"

let yydgoto = "\002\000\
\016\000\017\000\018\000"

let yysindex = "\002\000\
\076\255\000\000\076\255\000\000\000\000\000\000\076\255\008\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\011\000\071\255\137\255\217\255\076\255\000\000\076\255\076\255\
\076\255\076\255\076\255\076\255\076\255\000\000\000\000\153\255\
\254\254\254\254\000\000\000\000\213\255\004\255\004\255\012\255\
\076\255\159\255\246\254\028\255\010\255\076\255\076\255\175\255\
\191\255\000\000\032\255\076\255\197\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\006\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\044\255\055\255\000\000\000\000\121\255\099\255\110\255\000\000\
\000\000\000\000\026\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\253\255"

let yytablesize = 233
let yytable = "\019\000\
\025\000\026\000\001\000\020\000\023\000\024\000\025\000\026\000\
\044\000\045\000\022\000\013\000\021\000\013\000\047\000\013\000\
\013\000\032\000\041\000\033\000\034\000\035\000\036\000\037\000\
\038\000\039\000\022\000\022\000\022\000\022\000\013\000\022\000\
\000\000\022\000\046\000\022\000\022\000\042\000\052\000\000\000\
\022\000\022\000\048\000\049\000\017\000\017\000\000\000\000\000\
\053\000\017\000\022\000\017\000\000\000\017\000\017\000\018\000\
\018\000\000\000\017\000\017\000\018\000\000\000\018\000\000\000\
\018\000\018\000\000\000\000\000\017\000\018\000\018\000\023\000\
\024\000\025\000\026\000\000\000\000\000\000\000\000\000\018\000\
\000\000\027\000\000\000\000\000\003\000\028\000\029\000\004\000\
\005\000\006\000\000\000\000\000\007\000\008\000\000\000\030\000\
\009\000\010\000\011\000\012\000\000\000\013\000\014\000\015\000\
\015\000\000\000\015\000\000\000\015\000\015\000\000\000\000\000\
\000\000\015\000\015\000\014\000\000\000\014\000\000\000\014\000\
\014\000\000\000\000\000\015\000\014\000\014\000\016\000\000\000\
\016\000\000\000\016\000\000\000\000\000\000\000\014\000\000\000\
\000\000\023\000\024\000\025\000\026\000\000\000\000\000\000\000\
\000\000\016\000\031\000\027\000\000\000\000\000\000\000\028\000\
\029\000\023\000\024\000\025\000\026\000\000\000\040\000\023\000\
\024\000\025\000\026\000\027\000\000\000\000\000\043\000\028\000\
\029\000\027\000\000\000\000\000\000\000\028\000\029\000\023\000\
\024\000\025\000\026\000\000\000\000\000\000\000\050\000\000\000\
\000\000\027\000\000\000\000\000\000\000\028\000\029\000\023\000\
\024\000\025\000\026\000\000\000\051\000\023\000\024\000\025\000\
\026\000\027\000\000\000\000\000\054\000\028\000\029\000\027\000\
\000\000\000\000\000\000\028\000\029\000\023\000\024\000\025\000\
\026\000\023\000\024\000\025\000\026\000\000\000\000\000\027\000\
\000\000\000\000\000\000\028\000\029\000\000\000\000\000\028\000\
\029\000"

let yycheck = "\003\000\
\003\001\004\001\001\000\007\000\001\001\002\001\003\001\004\001\
\019\001\020\001\000\000\006\001\005\001\008\001\005\001\010\001\
\011\001\021\000\007\001\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\001\001\002\001\003\001\004\001\025\001\006\001\
\255\255\008\001\007\001\010\001\011\001\041\000\007\001\255\255\
\015\001\016\001\046\000\047\000\001\001\002\001\255\255\255\255\
\052\000\006\001\025\001\008\001\255\255\010\001\011\001\001\001\
\002\001\255\255\015\001\016\001\006\001\255\255\008\001\255\255\
\010\001\011\001\255\255\255\255\025\001\015\001\016\001\001\001\
\002\001\003\001\004\001\255\255\255\255\255\255\255\255\025\001\
\255\255\011\001\255\255\255\255\009\001\015\001\016\001\012\001\
\013\001\014\001\255\255\255\255\017\001\018\001\255\255\025\001\
\021\001\022\001\023\001\024\001\255\255\026\001\027\001\028\001\
\006\001\255\255\008\001\255\255\010\001\011\001\255\255\255\255\
\255\255\015\001\016\001\006\001\255\255\008\001\255\255\010\001\
\011\001\255\255\255\255\025\001\015\001\016\001\006\001\255\255\
\008\001\255\255\010\001\255\255\255\255\255\255\025\001\255\255\
\255\255\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\025\001\010\001\011\001\255\255\255\255\255\255\015\001\
\016\001\001\001\002\001\003\001\004\001\255\255\006\001\001\001\
\002\001\003\001\004\001\011\001\255\255\255\255\008\001\015\001\
\016\001\011\001\255\255\255\255\255\255\015\001\016\001\001\001\
\002\001\003\001\004\001\255\255\255\255\255\255\008\001\255\255\
\255\255\011\001\255\255\255\255\255\255\015\001\016\001\001\001\
\002\001\003\001\004\001\255\255\006\001\001\001\002\001\003\001\
\004\001\011\001\255\255\255\255\008\001\015\001\016\001\011\001\
\255\255\255\255\255\255\015\001\016\001\001\001\002\001\003\001\
\004\001\001\001\002\001\003\001\004\001\255\255\255\255\011\001\
\255\255\255\255\255\255\015\001\016\001\255\255\255\255\015\001\
\016\001"

let yynames_const = "\
  EOF\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  L_PAREN\000\
  R_PAREN\000\
  L_BRACE\000\
  R_BRACE\000\
  L_BRACKET\000\
  R_BRACKET\000\
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
# 225 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
                    (0)
# 232 "parser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 38 "parser.mly"
               (0)
# 238 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parser.mly"
                (0)
# 244 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 40 "parser.mly"
                 (0)
# 251 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 41 "parser.mly"
                   (0)
# 258 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 42 "parser.mly"
                    (0)
# 265 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parser.mly"
               (0)
# 271 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "parser.mly"
               (0)
# 277 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "parser.mly"
               (0)
# 283 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "parser.mly"
               (0)
# 289 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 49 "parser.mly"
               (0)
# 295 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 52 "parser.mly"
                 (0)
# 302 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 53 "parser.mly"
                    (0)
# 310 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 54 "parser.mly"
                   (0)
# 318 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 57 "parser.mly"
                    (0)
# 326 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 58 "parser.mly"
                    (0)
# 334 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 59 "parser.mly"
                     (0)
# 342 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 60 "parser.mly"
                     (0)
# 350 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 61 "parser.mly"
                     (0)
# 358 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 64 "parser.mly"
                            (0)
# 365 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 67 "parser.mly"
                                                (0)
# 373 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 68 "parser.mly"
                                                                          (0)
# 382 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 11 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 8 : 'expr) in
    let _10 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _13 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 69 "parser.mly"
                                                                                               (0)
# 392 "parser.ml"
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
