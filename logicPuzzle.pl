years([], []).
years([HN|TN], [HX|TX]) :- HX = [HN, _, _, _], years(TN, TX).

claimed([], _).
claimed([H|T], L) :- member([_, H, _, _], L), claimed(T, L).

regions([], _).
regions([H|T], L) :- member([_, _, H, _], L), regions(T, L).

actual([], _).
actual([H|T], L) :- member([_, _, _, H], L), actual(T, L).

% [year, claimed, region, actual]

hint1(X) :-
    member([_, legionnaire, eastAfrica, _], X).

hint2(X) :-
    member([Y1, _, _, mailMan], X),
    member([Y2,_,_, server], X),
    Y2 =:= Y1 + 3.

hint3(X) :-
    member([1976, _, middleEast, _], X).

hint4(X) :-
    member([Y1, treasure, _, hotelPage], X),
    member([Y2, _, sovietUnion, A], X),
    Y2 =:= Y1 + 3,
    A \= hotelPage.

hint5(X) :-
    member([1982, _, _, taxiDriver], X).

hint6(X) :-
    member([_, sspy, _, A], X),
    A \= server.

puzzle(X) :-
    length(X, 4), 
    years([1973, 1976, 1979, 1982], X), 
    claimed([legionnaire, sspy, bodyguard, treasure], X), 
    regions([middleEast, eastAfrica, sovietUnion, southAmerica], X), 
    actual([mailMan, hotelPage, server, taxiDriver], X), 
    hint1(X), 
    hint2(X), 
    hint3(X),
    hint4(X),
    hint5(X),
    hint6(X).
    

