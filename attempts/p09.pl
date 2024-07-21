:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dcgs)).
:- use_module(library(reif)).
:- use_module(library(dif)).

/*
list_pack(Xs, Ys) holds when Ys is the "packed" version of Xs.
Generalized.

?- list_pack("aaabbbcccddddaa", X).
   X = ["aaa","bbb","ccc","dddd","aa"]
;  false.
?- list_pack(X, ["aaa","bbb","ccc","dddd","aa"]).
   X = "aaabbbcccddddaa"
;  false.
*/

% The complicated answer
% is also the less general one: it loops when reversed.

if_(Condition, Then, Else, X0, X) :-
  if_(Condition, phrase(Then, X0, X), phrase(Else, X0, X)).

% the state is the currently accumulated list
list_pack_v1_([], L) --> [L].
list_pack_v1_([X|Xs], [Y|Ys]) -->
  if_(X = Y,
    ({L = [X|[Y|Ys]]}, []),
    ({L = [X]}, [[Y|Ys]])
  ),
  list_pack_v1_(Xs, L).

list_pack_v1([], []).
list_pack_v1([X|Xs], Ys) :- phrase(list_pack_v1_(Xs, [X]), Ys).

% A simpler answer
% is also the more general one: it unpacks as well.
list_pack_v2([], []).
list_pack_v2(Xs0, [Y|Ys]) :- list_samehead_rest(Xs0, Y, Xs), list_pack_v2(Xs, Ys).

list_samehead_rest([X0], [X0], []).
list_samehead_rest([X|Xs], [X|[X|Ys]], Zs) :-
  list_samehead_rest(Xs, [X|Ys], Zs).
list_samehead_rest([X0|[X1|Xs]], [X0], [X1|Xs]) :- dif(X0, X1).

% Copied from the website, slightly prettier. the best answer?
% I don't think so...
list_pack([], []).
list_pack([X|Xs], [Z|Zs]) :- transfer(X, Xs, Ys, Z), list_pack(Ys, Zs).

transfer(X, [], [], [X]).
transfer(X, [Y|Ys], [Y|Ys], [X]) :- dif(X, Y).
transfer(X, [X|Xs], Ys, [X|Zs]) :- transfer(X, Xs, Ys, Zs).