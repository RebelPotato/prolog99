:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(dcgs)).
% :- use_module(library(clpz)).
% clpz:monotonic.
% :- use_module(library(reif)).
% :- use_module(library(si)).
/*
dupli(Xs, Ys) holds when Ys is the "duplicated" version of Xs.
Simple and general.

?- dupli("abcda", X).
   X = "aabbccddaa".
?- dupli(X, "aabbccddaa").
   X = "abcda"
;  false.
?- dupli(X, Y).
   X = [], Y = []
;  X = [_A], Y = [_A,_A]
;  X = [_A,_B], Y = [_A,_A,_B,_B]
;  ... .
*/

% Easy with dcgs.
dupli_([]) --> [].
dupli_([X|Xs]) --> [X, X], dupli_(Xs).
dupli(Xs, Ys) :- phrase(dupli_(Xs), Ys).