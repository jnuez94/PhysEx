type op =
		Add
	| Sub
	| Mult
	| Div
	| Equal

type typ =
		Int
	| Bool
	| Blob
	| String

type expr =
		BoolLit of bool
	| Id of string

type stmt =
		Block of stmt list
	| Expr of expr
	| If of expr * stmt * stmt

type bind = typ * string

type func_decl = {
	fname 			: string;
	formals			: int list;
	locals			: bind list;
}

type program = bind list * func_decl list
