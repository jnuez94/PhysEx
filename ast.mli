type id = string

type operator =
	| Add | Sub | Mul | Div
	| And | Or | Ne | Eq | Lt | Lte | Gt | Gte

type primitive =
	| T of string

type expr =
	| NumLit of float

type program = expr list;;
