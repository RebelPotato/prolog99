:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dif)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
:- use_module(library(si)).
/*
list_encode(Xs, Ys) holds when Ys is the "encoded" version of Xs.
Does not run backwards.

?- list_encode(X,Y).
   X = [_A], Y = [_A]
;  X = [_A,_A], Y = [[#2,_A]]
;  X = [_A,_A,_A], Y = [[#3,_A]]
;  ... .
*/

if_(Condition, Then, Else, S0, S) :-
  if_(Condition, phrase(Then, S0, S), phrase(Else, S0, S)).

% the "canonical" package is passed around and packed when outputed.
list_encode_([], P0) --> {pack_output(P0, P)}, [P].
list_encode_([X|Xs], [#N0, C0]) --> 
  if_(C0 = X,
    ({#N #= #N0 + #1, C = C0}, []),
    ({N = 1, C = X, pack_output([#N0, C0], P)}, [P])
  ),
  list_encode_(Xs, [#N, C]).

pack_output([#N, C], [#N, C]) :- #N #> #1.
pack_output([#1, C], C).

list_encode([X|Xs], Ys) :- phrase(list_encode_(Xs, [#1, X]), Ys).