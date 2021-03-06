% To write the output of the prolog predicate to a text file
% lengthL([1,2,3,4,5],N), open('out.txt', write, Out), write(Out,N),
% close(Out).


:- use_module(library(clpfd)).



% Depth Limit Code
prove(true,N):-N>0.
prove((Goal1,Goal2),N):-N>0,prove(Goal1,N),prove(Goal2,N).
prove(Goal,D):-D>0,dif(true,Goal),X is D-1,clause(Goal,Body),prove(Body,X).



% Definition to the house plan - H,T are polygons
housePlan(T) :- polygon(T).
housePlan([H|T]) :- polygon(H), housePlan(T).



% Definition to line
line([[X1,Y1],[X2,Y2]]) :- between(1,2,X1), between(1,2,X2),between(1,2,Y1),between(1,2,Y2), is_set([[X1,Y1],[X2,Y2]]).



% Definition to polygon

polygon(X) :- isClosed(X), isConnected(X).

	isClosed([[X1,Y1]|L]) :- last(L, [X2,X1]).

	isConnected([[X1,Y1],[Y1,Z1],[Z1,U1]]):- line([X1,Y1]),line([Y1,Z1]),line([Z1,U1]).

	isConnected([[X1,Y1]|[[Y1,Z1]|L]]):- isConnected([[Y1,Z1]|L]), line([X1,Y1]),line([Y1,Z1]).

% New Definition to polygon

polygonNew([[[X11,X12],[Y11,Y12]]|[[[Y11,Y12],[Z11,Z12]]|L]]) :- isClosedNew([[[X11,X12],[Y11,Y12]]|[[[Y11,Y12],[Z11,Z12]]|L]]), isConnectedNew([[[X11,X12],[Y11,Y12]]|[[[Y11,Y12],[Z11,Z12]]|L]],[X11,X12]).

	isClosedNew([[[X11,X12],[Y11,Y12]]|L]) :- last(L, [[X21,X22],[X11,X12]]), Y11>X21.

	isClosedNew([[[X11,X12],[Y11,Y12]]|L]) :- last(L, [[X21,X22],[X11,X12]]), Y11 is X21, Y12 < X22.

	isConnectedNew([[[X11,X12],[Y11,Y12]],[[Y11,Y12],[Z11,Z12]],[[Z11,Z12],[U11,U12]]], [XP1,XP2]):- line([[X11,X12],[Y11,Y12]]),line([[Y11,Y12],[Z11,Z12]]), line([[Z11,Z12],[U11,U12]]), X11>XP1.

        isConnectedNew([[[X11,X12],[Y11,Y12]],[[Y11,Y12],[Z11,Z12]],[[Z11,Z12],[U11,U12]]], [XP1,XP2]):- line([[X11,X12],[Y11,Y12]]),line([[Y11,Y12],[Z11,Z12]]), line([[Z11,Z12],[U11,U12]]), X11 is XP1, X12 > XP2 .

	isConnectedNew([[[X11,X12],[Y11,Y12]]|[[[Y11,Y12],[Z11,Z12]]|L]],[X11,X12]):- isConnectedNew([[[Y11,Y12],[Z11,Z12]]|L], [X11,X12]), X11<Y11, line([[X11,X12],[Y11,Y12]]),line([[Y11,Y12],[Z11,Z12]]).

        isConnectedNew([[[X11,X12],[Y11,Y12]]|[[[Y11,Y12],[Z11,Z12]]|L]],[X11,X12]):- isConnectedNew([[[Y11,Y12],[Z11,Z12]]|L], [X11,X12]), X11 is Y11, X12 < Y12, line([[X11,X12],[Y11,Y12]]),line([[Y11,Y12],[Z11,Z12]]).





% Find the adjacency of two lines, pass two polygons as the parameters

adjacent(X,Y) :-  findMember(X,[A,B]), findMember(Y,[A,B]).
adjacent(X,Y) :-  findMember(X,[A,B]), findMember(Y,[B,A]).

	% To find a member variable
	findMember([X|T],X) .
	findMember([H|T],X) :- findMember(T,X).


% To add element to a list
addToList(H,[H|T],T).
addToList(X,[H|T],[H|R]) :- addToList(X,T,R).

% get set of polygons and add all the coordinates of the polygons into
% one list

housePlanLineList([P1,P2], HL) :-  append(P1, P2, HL).
housePlanLineList([P1|[P2|PN]], HL) :-  append(P1, P2, L1), housePlanLineList(PN, L2), append(L1,L2,HL).




