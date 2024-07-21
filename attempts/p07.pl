:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dcgs)).
:- use_module(library(si)).

/*
flatten(Xs, Ys) holds when Ys is the "flattened" version of Xs.

A good prolog functions can run backwards. Yet when you think about
it, the function flatten is not reversable. You can define a function
that removes one layer (seqq), or one that reports removing any number
of layers (maybe name it seqq*?), but flattens requires "Removing as 
many layers as possible" and that's tough to define.

See https://stackoverflow.com/questions/58902317/how-do-i-rewrite-the-following-so-it-uses-if
for a admirable attempt to make flatten runs backwards sometimes.

?- flatten([a, [b, [c, d], e]], X).
   X = "abcde".
?- flatten(X, "abcde").
   error(instantiation_error,list_si/1).
*/


flatten_([]) --> [].
flatten_([X|Xs]) --> 
  ( {list_si(X)} -> flatten_(X); [X] ), flatten_(Xs).
flatten(Xs, Ys) :- phrase(flatten_(Xs), Ys).