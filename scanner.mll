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
| '$'['0'-'9'] as lit { VARIABLE(int_of_char lit.[1] - 48) }
| ',' { COMMA }

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
| "null" { NULL }

| '(' { LPR }
| ')' { RPR }
| '{' { LBR }
| '}' { RBR }

| ';' { SEMICOLON }