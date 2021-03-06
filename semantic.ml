open Ast

module StringMap = Map.Make(String)

(*	Semantic checking of a program. Returns void if successful,
		throws an exception if something is wrong.
		Check each global variable, then check each function *)

let checker (globals, functions) =

	(**	Raise an exception if the given list has a duplicate
	 *----------------------------------------------------------------------------*)
		let report_duplicate exceptf list =
			let rec helper = function
					n1 :: n2 :: _ when n1 = n2 -> raise (Failure (exceptf n1))
				|	_ :: t -> helper t
				| [] -> ()
			in helper (List.sort compare list)
		in

	(**	Helper functions
	 *----------------------------------------------------------------------------*)
		(*	Raise an exception if a given binding is to a void type	*)
		let check_not_void exceptf = function
				(Void, n) -> raise (Failure (exceptf n))
			| _ -> ()
		in

		(* Raise an exception for mismatched type. *)
		let rec check_assign lvaluet rvaluet err =
			if lvaluet == rvaluet then
				lvaluet
			else
				let fn = function
						LongDouble -> check_assign lvaluet Int err
					| _ -> raise err
				in fn (rvaluet)
		in

		(* Checking Global Variables *)
		List.iter (check_not_void (fun n -> "illegal void global " ^ n)) globals;
		report_duplicate (fun n -> "duplicate global " ^ n) (List.map snd globals);

		(* Defend built-in functions *)
		if List.mem "print" (List.map (fun fd -> fd.fname) functions)
		then raise (Failure ("function print may not be defined")) else ();
		report_duplicate (fun n -> "duplicate function " ^ n)
			(List.map (fun fd -> fd.fname) functions);

	(**	Declare built-in functions
	 *----------------------------------------------------------------------------*)
		let built_in_decls = StringMap.add "print" {
			typ = Void; fname = "print"; formals = [(Str, "x")];
			locals = []; body = [] }
			(StringMap.add "printfl" {
			typ = Void; fname = "printfl"; formals = [(Float, "x")];
			locals = []; body = [] }
			(StringMap.add "printi" {
			typ = Void; fname = "printi"; formals = [(Int, "x")];
			locals = []; body = [] }
			(StringMap.add "printb" {
			typ = Bool; fname = "printb"; formals = [(Bool, "x")];
			locals = []; body = [] }
			(StringMap.add "clock" {
			typ = LongDouble; fname = "clock"; formals = [];
			locals = []; body = [] }
			(StringMap.singleton "sleep" {
			typ = Void; fname = "sleep"; formals = [(Int, "x")];
			locals = []; body = []
		})))))
		(* Create print function for int *)
		in
		let function_decls =
	 		List.fold_left (fun m fd -> StringMap.add fd.fname fd m)
				built_in_decls functions
		in
		let function_decl s = try StringMap.find s function_decls
			with Not_found -> raise (Failure ("unrecognized function " ^ s))
		in


	(**	Check function declarations
	 *----------------------------------------------------------------------------*)
		let check_function func =
			List.iter (check_not_void (fun n ->
				"illegal void formal " ^ n ^ " in " ^ func.fname)) func.formals;

			report_duplicate (fun n ->
				"duplicate formal " ^ n ^ " in " ^ func.fname)(List.map snd func.formals);

			List.iter (check_not_void (fun n ->
				"illegal void local " ^ n ^ " in " ^ func.fname)) func.locals;

			report_duplicate (fun n ->
				"duplicate local " ^ n ^ " in " ^ func.fname)(List.map snd func.locals);

	(**	Variable symbol table
	 *----------------------------------------------------------------------------*)
		let symbols = List.fold_left (fun m (t, n) -> StringMap.add n t m)
			StringMap.empty (globals @ func.formals @ func.locals)
		in

		let type_of_identifier s =
			try StringMap.find s symbols
			with Not_found ->
				raise (Failure ("undeclared identifier " ^ s))
		in

		let rec expr = function
				NumLit _ 	-> Int
			| BoolLit _ -> Bool
			| StringLit _ -> Str
			| FloatLit _ -> Float
			| Id s			-> type_of_identifier s
			| Noexpr -> Void
			| Binop(e1, op, e2) as e -> let t1 = expr e1 and t2 = expr e2 in
					(match op with
						Add | Sub | Mult | Div when t1 = Int && t2 = Int -> Int
					| Equal | Neq when t1 = t2 -> Bool
					| Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool
					| And | Or when t1 = Bool && t2 = Bool -> Bool
					| _ -> raise (Failure ("illegal binary operator " ^
							string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
							string_of_typ t2 ^ " in " ^ string_of_expr e)))
			| Unop(op, e) as ex -> let t = expr e in
					(match op with
						Neg when t = Int -> Int
					| Not when t = Bool -> Bool
					| _ -> raise (Failure ("illegal unary operator " ^ string_of_uop op ^
						string_of_typ t ^ " in " ^ string_of_expr ex)))
			| Call(fname,actuals) as call -> let fd = function_decl fname in
					if List.length actuals != List.length fd.formals then
						raise (Failure ("expecting " ^ string_of_int (List.length fd.formals)
						^ " arguments in " ^ string_of_expr call)) (* string_of_expr call *)
					else
						List.iter2 (fun (ft, _) e -> let et = expr e in
							ignore (check_assign ft et
								(Failure ("illegal actual agrument: found " ^ string_of_typ et ^
								", expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e))))
						 fd.formals actuals;
						fd.typ (* FIX: This is for testing purposes *)

			| Assign(var, e) as ex -> let lt = type_of_identifier var and rt = expr e in
																check_assign lt rt (Failure ("illegal assignment " ^ string_of_typ lt ^
																     " != " ^ string_of_typ rt ^ " in " ^
																     string_of_expr ex))

			|	ArrayInit (v, s) -> type_of_identifier v

			| ArrayAsn (v, i, e) as ex -> let fn = function Int_p -> Int in
					let lt = fn (type_of_identifier v) and rt = expr e in
															check_assign lt rt (Failure ("illegal assignment " ^ string_of_typ lt ^
																	 " = " ^ string_of_typ rt ^ " in " ^
																	 string_of_expr ex))

			| ArrayRead (v, i) -> let fn = function Int_p -> Int in
					fn (type_of_identifier v)

		in

		let check_bool_expr e = if expr e != Bool
			then raise (Failure ("expected Boolean expression"))
		else () in

		let check_int_expr e = if expr e != Int
			then raise (Failure ("expected Integer expression"))
		in

		let rec stmt = function
				Expr e -> ignore (expr e)
			| Block sl -> let rec check_block = function
					[Return _ as s] -> stmt s
				| Return _ :: _ -> raise (Failure "nothing may follow a return")
				| Block sl :: ss -> check_block (sl @ ss)
				| s :: ss -> stmt s ; check_block ss
				| [] -> ()
			in check_block sl
			| Return e -> let t = expr e in if t = func.typ then () else
					raise (Failure ("unknown return type " ^ string_of_typ t ^ " expected "
					^ string_of_typ func.typ ^ " in " ^ string_of_expr e))
			| If(p, b1, b2) -> check_bool_expr p; stmt b1; stmt b2
			| For(e1, e2, e3, st) -> ignore (expr e1); check_bool_expr e2;
					ignore (expr e3); stmt st
			| While(p, s) -> check_bool_expr p; stmt s
			| Environment (i, s) -> check_int_expr i; stmt s
		in

		stmt (Block func.body)
	in List.iter check_function functions
