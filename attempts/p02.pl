:- set_prolog_flag(double_quotes, chars).

/*
but_last(X,Xs) holds when X is the second to last element of the list Xs.
Runs backwards too.
*/

but_last(X, [X, _]).
but_last(X, [_|[X2|[X3|Xs]]]) :- but_last(X, [X2|[X3|Xs]]).