% --------------- Find the direction of a polygon ----------------- %


% find the boundry of a house, [H|L]=T=list of polygons, R=result,
% delete twice the redundant one
boundary([],R,R).
boundary([H|L],T,R) :- occurrences(L,H,N), N>=1, deleteMe(H,T,R1), deleteMe(H,R1,R2), boundary(L,R2,R).
boundary([H|L],T,R) :- occurrences(L,H,N), N<1, boundary(L,T,R).


       % to count number of times that an element exists in a list - correct
       occurrences([],_,0).
       occurrences([X|Y],X,N):- occurrences(Y,X,W),N is W + 1.
       occurrences([X|Y],Z,N):- occurrences(Y,Z,N),X\=Z.


% to order the above found boundary lines, T = [[X,Y]|[[Z,U]|L]]
orderBoundary([],R,R).
orderBoundary([[X,Y]|[[Z,U]|L]], T, R) :- Y is Z, append(R1,[X,Y],R4),append(R4,[Z,U],R), orderBoundary(L,L,R1).
orderBoundary([[X,Y]|[[Z,U]|L]], T, R) :- Y is U, append(R1,[X,Y],R4),append(R4,[U,Z],R), orderBoundary(L,L,R1).
orderBoundary([[X,Y]|[[Z,U]|L]], T, R) :-  orderBoundary(L,L,R).



% -------------- calculate the centroid of the house -------------- %




% find the Tan value of a room A=list of lines of house polygon, B=list
% of lines of room polygon, L1 is length from centroid house to top
% intersecting point, L2 is length from centroid house to centroid of
% room,
findTanBasic(A,B,L1,L2) :- centroidX(A,ACX), centroidY(A,ACY), centroidX(B,BCX), centroidY(B,BCY), findIntersectPointList([ACX,ACY],A,RL), getCorrectIntersectingPoint([ACX,ACY], RL, XTOP, YTOP), findLength(ACX,ACY,XTOP,YTOP,L1), findLength(ACX,ACY,BCX,BCY,L2).


	% Sigma {[(xi)+(xi+1)]*[(xi)(yi+1)-(xi+1)(yi)]} = CC
        centroidXbasic([[X,Y],[Z,U]], X1) :- X1 #= (X+Z)*((X*U) - (Y*Z)).
        centroidXbasic([[X,Y]|[[Z,U]|L]], XR ) :- X1 #= (X+Z)*((X*U) - (Y*Z)), XR #= X1+X2, centroidXbasic(L,X2).

        centroidYbasic([[X,Y],[Z,U]], Y1) :- Y1 #= (Y+U)*((X*U) - (Y*Z)).
	centroidYbasic([[X,Y]|[[Z,U]|L]], YR ) :- Y1 #= (Y+U)*((X*U) - (Y*Z)), YR #= Y1+Y2, centroidYbasic(L,Y2).


% A = list of lines of the polygon, CC/6A = Centroid value
centroidX(A,X) :- centroidXbasic(A,XR), findArea(A,AR), X #= XR /(6*AR).
centroidY(A,Y) :- centroidYbasic(A,YR), findArea(A,AR), Y #= YR /(6*AR).


% ----- find the length from poylgon centroid to top polygon
% intersecting point

	% point- [X,Y]=centroid of the polygon, [[[A,B],[C,D]]|T] = polygon line
	% list

        % find lines relevant to top intersect point in polygon, [X,Y] is
	% the centroid of the house polygon

	findIntersectPointList([X,Y], [[A,B],[C,D]],R  ) :- between(A,C,X), append([],[[A,B],[C,D]],R).
	findIntersectPointList([X,Y], [[[A,B],[C,D]]|T],R  ) :- between(A,C,X), append(R1,[[A,B],[C,D]],R), findIntersectPointList([X,Y], T, R1).

	% check for intersecting points [[[A,B],[C,D]]|T]=set of lines where
        % centroid X lays between = R coming from findTopIntersectPoint(),
        % select the most correct point of intersecting


        getCorrectIntersectingPoint([X,Y],[[A,B],[C,D]], XM, YM) :- calculateIntersectingPoint([X,Y], [[A,B],[C,D]], XM, YM),!.
        getCorrectIntersectingPoint([X,Y],[[[A,B],[C,D]]|T], XM, YM) :- calculateIntersectingPoint([X,Y], [[A,B],[C,D]], XM, YM), getCorrectIntersectingPoint([X,Y],T, XM, YM), YM #> Y.


                % calculate an intersecting point [[X1,Y1],[X2,Y2]] = line which
                % contains centroid's X coordinate in its range
                calculateIntersectingPoint([X3,Y3],[[X1,Y1],[X2,Y2]],XM,YM) :- XM is X3, YM #= (Y1 + (((Y2-Y1)*(X3-X1))/(X2-X1))).





