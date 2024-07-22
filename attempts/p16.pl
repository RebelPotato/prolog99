:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
drop(Xs, N, Ys) holds when Ys is the "dropped every N" version of Xs.
Simple and general and runs backwards too!.

?- drop(X, #3, Y).
   X = [], Y = []
;  X = [_A], Y = [_A]
;  X = [_A,_B], Y = [_A,_B]
;  X = [_A,_B,_C], Y = [_A,_B]
;  X = [_A,_B,_C,_D], Y = [_A,_B,_D]
;  X = [_A,_B,_C,_D,_E], Y = [_A,_B,_D,_E]
;  X = [_A,_B,_C,_D,_E,_F], Y = [_A,_B,_D,_E]
;  ... .
?- drop(X, #3, "abdeghk").
   X = [a,b,_A,d,e,_B,g,h,_C|"k"]
;  false.
*/

% Easy with dcgs.


drop_([], #_, #_, []).
drop_([X|Xs], #N, #C0, Ys0) :-
  if_(#C0 #= 0,
    drop_(Xs, #N, #N, Ys0),
    ( #C #= #C0 - 1,
      Ys0 = [X|Ys],
      drop_(Xs, #N, #C, Ys)
    )
  ).

drop(Xs, #N0, Ys) :- #N #= #N0 - 1, drop_(Xs, #N, #N, Ys).