:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
/*
list_encode(Xs, Ys) holds when Ys is the "other encoded" version of Xs.
Does not generalize.

*/

% pack
list_pack([], []).
list_pack([X|Xs], [Z|Zs]) :- transfer(X, Xs, Ys, Z), list_pack(Ys, Zs).

transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- dif(X, Y).
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).

% in reverse ...
repeat(0, _) --> [].
repeat(N0, X) --> [X], { N #= N0 - 1 }, repeat(N, X).
count_same([N, X], Xs) :- N #>= 2, phrase(repeat(N,X), Xs).
count_same(X, [X]).  % just special case it

list_encode(Xs, Ys) :-
  list_pack(Xs, Xs0),
  maplist(count_same, Ys, Xs0).