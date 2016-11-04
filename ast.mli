type op =
		Add
	| Sub
	| Mult
	| Div
	| Equal

type uop =
		Neg
	| Not

type typ =
		Int
	| Bool
	| Blob
	| String

type expr =
		Literal of int
	| Id of string
	| Binop of expr * op * expr
	| Assign of string * expr
	| BoolLit of bool
	| Noexpr
	| Unop of uop * expr
	| Call of string * expr list

type stmt =
		Block of stmt list
	| Expr of expr
	| If of expr * stmt * stmt
	| For of expr * expr * expr * stmt
	| While of expr * stmt
	| Return of expr

type bind = typ * string

type func_decl = {
	fname 			: string;
	formals			: bind list;
	locals			: bind list;
}

type program = bind list * func_decl list
