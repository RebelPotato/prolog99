:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
% :- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
:- use_module(library(random)).
/*
combination(N, L0, L) succeeds when L is a selection of L0 with length N.
general.

?- combination(#3, L, "abc").
   L = [a,b,c|_A]
;  L = [a,b,_A,c|_B]
;  L = [a,b,_A,_B,c|_C]
;  ... .
*/

oneof([X|Xs], X, Xs).
oneof([X|Xs], Y, [X|Ys]) :- oneof(Xs, Y, Ys).

combination(#0, _, []).
combination(#N0, Xs0, [Y|Ys]) :-
  #N #= #N0 - 1,
  oneof(Xs0, Y, Xs),
  combination(#N, Xs, Ys).