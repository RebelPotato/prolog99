:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dcgs)).

/*
my_last(X,Xs) holds when X is the last element of the list Xs.
Runs backwards too.

?- my_last_v1(a, Xs).
   Xs = "a"
;  Xs = [_A|"a"]
;  Xs = [_A,_B|"a"]
;  Xs = [_A,_B,_C|"a"]
;  ... .

*/
my_last_v1(X, [X]).
my_last_v1(X, [_|Xs]) :-
  Xs = [_|_],
  my_last_v1(X, Xs).

/*
The dcgs version is more concise and runs backwards too.
*/
my_last_v2_(X) --> seq(_), [X].
my_last_v2(X, Xs) :- phrase(my_last_v2_(X), Xs).