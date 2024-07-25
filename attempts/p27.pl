:- set_prolog_flag(double_quotes, chars).
% :- use_module(library(dif)).
:- use_module(library(lists)).
:- use_module(library(dcgs)).
:- use_module(library(clpz)).
clpz:monotonic.
:- use_module(library(reif)).
% :- use_module(library(si)).
:- use_module(library(random)).
/*
group(Xs, Ns, Ys) succeeds when you can group Xs into Ys with length Ns.
It runs backwards but does not halt.

?- group([aldo,beat,carla,david,evi,flip,gary,hugo,ida],[#2,#2,#5],Gs).
   Gs = [[aldo,beat],[carla,david],[evi,flip,gary,hugo,ida]]
;  Gs = [[aldo,beat],[carla,evi],[david,flip,gary,hugo,ida]]
;  Gs = [[aldo,beat],[carla,flip],[david,evi,gary,hugo,ida]]
;  Gs = [[aldo,beat],[carla,gary],[david,evi,flip,hugo,ida]]
;  ... .

?- group(Xs, [#2, #3, #4], ["ab","cde","fghi"]).
   Xs = "abcdefghi"
;  loops.
*/

% nOf(Xs, #N, Sel, Rest)
% select N numbers from Xs, the selected are Sel, others are Rest
nOf(Xs, #0, [], Xs).
nOf([X|Xs], #N0, [X|Sels], Rest) :-
  #N #= #N0 - 1,
  nOf(Xs, #N, Sels, Rest).
nOf([Y|Xs], #N, Sels, [Y|Rest]) :-
  #N #> #0,
  nOf(Xs, #N, Sels, Rest).

group(Xs, [#N], [Xs]) :- length(Xs, N).
group(Xs0, [#N|Ns], [Y|Ys]) :-
  nOf(Xs0, #N, Y, Xs),
  group(Xs, Ns, Ys).