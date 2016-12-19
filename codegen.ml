module L = Llvm
module A = Ast
module StringMap = Map.Make(String)

open Llvm_bitreader
open Llvm_linker

let translate (globals, functions) =
    let context = L.global_context () in
    let the_module = L.create_module context "PhysEx"
      and f32_t = L.float_type context
      and i64_t = L.i64_type context
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
      | A.Float -> f32_t
      | A.LongDouble -> i64_t
      | A.Str_p -> L.pointer_type str_t
      | A.Int_p -> L.pointer_type i32_t
      | A.Float_p -> L.pointer_type f32_t
    in
(*
    let linker filename =
      let llctx = L.global_context () in
      let llmem = L.MemoryBuffer.of_file filename in
      let llm = Llvm_bitreader.parse_bitcode llctx llmem in
      ignore(link_modules' the_module llm)
    in

    let r = linker "psleep.bc" in *)

    let global_vars =
      let global_var m (t, n) =
        let init = L.const_null (ltype_of_typ t) (* Check if 0 is needed *)
        in StringMap.add n (L.define_global n init the_module) m in
      List.fold_left global_var StringMap.empty globals
    in

    let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
    let calloc_t = L.function_type str_t [|i32_t;i32_t|] in
    let sleep_t = L.function_type i32_t [| i32_t |] in
    let clock_t = L.function_type i64_t [||] in

    let printf_func = L.declare_function "printf" printf_t the_module in
    let calloc_func = L.declare_function "calloc" calloc_t the_module in
    let sleep_func = L.declare_function "sleep" sleep_t the_module in
    let clock_func = L.declare_function "clock" clock_t the_module in

    let function_decls =
      let function_decl m fdecl =
        let name = 
        	if fdecl.A.fname = "simulation" then "main" else fdecl.A.fname and
            formal_types = Array.of_list (List.map(fun (t,_) -> ltype_of_typ t) fdecl.A.formals)
        in
        let ftype = L.function_type (ltype_of_typ fdecl.A.typ) formal_types in
          StringMap.add name (L.define_function name ftype the_module, fdecl) m in
          List.fold_left function_decl StringMap.empty functions in

        let build_function_body fdecl =
        	let name = if fdecl.A.fname = "simulation" then "main" else fdecl.A.fname in
          let (the_function, _) = StringMap.find name function_decls in
          let builder = L.builder_at_end context (L.entry_block the_function) in

          let str_format = L.build_global_stringptr "%s\n" "fmt" builder in
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


        let init_arr v s = let tp = L.element_type (L.type_of v) in
          let sz = L.size_of tp in
          let sz = L.build_intcast sz (i32_t) "" builder in
          let dt = L.build_bitcast (L.build_call calloc_func [|s;sz|] "" builder) tp "" builder in
            L.build_store dt v builder
        in

        let rec expr builder = function
            A.NumLit i -> L.const_int i32_t i
          | A.FloatLit f -> L.const_float i32_t f
          | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
          | A.Id s-> L.build_load (lookup s) s builder

          | A.ArrayInit (v, s)-> let var = (lookup v) and size = (expr builder s) in
            init_arr var size

          | ArrayAsn (v, i, e) -> let var = (expr builder (A.Id v))
              and index = (expr builder i) and value = (expr builder e) in
              let k = L.build_in_bounds_gep var [|index|] "" builder in
              L.build_store value k builder

          | ArrayRead (v, i) -> let var = (expr builder (A.Id v))
              and index = (expr builder i) in
              let k = L.build_in_bounds_gep var [|index|] "" builder in
              L.build_load k "" builder

          | A.Noexpr -> L.const_int i32_t 0
          | A.Binop(e1, op ,e2) ->
              let e1' = expr builder e1
              and e2' = expr builder e2 in
              (match op with
                A.Add     -> L.build_add
              | A.Sub     -> L.build_sub
              | A.Mult    -> L.build_mul
              | A.Div     -> L.build_sdiv
              | A.And     -> L.build_and
              | A.Or      -> L.build_or
              | A.Equal   -> L.build_icmp L.Icmp.Eq
              | A.Neq     -> L.build_icmp L.Icmp.Ne
              | A.Less    -> L.build_icmp L.Icmp.Slt
              | A.Leq     -> L.build_icmp L.Icmp.Sle
              | A.Greater -> L.build_icmp L.Icmp.Sgt
              | A.Geq     -> L.build_icmp L.Icmp.Sge
              ) e1' e2' "tmp" builder
          | A.Unop(op, e) ->
              let e' = expr builder e in
              (match op with
                A.Neg     -> L.build_neg
              | A.Not     -> L.build_not) e' "tmp" builder
          | A.StringLit b ->
          		let arr = L.build_global_stringptr b "" builder in
          		let zero = L.const_int i32_t 0 in
          		let s = L.build_in_bounds_gep arr [| zero |] "" builder in s
          | A.Call ("print", [e]) ->
              L.build_call printf_func [| str_format; (expr builder e) |]
              "printf" builder
          | A.Call ("printi", [e]) ->
              L.build_call printf_func [| int_format_str; (expr builder e) |]
              "printf" builder


          | A.Call ("sleep", [e]) ->
            L.build_call sleep_func [| (expr builder e) |]
            "sleep" builder
          | A.Call ("clock", e) ->
            L.build_call clock_func [||]
            "clock" builder


          | A.Call (f, act) ->
              let (fdef, fdecl) = StringMap.find f function_decls in
                let actuals = List.rev (List.map (expr builder) (List.rev act)) in
                let result = (match fdecl.A.typ with A.Void -> ""
                              | _ -> f ^ "_result") in
                L.build_call fdef (Array.of_list actuals) result builder
          | A.Assign (s, e) -> let e' = expr builder e in
    	          ignore (L.build_store e' (lookup s) builder); e'
        in

        let add_terminal builder f =
            match L.block_terminator (L.insertion_block builder) with Some _ -> ()
          | None -> ignore (f builder)
        in


        let rec stmt builder = function
            A.Block sl -> List.fold_left stmt builder sl
          | A.Expr e -> ignore (expr builder e); builder
          | A.Return e -> ignore (match fdecl.A.typ with
              A.Void -> L.build_ret_void builder
              | _ -> L.build_ret (expr builder e) builder); builder
          | A.If (predicate, then_stmt, else_stmt) ->
              let bool_val = expr builder predicate in
              let merge_bb = L.append_block context "merge" the_function in
              let then_bb = L.append_block context "then" the_function in
              add_terminal (stmt (L.builder_at_end context then_bb) then_stmt)
                (L.build_br merge_bb);
              let else_bb = L.append_block context "else" the_function in
              add_terminal (stmt (L.builder_at_end context else_bb) else_stmt)
                (L.build_br merge_bb);

              ignore (L.build_cond_br bool_val then_bb else_bb builder);
              L.builder_at_end context merge_bb
          | A.While (predicate, body) ->
              let pred_bb = L.append_block context "while" the_function in
              ignore (L.build_br pred_bb builder);

              let body_bb = L.append_block context "while_body" the_function in
              add_terminal (stmt (L.builder_at_end context body_bb) body)
                (L.build_br pred_bb);

              let pred_builder = L.builder_at_end context pred_bb in
              let bool_val = expr pred_builder predicate in

              let merge_bb = L.append_block context "merge" the_function in
              ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
              L.builder_at_end context merge_bb
          | A.For (e1, e2, e3, body) -> stmt builder
              (A.Block [A.Expr e1; A.While (e2, A.Block [body ; A.Expr e3])])
        in

        let builder = stmt builder (A.Block fdecl.A.body) in

        add_terminal builder (match fdecl.A.typ with
            A.Void -> L.build_ret_void
          | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))

  in

  List.iter build_function_body functions;
  the_module
