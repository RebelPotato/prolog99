:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
/*
list_pack(Xs, Ys) holds when Ys is the "packed" version of Xs.
Does not generalize. Why?

?- list_encode("aaabbbcccddddaa", X).
   X = [[3|"a"],[3|"b"],[3|"c"],[4|"d"],[2|"a"]]
;  false.
?- list_encode(X, [[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]]).
   loops.
*/

% pack
list_pack([], []).
list_pack([X|Xs], [Z|Zs]) :- transfer(X, Xs, Ys, Z), list_pack(Ys, Zs).

transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- dif(X, Y).
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).

% Maybe if we think in reverse ...
repeat(0, _) --> [].
repeat(N0, X) --> [X], { N #= N0 - 1 }, repeat(N, X).
count_same([N, X], Xs) :- phrase(repeat(N,X), Xs).

list_encode(Xs, Ys) :-
  list_pack(Xs, Xs0),
  maplist(count_same, Ys, Xs0).