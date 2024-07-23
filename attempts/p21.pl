:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
insert_at(X, Xs, N, Ys) holds when  Xs=Ys with X inserted at the 
Nth position.
Wait, this is just remove_at reversed, is it not?

?- insert_at(u, "btt", #2, L).
   L = "butt"
;  false.
and there was much rejoicing

*/

remove_at(X, [X|Xs], #1, Xs).
remove_at(X, [A|Xs], #N0, [A|Ys]) :-
  #N0 #> 1,
  #N #= #N0 - 1,
  remove_at(X, Xs, #N, Ys).

insert_at(X, Xs, #N, Ys) :- remove_at(X, Ys, #N, Xs).