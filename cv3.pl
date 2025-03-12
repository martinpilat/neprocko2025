prostredni(S, P):-prostredni(S,S,P).
prostredni([X|_], [], X).
prostredni([X|_], [_], X).
prostredni([_|Xs], [_,_|Ys], P):-
    prostredni(Xs, Ys, P).

generuj(N, S):-generuj(0, N, S).
generuj(N, N, [N]).
generuj(A, N, [A|S1]):-A < N, A1 is A+1, generuj(A1, N, S1).

f(X, Y):-Y is X +2.

generujF(0, _, _, []).
generujF(N, F, I, [I|S1]):-call(F, I, I1), 
                          N1 is N - 1, 
                          N1 >= 0,
                          generujF(N1, F, I1, S1).
