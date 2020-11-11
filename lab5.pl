% Jesse Calvert
% CS362, 1/29/2019
%
% "Crossing the bridge" puzzle

% at most 2 crossing at one time, requires light
% move at speed of slowest person
% configuration order:   [a, b, me, c, light]
% initial configuration all left:   [l, l, l, l, l]
% desired configuration all right:  [r, r, r, r, r]

time(a, 1).
time(b, 2).
time(me, 5).
time(c, 10).
time([X,Y], T) :- time(X, TX), time(Y, TY), T is max(TX, TY).

%states that configuration C1 leads to C2 if S cross.
change(l, r).
change(r, l).

% move(C1, S, C2)
% configuration C1 leads to C2 when S moves.
% walking with a friend
move( [X,X,Me,C,X],     [a,b],      [Y,Y,Me,C,Y]    ) :- change(X,Y).
move( [X,B,X,C,X],      [a,me],     [Y,B,Y,C,Y]     ) :- change(X,Y).
move( [X,B,Me,X,X],     [a,c],      [Y,B,Me,Y,Y]    ) :- change(X,Y).
move( [A,X,X,C,X],      [b,me],     [A,Y,Y,C,Y]     ) :- change(X,Y).
move( [A,X,Me,X,X],     [b,c],      [A,Y,Me,Y,Y]    ) :- change(X,Y).
move( [A,B,X,X,X],      [me,c],     [A,B,Y,Y,Y]     ) :- change(X,Y).
%walking alone
move( [X,B,Me,C,X],     a,          [Y,B,Me,C,Y]    ) :- change(X,Y).
move( [A,X,Me,C,X],     b,          [A,Y,Me,C,Y]    ) :- change(X,Y).
move( [A,B,X,C,X],      me,         [A,B,Y,C,Y]     ) :- change(X,Y).
move( [A,B,Me,X,X],     c,          [A,B,Me,Y,Y]    ) :- change(X,Y).

% solution(C, L, T).
% List of L moves to the configuration C leads to a solution in T mins.
solution([r,r,r,r,r], [], T) :- T > 0. %sol in 0 time is impossible
solution(C, [Move|NextMove], T) :-
    move(C, Move, NextC),
    time(Move, TMove),
    TNew is T - TMove,
    TNew >=0,
    solution(NextC, NextMove, TNew).

% number generator, returns numbers 1 to inf
num(1).
num(X) :- num(Y), X is Y + 1.

% generate solutions from best to worst
getSolutions(Moves, T) :- 
    num(T),
    solution([l,l,l,l,l], Moves, T).