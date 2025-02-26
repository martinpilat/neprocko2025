:- use_module(library(clpfd)).

%muz(?X):-Z je muz
muz(martin).
muz(pavel).
muz(petr).

%zena(?X):-X je zena
zena(jana).
zena(jitka).
zena(klara).

%rodic(?X, ?Y):-X je rodic Y
rodic(pavel, jana).
rodic(pavel, petr).

otec(X, Y):-rodic(X, Y), muz(X).

bratr(B, X):-X #\= B,
             muz(B),
             rodic(Y, X), 
             rodic(Y, B).