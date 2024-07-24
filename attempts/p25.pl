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
rnd_permu(L0, L) succeeds if L0 is a random permutation of L.
Does not work as very silly way to tell if two lists are the same via permuation.

?- rnd_permu("butts", L).
   L = "tbstu"
;  false.
*/
length([], #0).
length([_|Xs], #N0) :- #N #= #N0 - 1, length(Xs, #N).

remove_at(X, [X|Xs], #1, Xs).
remove_at(X, [A|Xs], #N0, [A|Ys]) :-
  #N0 #> 1,
  #N #= #N0 - 1,
  remove_at(X, Xs, #N, Ys).

rnd_select(_Xs, #0, []).
rnd_select(Xs0, #N0, [X|Ys]) :-
  #N0 #> 0,
  #N #= #N0 - 1,
  length(Xs0, #L0),
  #L #= #L0 + #1,
  random_integer(1, L, I),
  remove_at(X, Xs0, #I, Xs),
  rnd_select(Xs, #N, Ys).

rnd_permu(L0, L) :-
  length(L0, #N),
  rnd_select(L0, #N, L).