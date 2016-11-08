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
	| Null
	| Float
	| String

type bind = typ * string

type expr =
		NumLit of int
	| BoolLit of bool
	| FloatLit of float
	| Id of string
	| Noexpr
	| Binop of expr * op * expr
	| Unop of uop * expr
	| Assign of string * expr
	| Call of string * expr list

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
