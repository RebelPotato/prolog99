:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
:- use_module(library(si)).
/*
list_decode(Xs, Ys) holds when Ys is the decoded version of Xs.


?- list_encode("aaabbbcccddddaa", X).
   X = [[3|"a"],[3|"b"],[3|"c"],[4|"d"],[2|"a"]]
;  false.
?- list_encode(X, [[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]]).
   loops.
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
% but this definition loops. Why? I think it's the repeat.