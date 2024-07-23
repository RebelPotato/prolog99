:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
% :- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
:- use_module(library(random)).
:- use_module(library(debug)).
/*
rnd_select(Xs, N, Ys) holds when Ys has N randomly selected elements
from Xs.
Well running this in reverse is fun.

?- rnd_select(L, #3, "abd").
   L = "dab"
;  L = [a,_A|"db"]
;  L = [d,_A,b,_B|"a"]
;  L = [_A,a,_B,b,d,_C]
;  L = [b,d,_A,_B,_C,a,_D]
;  L = [a,_A,d,_B,b,_C,_D,_E]
;  L = [b,_A,_B,_C,d,_D,a,_E,_F]
;  L = [_A,_B,_C,_D,a,d,_E,_F,_G|"b"]
;  L = [d,b,_A,_B,_C,_D,_E,_F,a,_G,_H]
;  L = [_A,_B,_C,_D,_E,_F,a,_G,_H,b,_I|"d"]
;  ... .

?- rnd_select(X, #N, Y).
   N = 0, Y = []
;  X = [_A], N = 1, Y = [_A]
;  X = [_A,_B], N = 1, Y = [_A]
;  X = [_A,_B], N = 2, Y = [_A,_B]
;  X = [_A,_B,_C], N = 1, Y = [_C]
;  X = [_A,_B,_C], N = 2, Y = [_C,_B]
;  X = [_A,_B,_C], N = 3, Y = [_C,_B,_A]
;  X = [_A,_B,_C,_D], N = 1, Y = [_C]
;  X = [_A,_B,_C,_D], N = 2, Y = [_C,_B]
;  X = [_A,_B,_C,_D], N = 3, Y = [_C,_B,_D]
;  X = [_A,_B,_C,_D], N = 4, Y = [_C,_B,_D,_A]
;  ... .
This is incomplete because of the "randomness" inside.

*/

length([], #0).
length([_|Xs], #N0) :- #N #= #N0 - 1, length(Xs, #N).

remove_at(X, [X|Xs], #1, Xs).
remove_at(X, [A|Xs], #N0, [A|Ys]) :-
  #N0 #> 1,
  #N #= #N0 - 1,
  remove_at(X, Xs, #N, Ys).

/*
the length from library lists is buggy???
?- $ rnd_select("abcdefghi", #3, L).
call:user:rnd_select("abcdefghi",#3,A).
call:user:length("abcdefghi",A).
exit:user:length("abcdefghi",9).
call:user:random_integer(1,10,A).
exit:user:random_integer(1,10,5).
call:user:rnd_select("abcdfghi",#2,A).
call:user:length("abcdfghi",A).
exit:user:length("abcdfghi",13).
call:user:random_integer(1,14,A).
exit:user:random_integer(1,14,10).
   false.
?- length("abcdfghi",A).
   A = 8.
revisit someday
*/
rnd_select(_Xs, #0, []).
rnd_select(Xs0, #N0, [X|Ys]) :-
  #N0 #> 0,
  #N #= #N0 - 1,
  length(Xs0, #L0),
  #L #= #L0 + #1,
  random_integer(1, L, I),
  remove_at(X, Xs0, #I, Xs),
  rnd_select(Xs, #N, Ys).
