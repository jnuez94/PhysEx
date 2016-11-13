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

(**	Return the type of an expression or throw an error
 *----------------------------------------------------------------------------*)



in List.iter check_function functions
