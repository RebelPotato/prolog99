:- set_prolog_flag(double_quotes, chars).
:- use_module(library(clpz)).

/*
list_length(N, Xs) holds when Xs has length N.
General.

?- list_length(X, Xs).
   X = 0, Xs = []
;  X = 1, Xs = [_A]
;  X = 2, Xs = [_A,_B]
;  X = 3, Xs = [_A,_B,_C]
;  ... .
*/

list_length(0, []).
list_length(N0, [_|Xs]) :- 
  N #= N0 - 1,
  list_length(N, Xs).