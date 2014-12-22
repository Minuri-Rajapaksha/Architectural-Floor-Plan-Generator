% To write the output of the polog predicate to a text file
% lengthL([1,2,3,4,5],N), open('out.txt', write, Out), write(Out,N),
% close(Out).

% Depth Limit Code
prove(true,N):-N>0.
prove((Goal1,Goal2),N):-N>0,prove(Goal1,N),prove(Goal2,N).
prove(Goal,D):-D>0,dif(true,Goal),X is D-1,clause(Goal,Body),prove(Body,X).



% Definition to the house plan
housePlan(T) :- polygon(T).
housePlan([H|T]) :- polygon(H), housePlan(T).



% Definition to line
line([[X1,Y1],[X2,Y2]]) :- between(1,10,X1), between(1,10,X2),between(1,10,Y1),between(1,10,Y2).



% Definition to polygon

polygon(X) :- isClosed(X), isConnected(X).

	isClosed([[X1,Y1]|L]) :- last(L, [X2,X1]).

	isConnected([[X1,Y1],[Y1,Z1],[Z1,U1]]):- line([X1,Y1]),line([Y1,Z1]),line([Z1,U1]).

	isConnected([[X1,Y1]|[[Y1,Z1]|L]]):- isConnected([[Y1,Z1]|L]), line([X1,Y1]),line([Y1,Z1]).



% Find the adjacency of two lines

adjacent(X,Y) :-( findNth(X,[A,B]), findNth(Y,[A,B])) ; ( findNth(X,[A,B]), findNth(Y,[B,A]) ).

	% To find a member variable
	findNth([X|T],X) .
	findNth([H|T],X) :- findNth(T,X).



% To validate two polygons, add the all lines of the two polygons into one list

combineTwoPolygons([T1],[T2], BL) :- addToList(T1,BL,[]), addToList(T2,BL,[]).
combineTwoPolygons([H1|T1],[H2|T2],BL) :- addToList(H1,BL,T1), addToList(H2,BL,T2),combineTwoPolygons(T1,T2,BL).

	% To add element to a list
	addToList(H,[H|T],T).
	addToList(X,[H|T],[H|R]) :- addToList(X,T,R).

% To check the direction of rooms of house plan

% housePlanLineList([P1,P2], HL) :- combineTwoPolygons(P1,P2,HL).
% housePlanLineList([P1|[P2|PN]], HL) :- combineTwoPolygons(P1,P2,L1),
% housePlanLineList(PN, L2), addToList(L1,L2,HL).

% get set of polygons and add all the coordinates of the polygons into one list

housePlanLineList([P1,P2], HL) :-  append(P1, P2, HL).
housePlanLineList([P1|[P2|PN]], HL) :-  append(P1, P2, L1), housePlanLineList(PN, L2), append(L1,L2,HL).

findCenterStep1([[X1,Y1],[X2,Y2]], XC, YC, N) :- XC is X1 + X2, YC is Y1 + Y2, N is 1.
findCenterStep1([[X1,Y1]|[[X2,Y2]|LN]], XC, YC, N) :- XT is X1 + X2, YT is Y1 + Y2, findCenterStep1(LN, XP, YP, N1), N is N1+1, XC is XT + XP, YC is YT + YP.


% countExist([H,T],N) :- findNth(H,T), N is 1.
% countExist([H|T],N) :- findNth(H,T), countExist(T, N).


countExist([H,T],R1) :- findNth(T,H), addToList(H,T,R1).
countExist([H|T],R) :- (findNth(T,H), addToList(H,[H|T],R1), countExist(R1,R)); append(R,H,R).


%deleteUnwanted([H|T],R) :- character_count([H

countExist2([H|T],R1) :- findNth(T,H), addToList(H,[H|T],R1).


% from internet - stackoverflow

% Find the occurrences of given element in list
%
% occurrences([a,b,c,a],a,X).
% -> X = 2.

% to count number of times that an element exists in a list - correct
occurrences([],_,0).
occurrences([X|Y],X,N):- occurrences(Y,X,W),N is W + 1.
occurrences([X|Y],Z,N):- occurrences(Y,Z,N),X\=Z.

%countMe([H,H],[]).
%countMe([H|T],R) :- occurrences([H|T],H,N), N>1, deleteMe(H,R,T).
%countMe([H|T],R) :-  countMe(T,R), N<1.

%countMe([H,T],[H,T]):- occurrences([H,T],H,N), N<1.
%countMe([H,T],[]):- occurrences([H,T],H,N), N>1.
countMe([],[]).
countMe([H|T],R) :- occurrences([H|T],H,N), N>1, deleteMe(H,R1,T),deleteMe(H,R2,R1), countMe(R2,R).
countMe([H|T],R) :- occurrences([H|T],H,N), N<1, countMe(T,R).


% correct code to find the boundry of a house
boundary([],R,R).
boundary([H|L],T,R) :- occurrences(L,H,N), N>=1, deleteMe(H,T,R1), deleteMe(H,R1,R2), boundary(L,R2,R).
boundary([H|L],T,R) :- occurrences(L,H,N), N<1, boundary(L,T,R).

orderBoundary([],R,R).
orderBoundary([[X,Y]|[[Z,U]|L]], T, R) :- X is Z, append([X,Y],R1,R4),append([Z,U],R4,R), deleteMe([X,Y],T,R2), deleteMe([Z,U],R2,R3), orderBoundary(L,R3,R).
orderBoundary([[X,Y]|[[Z,U]|L]], T, R) :- X is U, append([X,Y],R1,R4),append([U,Z],R4,R), deleteMe([X,Y],T,R2), deleteMe([Z,U],R2,R3), orderBoundary(L,R3,R).

%deleteFromList([H|T],R) :- .

deleteMe(H,[H|T],T):- !.
deleteMe(X,[H|T],[H|R]) :- deleteMe(X,T,R).

noBothRoomPrivate(X,Y) :- countMe(X,Y).
%noSpecialPrivacy(X,Y) :- countMe(X,Y).

path(X,Y,[],N) :- adjacent(X,Y), noBothRoomPrivate(X,Y).
path(X,Y,[Z|I],N) :- N>0, N2 is N-1, adjacent(X,Z), noBothRoomPrivate(X,Z), path(Z,Y,I,N2).

