:- set_prolog_flag(double_quotes, chars).
:- use_module(library(dcgs)).
:- use_module(library(si)).

/*
palindrome(Xs) holds when Xs is a palindrome.

Runs backwards.
*/

palindrome_ --> [].
palindrome_ --> [_].
palindrome_ --> [E], palindrome_, [E].
palindrome(Xs) :- phrase(palindrome_, Xs).