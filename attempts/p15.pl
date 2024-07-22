:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
dupli(Xs, N, Ys) holds when Ys is the "duplicated N times" version of Xs.
Simple and (still quite) general.

?- dupli("abcda", #3, X).
   X = "aaabbbcccdddaaa"
;  false.
?- dupli(X, #3, Y).
   X = [], Y = []
;  X = [_A], Y = [_A,_A,_A]
;  X = [_A,_B], Y = [_A,_A,_A,_B,_B,_B]
;  X = [_A,_B,_C], Y = [_A,_A,_A,_B,_B,_B,_C,_C,_C]
;  ... .
?- dupli(X, #N, "aaaaaaaaaaaa").
   X = "a", N = 12
;  X = "aa", N = 6
;  X = "aaa", N = 4
;  X = "aaaa", N = 3
;  X = "aaaaaa", N = 2
;  X = "aaaaaaaaaaaa", N = 1
;  loops.
*/

% Easy with dcgs.

repeat(#0, _) --> [].
repeat(#N0, C) --> { #N0 #> 0, #N #= #N0 - 1 }, [C], repeat(#N, C).

dupli_([], _) --> [].
dupli_([X|Xs], #N) --> repeat(#N, X), dupli_(Xs, #N).
dupli(Xs, #N, Ys) :-
  length(Xs, Lx),
  length(Ys, Ly),
  #N #>= 0,
  #N #=< #Ly,
  if_(N=0, Ly=0, #Lx #=< #Ly),
  phrase(dupli_(Xs, #N), Ys).