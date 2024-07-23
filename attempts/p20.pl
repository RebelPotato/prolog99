:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
remove_at(X, Xs, N, Ys) holds when Xs's Nth element is X 
and Xs=Ys with this X removed.
Simple and general.

?- remove_at(X, Xs, #N, Ys).
   Xs = [X|Ys], N = 1
;  Xs = [_A,X|_B], N = 2, Ys = [_A|_B]
;  Xs = [_A,_B,X|_C], N = 3, Ys = [_A,_B|_C]
;  ... .
?- remove_at(X, Xs, #3, "abd").
   Xs = [a,b,X|"d"]
;  false.
?- remove_at(a, Xs, #3, Ys).
   Xs = [_A,_B,a|_C], Ys = [_A,_B|_C]
;  false.

*/

remove_at(X, [X|Xs], #1, Xs).
remove_at(X, [A|Xs], #N0, [A|Ys]) :-
  #N0 #> 1,
  #N #= #N0 - 1,
  remove_at(X, Xs, #N, Ys).