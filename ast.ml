type op =
		Add
	| Sub
	| Mult
	| Div
	| Equal
	| And
	| Or
	| Neq
	| Less
	| Leq
	| Greater
	| Geq

type uop =
		Neg
	| Not

type typ =
		Int
	| Bool
	| Blob
	| Null (* Need to fix this later: NULL not a type i think. *)
	| Void
	| Float
	| Float_p
	| LongDouble
	| Str
	| Str_p
	| Int_p
	| Stim

type bind = typ * string

type expr =
		NumLit of int
	| BoolLit of bool
	| FloatLit of float
	| Id of string
	| StringLit of string
	| Noexpr
	| Binop of expr * op * expr
	| Unop of uop * expr
	| Assign of string * expr
	| Call of string * expr list
	| ArrayInit of string * expr
	| ArrayAsn of string * expr * expr
	| ArrayRead of string * expr
	| MapLit of (expr * expr) list

type stmt =
		Block of stmt list
	| Expr of expr
	| If of expr * stmt * stmt
	| For of expr * expr * expr * stmt
	| While of expr * stmt
	| Return of expr
	| Environment of expr * stmt

type func_decl = {
	typ 				: typ;
	fname 			: string;
	formals			: bind list;
	locals			: bind list;
	body				: stmt list;
}

type program = bind list * func_decl list

let string_of_op = function
		Add -> "+"
	| Sub -> "-"
	| Mult -> "*"
	| Div -> "/"
	| Equal -> "=="
	| Neq -> "!="
	| Less -> "<"
	| Leq -> "<="
	| Greater -> ">"
	| Geq -> ">="
	| And -> "&&"
	| Or -> "||"

let string_of_uop = function
		Neg -> "-"
	| Not -> "!"

let rec expr_value = function
	NumLit(l) -> l

let rec string_of_expr = function
		NumLit(l) -> string_of_int l
	| BoolLit(true) -> "true"
	| BoolLit(false) -> "false"
	| FloatLit(f) -> string_of_float f
	| StringLit(s) -> s
	| Id(s) -> s
	| Binop(e1, o, e2) ->
			string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
	| Unop(o, e) -> string_of_uop o ^ string_of_expr e
	| Call(f, el) ->
			f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
	| Noexpr -> ""
	| Assign(v, e) -> v ^ " = " ^ string_of_expr e
	| ArrayAsn (var, i, e) -> var ^ "[" ^ string_of_expr i ^ "] = " ^ string_of_expr e
	| ArrayRead (var, i) -> var ^ " from index " ^ string_of_expr i

let rec string_of_stmt = function
		Block(stmts) ->
			"{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
	| Expr(expr) -> string_of_expr expr ^ ";\n";
	| Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
	| If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^
			string_of_stmt s
	| If(e, s1, s2) -> "if (" ^ string_of_expr e ^ ")\n" ^
			string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
	| For(e1, e2, e3, s) ->
			"for (" ^ string_of_expr e1 ^ " ; " ^ string_of_expr e2 ^ " ; " ^
			string_of_expr e3 ^ ") " ^ string_of_stmt s
	| While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s

let string_of_typ = function
		Int -> "int"
	| Bool -> "bool"
	| Void -> "void"
	| Blob -> "blob"
	| Float -> "float"
	| Str -> "string"
	| Str_p -> "string pointer"
	| Int_p -> "int pointer"
	| Float_p -> "float pointer"
	| LongDouble -> "long double"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl fdecl =
	"function " ^ fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
	")\n{\n" ^
	String.concat "" (List.map string_of_vdecl fdecl.locals) ^
	String.concat "" (List.map string_of_stmt fdecl.body) ^
	"}\n"

let string_of_program (vars, funcs) =
	String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
	String.concat "\n" (List.map string_of_fdecl funcs)
