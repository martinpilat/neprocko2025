%najdi(+S, ?H, -X1, -X2):-X1 , X2 jsou cisla z S, t.z. X1+X2=H. 
najdi(S,H,X1,X2):-member(X1, S), member(X2, S), H is X1+X2.

prvek(_, []):-write("Jsem uplne prazdny").
prvek(X, [X|_]).
prvek(X, [_|Xs]):-prvek(X, Xs).

kapacity(5,3).

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
vyres(PS, PS).
vyres(PS, KS):-dalsi(PS, MS), vyres(MS, KS).
