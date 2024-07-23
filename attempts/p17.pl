:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
split(Xs, N, Ys, Zs) holds when append(Xs, Ys, Zs) and length(Ys, N).
Simple and general and runs backwards too.

?- split("abcdefghijk", #3, X, Y).
   X = "abc", Y = "defghijk"
;  false.
?- split(L, #3, "abc", "defgh").
   L = "abcdefgh"
;  false.
?- split(X, N, Y, Z).
   X = Z, N = #0, Y = []
;  X = [_A|Z], N = #1, Y = [_A]
;  X = [_A,_B|Z], N = #2, Y = [_A,_B]
;  X = [_A,_B,_C|Z], N = #3, Y = [_A,_B,_C]
;  ... .
*/

% no dcgs, sorry

split(Xs, #0, [], Xs).
split([X|Xs], #N0, [X|Ys], Zs) :-
  #N0 #> 0,
  #N #= #N0 - 1,
  split(Xs, #N, Ys, Zs).