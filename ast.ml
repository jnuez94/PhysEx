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
	| Str

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
	| MapLit of (expr * expr) list

type stmt =
		Block of stmt list
	| Expr of expr
	| If of expr * stmt * stmt
	| For of expr * expr * expr * stmt
	| While of expr * stmt
	| Return of expr

type func_decl = {
	fname 			: string;
	formals			: bind list;
	locals			: bind list;
	body				: stmt list;
}

type program = bind list * func_decl list

let string_of_typ = function
		Int -> "int"
	| Bool -> "bool"
	| Void -> "void"
	| Blob -> "blob"
	| Float -> "float"
	| Str -> "string"

let rec string_of_expr = function
		NumLit(l) -> string_of_int l
	| BoolLit(true) -> "true"
	| BoolLit(false) -> "false"
	| StringLit(s) -> s
	| Id(s) -> s
	| Call(f, el) ->
			f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
	| Noexpr -> ""
	| Assign(v, e) -> v ^ " = " ^ string_of_expr e
