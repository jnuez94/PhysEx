module L = Llvm
module A = Ast
module StringMap = Map.Make(String)

let translate (globals, functions) =
  let context = L.global_context () in
  let the_module = L.create_module context "PhysEx"
    and i32_t = L.i32_type context
    and i8_t = L.i8_type context
    and i1_t = L.i1_type context
    and void_t = L.void_type context in
  let str_t = L.pointer_type i8_t in

  let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Void -> void_t
    | A.Str -> str_t
  in

  let global_vars =
    let global_var m (t, n) =
      let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals
  in

  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

  let function_decls =
    let function_decl m fdecl =
      let name = fdecl.A.fname and
          formal_types = Array.of_list (List.map(fun (t,_) -> ltype_of_typ t) fdecl.A.formals)
      in
      let ftype = L.function_type (ltype_of_typ A.Void) formal_types in
        StringMap.add name (L.define_function name ftype the_module, fdecl) m in
        List.fold_left function_decl StringMap.empty functions in

      let build_function_body fdecl =
        let (the_function, _) = StringMap.find fdecl.A.fname function_decls in
        let builder = L.builder_at_end context (L.entry_block the_function) in

        let int_format_str = L.build_global_stringptr "%d\n" "fmt" builder in

        let local_vars =
          let add_formal m (t, n) p = L.set_value_name n p;

      let local = L.build_alloca (ltype_of_typ t) n builder in ignore (L.build_store p local builder);
      StringMap.add n local m in
        let add_local m (t, n) =
          let local_var = L.build_alloca (ltype_of_typ t) n builder
          in StringMap.add n local_var m in

          let formals = List.fold_left2 add_formal StringMap.empty fdecl.A.formals
            (Array.to_list (L.params the_function)) in
          List.fold_left add_local formals fdecl.A.locals in

      let lookup n = try StringMap.find n local_vars
              with Not_found -> StringMap.find n global_vars
      in

      let rec expr builder = function
          A.NumLit i -> L.const_int i32_t i
        | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
        | A.StringLit b -> 
        		let arr = L.build_global_stringptr b "" builder in
        		let zero = L.const_int i32_t 0 in
        		let s = L.build_in_bounds_gep arr [| zero |] "" builder in s
        | A.Call ("print", [e]) ->
            L.build_call printf_func [| int_format_str; (expr builder e) |]
            "printf" builder
        | A.Call (f, act) ->
            let (fdef, fdecl) = StringMap.find f function_decls in 
              let actuals = List.rev (List.map (expr builder) (List.rev act)) in
              let result = "" in
              L.build_call fdef (Array.of_list actuals) result builder
      in

      let add_terminal builder f =
          match L.block_terminator (L.insertion_block builder) with Some _ -> ()
        | None -> ignore (f builder)
      in


      let rec stmt builder = function
          A.Block sl -> List.fold_left stmt builder sl
        | A.Expr e -> ignore (expr builder e); builder
      in



      let builder = stmt builder (A.Block fdecl.A.body) in

      add_terminal builder (match A.Void with
          A.Void -> L.build_ret_void
        | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))

in

List.iter build_function_body functions;
the_module
