:- module(actrule,[]).

swim(M,C) :-
  continent:continent(C),
  isinfact:isin(N,C),
  hassea:hassea(N),
  weather:weather(M,N,W),
  W=warm.

ski(M,C) :-
  continent:continent(C),
  isinfact:isin(N,C),
  hasmountain:hasmountain(N),
  weather:weather(M,N,W),
  W=snow.

hike(M,C) :-
  continent:continent(C),
  isinfact:isin(N,C),
  hasmountain:hasmountain(N),
  weather:weather(M,N,W),
  W=snow.
