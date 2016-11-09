open Ast

module StringMap = Map.Make(String)

(*	Semantic checking of a program. Returns void if successful,
		thows an exception if something is wrong.
		Check each global variable, then check each function *)

let checker (globals, functions) = function

	(*	Raise an exception if the given list has a duplicate	*)
	let report_duplicate exceptf list =
		let rec helper = function
				n1 :: n2 :: _ when n1 = n2 -> raise (Failture (exceptf n1))
			|	_ :: t -> helper t
			| [] -> ()
		in helper (List.sort compare list)
	in

	(*	Raise an exception if a given binding is to a void type	*)
	let check_not_void exceptf = function
			(Void, n) -> raise (Failure (exceptf n))
		| _ -> ()
	in

	(*	Raise an exception of the given rvalue type cannot be assigned
			to the given lvalue type or return the type of the assignment *)
	let check_assign lvaluet rvaluet err =
		if lvaluet == rvaluet then lvaluet else raise err
	in

	(**** Checking global variables ****)
	List.iter (check_not_void (fun n -> "illegal void global " ^ n)) globals;

	report_duplicate (fun n -> "duplicate global " ^ n) (List.map snd globals);

	(**** Checking functions ****)
	if List.mem "print" (List.map (fun fd -> fd.fname) functions)
	then raise (Failure ("function print may not be defined"))
	else ();

	report_duplicate (fun n -> "duplicate function " ^ n) (List.map (fun fd -> fd.fname) functions);

	(*	Function declaration for a named function	*)
