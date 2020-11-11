% Jesse Calvert
% CS362, 2/14/2019
%
% Hitting set problem

%   (Set, Subsequence)
subseq([],[]).
subseq([Item | RestX], [Item | RestY]) :-
    subseq(RestX,RestY).
subseq(X, [_ | RestY]) :-
    subseq(X,RestY).

%   (Set1, Set2, Union)
union(Set1, [], Set1).
union([], Set2, Set2).
union([H|T], Set2, Union) :-
    member(H, Set2),
    union(T, Set2, UnsortUnion),
    sort(UnsortUnion, Union).
union([H|T], Set2, [H|UT]) :-
    not(member(H,Set2)),
    union(T,Set2,UT).

% (FamilyOfSets, Universe)
universe([], []). % even family case
universe([H1], H1). % odd family case
universe([H1,H2|T], Universe) :-
    union(H1, H2, Sub1),
    universe(T, Sub2),
    union(Sub1, Sub2, UnsortUni),
    sort(UnsortUni, Universe),!.

% true if the two sets have an intersection, otherwise false
intersectExists([H1|_], [H1|_]).
intersectExists([H1|T1], [H2|T2]) :-
    H1 > H2, intersectExists([H1|T1], T2),!;
    intersectExists(T1, [H2|T2]),!.

% (Family, Set) true if the set intersects every set in a family of sets, otherwise false.
intersectExistsAll([], _).
intersectExistsAll([H|T], Set) :-
    intersectExists(H, Set),
    intersectExistsAll(T, Set).

%   Finds valid hitting set solution for a given family of sets
hittingSet(Family, Solution) :-
    universe(Family, Universe),
    subseq(Solution, Universe),
    intersectExistsAll(Family, Solution).

% Finds the shortest list in a "list of lists"
shortest([L], L).
shortest([H|T], H) :- 
    length(H, N),
    shortest(T, X),
    length(X, M),
    N =< M.
shortest([_|T], X) :- shortest(T, X).

% Generates the smallest valid hitting set and returns the indexes of the sets required
minHittingSet(Family, Solution) :-
    findall(S, hittingSet(Family, S), L),
    shortest(L, Solution).