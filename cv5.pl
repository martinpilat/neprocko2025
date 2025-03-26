%najdi(+S, ?H, -X1, -X2):-X1 , X2 jsou cisla z S, t.z. X1+X2=H. 
najdi(S,H,X1,X2):-member(X1, S), member(X2, S), H is X1+X2.

prvek(_, []):-write("Jsem uplne prazdny").
prvek(X, [X|_]).
prvek(X, [_|Xs]):-prvek(X, Xs).

:- dynamic kapacity/2.

%dalsi(+S, -DS):-DS je stav jednim krokem dostazitelny z S
dalsi(_-V2, 0-V2).
dalsi(V1-_, V1-0).
dalsi(_-V2, C1-V2):-kapacity(C1, _).
dalsi(V1-_, V1-C2):-kapacity(_, C2).
dalsi(V1-V2, NV1-NV2):-kapacity(C1, C2), C2 >= V1 + V2, NV1=0, NV2 is V1 + V2.
dalsi(V1-V2, NV1-NV2):-kapacity(C1, C2), C2 < V1 + V2, NV1 is V1 + V2 - C2, NV2 is C2.
dalsi(V1-V2, NV1-NV2):-kapacity(C1, C2), C1 >= V2 + V1, NV2=0, NV1 is V2 + V1.
dalsi(V1-V2, NV1-NV2):-kapacity(C1, C2), C1 < V2 + V1, NV2 is V2 + V1 - C1, NV1 is C1.

%vyres(+PS, +KS):-z pocatecniho stavu PS se lze dostat do koncoveho KS
vyresCyklus(PS, PS). % vzdy se zacykli
vyresCyklus(PS, KS):-dalsi(PS, MS), vyresCyklus(MS, KS).

vyresDFS(PS, KS, Cesta):-vyresDFS(PS, [PS], KS, Cesta).
vyresDFS(PS, NS, PS, Cesta):-reverse(NS, Cesta).
vyresDFS(PS, NS, KS, C):-dalsi(PS, MS), \+member(MS, NS), 
                         vyresDFS(MS, [MS|NS], KS, C).

heur(_,_,1).

vyresID(PS, KS, Cesta):-heur(PS, KS, H),
                        between(H,inf,Lim), 
                        vyresID(PS, [PS], Lim, KS, Cesta),!.
vyresID(PS, NS, 0, PS, Cesta):-reverse(NS, Cesta).
vyresID(PS, NS, Lim, KS, C):-heur(PS, KS, H), Lim >= H, Lim1 is Lim - 1,
                             dalsi(PS, MS), \+member(MS, NS), 
                             vyresID(MS, [MS|NS], Lim1, KS, C).

vyres(PS, KS, C1, C2, C):-assert(kapacity(C1, C2)), vyresID(PS, KS, C).

graf(grafsn([1,2,3,4], [1->[2,4], 2->[3], 3->[4,2], 4->[1,2,3]])).

%map(+S, @F, -Y):-aplikuje F(A, B) na vsechny prvky A 
%                        seznamu S a ulozi B do Y
map([], _, []).
map([X|Xs], F, [Y|Ys]):-call(F, X, Y), map(Xs, F, Ys).

pricti1(X, Y):-Y is X+1.
