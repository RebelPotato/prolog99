:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
rotate(Xs, N, Ys) holds when Ys is Xs rotated by #N elements.
Simple and general and runs backwards too.

?- rotate(X, -(#2), Y).
   X = [_A,_B], Y = [_A,_B]
;  X = [_A,_B,_C], Y = [_B,_C,_A]
;  X = [_A,_B,_C,_D], Y = [_C,_D,_A,_B]
;  ... .
?- rotate(X, #2, Y).
   X = [_A,_B], Y = [_A,_B]
;  X = [_A,_B,_C], Y = [_C,_A,_B]
;  X = [_A,_B,_C,_D], Y = [_C,_D,_A,_B]
;  ... .
?- rotate("abcdefg", N, "cdefgab").
   N = #2
;  N = - #5
;  false.  % This is fine, you can add longer-than-length rotates easily
*/

split(Xs, #0, [], Xs).
split([X|Xs], #N0, [X|Ys], Zs) :-
  #N0 #> 0,
  #N #= #N0 - 1,
  split(Xs, #N, Ys, Zs).

rotate(Xs, #0, Xs).
rotate(Xs, #N, Ys) :-
   #N #> 0,
   split(Xs, #N, Xs0, Xs1),
   append(Xs1, Xs0, Ys).

rotate(Xs, - #N, Ys) :-
   rotate(Ys, #N, Xs).