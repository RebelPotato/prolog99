:- set_prolog_flag(double_quotes, chars).
:- use_module(library(clpz)).

/*
element_at(X, Xs, N) holds when X is the Nth element of the list Xs, with head as the 1st element.
Runs backwards too.

?- element_at(c, Xs, N).
   Xs = [c|_A], N = 1
;  Xs = [_A,c|_B], N = 2
;  Xs = [_A,_B,c|_C], N = 3
;  Xs = [_A,_B,_C,c|_D], N = 4
;  ... .
*/

element_at(X, [X|_], 1).
element_at(X, [_|Xs], N0) :- 
  N #= N0 - 1,
  element_at(X, Xs, N).