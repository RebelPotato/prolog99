:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
slice(Xs, A, B, Ys) holds when Ys is a slice of Xs between A and B.
Simple and general and runs backwards too.

?- slice("abcdefghijk", #3, #7, L).
   L = "cdefg"
;  false.
?- slice(L, #3, #7, "cdefg").
   L = [_A,_B|"cdefg"]
;  L = [_A,_B,c,d,e,f,g,_C]
;  L = [_A,_B,c,d,e,f,g,_C,_D]
;  ... .
*/

% a unelegant dcgs solution
% which does not loop on a general query
% This is kinda fun.
if_(Condition, Then, Else, S0, S) :-
  if_(Condition, phrase(Then, S0, S), phrase(Else, S0, S)).

#=<(#A, #B, true) :- #A #=< #B.
#=<(#A, #B, false) :- #A #> #B.

% "functions" in a procedural language
% this is unidiomatic
slice_([], #_, #_, #_) --> [].
slice_([X|Xs], #A, #B, #N0) -->
  if_((#A #=< #N0, #N0 #=< #B), [X], []),
  { #N #= #N0 + 1 },
  slice_(Xs, #A, #B, #N).

slice(Xs, #A, #B, Ys) :- phrase(slice_(Xs, #A, #B, #1), Ys).

% and now an elegant solution
% which unfortunately loops on the most general query:
% ?- sli(X, #3, #7, Y).
sli([X|_], #1, #1, [X]).
sli([X|Xs], #1, #K0, [X|Ys]) :-
  #K0 #> 1,
  #K1 #= #K0 - 1,
  sli(Xs, #1, #K1, Ys).
sli([_|Xs], #I0, #K0, Ys) :-
  #I1 #= #I0 - 1,
  #K1 #= #K0 - 1,
  sli(Xs, #I1, #K1, Ys).