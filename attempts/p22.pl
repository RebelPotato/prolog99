:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
/*
range(A, B, L) holds when L contains the range of numbers between A and B.
Simple and general.

?- range(#4,#9,L).
   L = [#4,#5,#6,#7,#8,#9]
;  false.
?- range(#A, #B, [#4,#5,#6,#7,#8,#9]).
   A = 4, B = 9
;  false.

*/

% the perfect time for dcgs

range_(#A, #A) --> [#A].
range_(#A0, #B) --> { #A0 #< #B, #A #= #A0 + 1 }, [#A0], range_(#A, #B).
range(#A, #B, L) :- phrase(range_(#A, #B), L).