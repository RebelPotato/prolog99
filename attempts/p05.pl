:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dcgs)).

/*
list_reverse(Xs, Ys) holds when Xs is the reverse of Ys.
General.

?- list_reverse(Xs,Ys).
   Xs = [], Ys = []
;  Xs = [_A], Ys = [_A]
;  Xs = [_A,_B], Ys = [_B,_A]
;  Xs = [_A,_B,_C], Ys = [_C,_B,_A]
;  Xs = [_A,_B,_C,_D], Ys = [_D,_C,_B,_A]
;  ... .
*/

list_reverse_v1_([]) --> [].
list_reverse_v1_([X|Xs]) --> list_reverse_v1_(Xs), [X].
list_reverse_v1(Xs, Ys) :- phrase(list_reverse_v1_(Xs), Ys).

% Now translate this to list difference form to test my understanding...

list_reverse_([], L0, L0).
list_reverse_([X|Xs], L0, L) :- list_reverse_(Xs, L0, [X|L]).
list_reverse(Xs, Ys) :- list_reverse_(Xs, Ys, []).

% This is actually equivalent to reverse function
% using an accumulator in lisp for example.