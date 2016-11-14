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

	(* Defend built-in functions *)
	if List.mem "print" (List.map (fun fd -> fd.fname) functions)
	then raise (Failure ("function print may not be defined")) else ();
	report_duplicate (fun n -> "duplicate function " ^ n)
		(List.map (fun fd -> fd.fname) functions);

(**	Declare built-in functions
 *----------------------------------------------------------------------------*)
	let built_in_decls = StringMap.singleton "print" {
		fname = "print";
		formals = [(String, "x")];
		locals = [];
		body = []
	}
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
			"illegal void formal " ^ n ^ "in " ^ func.fname)) func.formals;

		report_duplicate (fun n ->
			"duplicate formal " ^ n ^ " in " ^ func.fname)(List.map snd func.formals);

		List.iter (check_not_void (fun n ->
			"illegal void local " ^ n ^ "in " ^ func.fname)) func.locals;

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
			NumLit _ -> Int
		| BoolLit _ -> Bool
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

	in stmt (Block func.body)
in List.iter check_function functions
