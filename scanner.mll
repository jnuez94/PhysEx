{ open Parser }

rule token = parse
	[' ' '\t' '\r' '\n'] { token lexbuf }
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| '/' { DIVIDE }
| '%' { MOD }

| ['0'-'9']+ as lit { LITERAL(int_of_string lit) }
| eof { EOF }
| ['a'-'z''A'-'Z']['_''0'-'9''a'-'z''$''A'-Z']* as lit { VARIABLE() }
| ',' { SEQ }

| '=' { ASN }
| "*=" { MULTASN }
| "/=" { DIVASN }
| "+=" { PLUSASN }
| "-=" { SUBASN }

| "!=" { NE }
| "==" { EQ }
| "<" { LT }
| "<=" { LTE }
| ">" { GT }
| ">=" { GTE }

| "||" { OR }
| "&&" { AND }
| '!' { NOT }

| "if" { IF }
| "else" { ELSE }
| "else if" { ELIF }

| "while" { WHILE }
| "for" { FOR }

| "function" { FUNC }
| "stimulus" { STIM }

| "int" { INT }
| "char" { CHAR }
| "string" { STR }
| "float" { FLT }
| "bool" { BOOL }
| "blob" { BLOB }
