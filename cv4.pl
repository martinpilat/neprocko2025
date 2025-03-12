%soucet_podmnoziny(S, H, V):-V je podseznam S se souctem H
soucet_podmnoziny([], 0, []).
soucet_podmnoziny([X|Xs], H, [X|V]):-H1 is H - X, 
            soucet_podmnoziny(Xs, H1, V).
soucet_podmnoziny([_|Xs], H, V):-soucet_podmnoziny(Xs, H, V).

sp(S, H, V):-sp(S, H, 0, [], V).
sp(_, H, H, Ap, Ap).
sp(S, H, A, Ap, V):-select(P, S, S1), 
            A1 is A + P, 
            sp(S1, H, A1, [P|Ap], V).

%rozdel(Seznam, Pivot, Mensi, Vetsi)
rozdel([], _, [], []).
rozdel([X|Xs], P, [X|M], V):-X =< P, rozdel(Xs, P, M, V).
rozdel([X|Xs], P, M, [X|V]):-X > P, rozdel(Xs, P, M, V).

qsort([], []).
%qsort([X], [X]).
qsort([P|S], R):-rozdel(S, P, M, V), 
            qsort(M, SM), qsort(V, SV),
            append(SM, [P|SV], R).

%  Y=[1,2,3|X]-X, Z=[5,6|V]-V, X=[5,6|V], YZ=[1,2,3|X]-V.
srs1(X-XK, XK-YK, X-YK).
srs(X-XK, Y-YK, Z-ZK):-XK=Y,Z=X,ZK=YK.