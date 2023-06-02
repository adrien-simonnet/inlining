{
  open Parser
}

rule jetons = parse
| "(*" { commentaires lexbuf }
| "(" { PARENTHESE_OUVRANTE }
| ")" { PARENTHESE_FERMANTE }
(*| "[" { CROCHET_OUVRANT }
| "]" { CROCHET_FERMANT }
| "{" { ACCOLADE_OUVRANTE }
| "}" { ACCOLADE_FERMANTE }*)

| ['0'-'9']+ as integer  { NAT (int_of_string integer) }
| "+" { PLUS }
| "-" { MOINS }

| "print" { PRINT }

(*| "cons" { CONS }
| "::" { DEUX_POINTS_DEUX_POINTS }
| "hd" { HD }
| "tl" { TL }*)

| "if" { IFZERO }
(*| "ifempty" { IFEMPTY }*)
| "then" { THEN }
| "else" { ELSE }

| "fun" { FUN }
(*| "fix" { FIX }*)
| "->" { FLECHE }

| "let" { LET }
| "rec" { REC }
| "and" { AND }
| "=" { EGAL }
| "in" { IN }

| "match" { MATCH }
| "with" { WITH }

| "type" { TYPE }
| "of" { OF }
| "|" { BARRE }

(*| "ref" { REF }
| "!" { EXCLAMATION }
| ":=" { DEUX_POINTS_EGAL }*)

(*| ":" { DEUX_POINTS }
| "," { VIRGULE }
| "." { POINT }*)

| "_" { JOKER }

| ['a'-'z''A'-'Z''_']['a'-'z''A'-'Z''0'-'9''_']* as identificateur { IDENT (identificateur) }

| [' ' '\t' '\n' '\r'] { jetons lexbuf }

| eof { EOF }

| _ as c{ raise(Failure ("unexpected character " ^ (String.make 1 c))) }

and commentaires = parse
| "*)" { jetons lexbuf }
| _ { commentaires lexbuf }