% ---------------- Write the plan to a text file -------------------- %

% Testings
repeatMy.
repeatMy :- repeatMy.
dosquares :- repeatMy, read(X), (X = stop, !; Y is X*X, write(Y),fail).
writeHousePlan :- open('house.txt', write, Out), housePlan(A), write(Out,A).


% to write all the generated house plans into one text file
writeHousePlanMy :- open('house.txt', write, Out), housePlan(A), read(X), (X = stop, close(Out), !;  writeq(Out,A),writeq(Out,*),fail).


% ------------ Remove polygon redundancy and unnecessary polygons --- %

% validate house plan is a set of polygons and the polygons are
% adjacent, H is a polygon contains list of lines

% interconnected set of house polygon
housePlanInterconnected(T) :- polygon(T).
housePlanInterconnected([H|T]) :- polygon(H), housePlan(T), isAdjacentMemberMy(H,T), is_set([H|T]).

% checkHousePlan([H|T]) :- housePlan([H|T]), interconnected([H|T],[H|T]),
% length([H|T],Length), Length>2.
checkHousePlan([H|T]) :- housePlanInterconnected([H|T]), length([H|T],Length), Length>2.



% A = [H|T], check whether a set of polygons is interconnected. *** this
% is not necessary now
interconnected([],L).
interconnected([H|T],A) :- addToList(H,A,A2), isAdjacentMemberMy(H,A2), interconnected(T,A).

      % check whether a polygon has atleast one adjacent polygon in the list
      isAdjacentMemberMy(M,L) :- findMember(L,X), adjacent(X,M).



% remove repeating of same polygon, considering points of a polygon
% A=[H|T] *** this is not necessary now
checkPolygonRepeat([],L).
checkPolygonRepeat([H|T], A) :-  addToList(H,A,A2), isRepeatingPoints(H,A2), addToList(H,A2,A3), checkPolygonRepeat(A3,A3).
checkPolygonRepeat([H|T], A) :-  checkPolygonRepeat(T,T).

      % inner loop for checking repeating points
      isRepeatingPoints(M,[H]) :- getPolygonPoints(M,L1), getPolygonPoints(H,L2), subset(L1,L2).
      isRepeatingPoints(M,[H|T]) :- getPolygonPoints(M,L1), getPolygonPoints(H,L2), subset(L1,L2), isRepeatingPoints(M,T) .

            % when provide the lines list of a polygon gives the polygon points list
            getPolygonPoints([],[]).
            getPolygonPoints([[X,Y]|T],L) :- addToList(X,L,L1), getPolygonPoints(T,L1).






% ----------------- Find the area of a polygon ----------------- %

% pass a polygon and return the area of the polygon
findArea([[[A,B],[C,D]]|T], AR) :- Y #= (B+D)/2, X #= D-A, A1 #= Y*X, findArea(T,A2), AR is A1+A2.






% ----------------- Find the width of a polygon ---------------- %

% pass a polygon and gives a list of widths
findWidth([[[A,B],[C,D]],[[E,F],[G,H]]], L) :- findLength(A,G,B,H,L).
findWidth([[[A,B],[C,D]]|[[[E,F],[G,H]]|T]], L) :- findLength(A,G,B,H,L1), findWidth(T,L2), append(L2,L1,L).


% calculate the length between two coordinates coordinates are (A,B) and
% (G,H) L is the answer
findLength(A,G,B,H,L) :- L1 #= (A-G)*(A-G) + (B-H)*(B-H), L #= sqrt(L1) .
































% Terminate recursive calling if deleting element apprears twice
deleteMe(H,[H|T],T):- !.
deleteMe(X,[H|T],[H|R]) :- deleteMe(X,T,R).

noBothRoomPrivate(X,Y) :- countMe(X,Y).
%noSpecialPrivacy(X,Y) :- countMe(X,Y).

path(X,Y,[],N) :- adjacent(X,Y), noBothRoomPrivate(X,Y).
path(X,Y,[Z|I],N) :- N>0, N2 is N-1, adjacent(X,Z), noBothRoomPrivate(X,Z), path(Z,Y,I,N2).


