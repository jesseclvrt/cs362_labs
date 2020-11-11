% Jesse Calvert
% CS362, 1/14/2018
%
% Intoduction to lists and comparison

median(A, B, C, X) :-
    A >= B, A =< C, X is A;
    A >= C, A =< B, X is A;
    B >= A, B =< C, X is B;
    B >= C, B =< A, X is B;
    C >= A, C =< B, X is C;
    C >= B, C =< A, X is C.

% Alternate implementation
% contains([H|_], H).
% contains([_|T], X) :- contains(T, X).


contains([H|T], X) :- 
    X is H;
    contains(T, X).

largerEqual([], _).
largerEqual([H|T], X) :-
    X >= H,
    largerEqual(T, X).

max(List, X) :- contains(List, X), largerEqual(List, X).