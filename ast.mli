type operator = Add | Sub | Mul | Div

type logic_operator = And | Or | Ne | Eq | Lt | Lte | Gt | Gte

type expr =
	Binop of expr * operator * expr
	| Lit of int
	| Seq of expr * expr
	| Asn of int * expr
	| Var of int

type logic_expr = 
	