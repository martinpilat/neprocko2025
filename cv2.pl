pricti1([], []).
pricti1([X|Xs], [X1|Xs1]):-X1 is X + 1,pricti1(Xs, Xs1).

secti([], 0).
secti([X|Xs], V):-secti(Xs, K), V is X + K.

secti2(X, V):-secti2(X, 0, V).
secti2([], A, A).
secti2([X|Xs], A, V):-A1 is A + X, secti2(Xs, A1, V).

prvek(X, [X|_]).
prvek(X, [_|Xs]):-prvek(X, Xs).

suda([], []).
suda([X|Xs], V):-0 =:= mod(X, 2), suda(Xs, Ys), V=[X|Ys].
suda([X|Xs], V):-0 =\= mod(X, 2), suda(Xs, Ys), V=Ys.