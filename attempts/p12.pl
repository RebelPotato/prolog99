:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
:- use_module(library(si)).
/*
list_decode(Xs, Ys) holds when Ys is the decoded version of Xs.
Quite general, but does not run backwards.

?- list_decode([[3|"a"],b,[3|"c"],d,[2|"a"]], X).
   X = "aaabcccdaa"
;  false.
?- list_decode(X, Y).
   X = [], Y = []
;  X = [[2,_A]], Y = [_A,_A]
;  X = [[2,_A],[2,_B]], Y = [_A,_A,_B,_B]
;  ... .
?- list_decode(X, "aaabbcccdee").
   error(instantiation_error,functor/3).
*/

% Easy with dcgs.

repeat(0, _, []).
repeat(N0, X, [X|Xs]) :-
  N0 #> 0, % comment me out and try me!
  N #= N0 - 1,
  repeat(N, X, Xs).

repeat_(0, _) --> [].
repeat_(N0, X) --> { N0 #> 0, N #= N0 - 1 }, [X], repeat_(N, X).
block_decode_([N, C]) --> { N #>= 2 }, repeat_(N, C).
block_decode_(X) --> { atomic_si(X) }, [X]. % one way passage, si!

list_decode_([]) --> [].
list_decode_([X|Xs]) --> block_decode_(X), list_decode_(Xs).

list_decode(Xs, Ys) :- phrase(list_decode_(Xs), Ys). 