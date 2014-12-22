parent(a,b).
parent(p,q).
parent(a,a).

relative(A,B):-parent(A,A).


relative(A,B):-parent(A,B).
ralative(A,B):-parent(B,A).


prove(true).

prove((Goal1,Goal2)) :- prove(Goal1), prove(Goal2).

prove(Goal) :- clause(Goal, Body) , prove(Body).


natnum1(0).
natnum1(s(X)) :- natnum1(X).
natnum1(s(X)) :- clause(X, Body), natnum1(Body).

% natnum1(Z).
% clause(natnum1(Z), Body).


%del(X,[X|L1],L1).
%del(X,[Y|L1],[Y|L2]) :- del(X,L1,L2).

%permute([],[]).
%permute(L,[X|P]) :- del(X,L,L1), permute(L1,P).

%sorted([]).
%sorted([N]).
%sorted([H,T]) :- H<T.
%sorted(H|[A|T]) :- sorted([A|T]), H<A.

%mySort(A,B) :- permute(B,A), sorted(B).


sorted([]).
sorted([N]).
sorted([C|[A|B]]):-sorted([A|B]), C<A.

delete(H,[H|T],T).
delete(X,[H|T],[H|R]):-delete(X,T,R).

perm([],[]).
perm(P,[H|B]):-perm(A,B),delete(H,P,A).

mysort(A,B):-perm(B,A), sorted(B).

sortList([[[A,B],[C,D]],[[E,F],[G,H]]]):- A<C, E<G, A<E.

intersectionConventions([[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]) .



