:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dcgs)).
:- use_module(library(reif)).

/*
compress(Xs, Ys) holds when Ys is the "compressed" version of Xs.
Does not generalize (for every situation).

?- compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
   X = "abcade"
;  false.
?- compress(X,"abcade").
  loops.
?- compress(Xs,"a").
   Xs = "a"
;  Xs = "aa"
;  Xs = "aaa"
;  ... .
*/

if_(C_1, Then__0, Else__0, Xs0,Xs) :-
   if_(C_1, phrase(Then__0, Xs0,Xs), phrase(Else__0, Xs0,Xs) ).

compress_([]) --> [].
compress_([X]) --> [X].
compress_([X|[Y|Xs]]) --> 
  if_( X = Y, [], [X] ),
  compress_([Y|Xs]).

compress(Xs, Ys) :- phrase(compress_(Xs), Ys).