

% check that intersection of two lines - Bresenham's line drawing
% algorithm - but this is not much good enough since sime time we have
% calculate millions of pixels and it is hard to identify decimal
% intersecting points


% Add elements to a list
addToList(H,[H|T],T).
addToList(X,[H|T],[H|R]) :- addToList(X,T,R).


% Validate two lines have a common point
checkIntersection([P1,P2], [P3,P4]) :- lineDraw([P1,P2], L1), lineDraw([P3,P4], L2), findNth(L1,X), findNth(L2,X).


% Generate the points need to draw a line
	lineDraw([[X1,Y1],[X2,Y2]],R) :- X1<X2, getPo([[X1,Y1],[X2,Y2]], Po), getLine([[X1,Y1],[X2,Y2]],R , Po, DeltaY, DeltaX), DeltaY is Y2-Y1, DeltaX is X2-X1.

	% calculate the Po value
	getPo([[X1,Y1],[X2,Y2]], Po) :- Po is 2*(Y2-Y1) - (X2-X1).

	% Inner function to Generate the points need to draw a line
	getLine([[X2,Y2],[X2,Y2]],R, Po,  DeltaY, DeltaX).
	getLine([[X1,Y1],[X2,Y2]],[H|T], Po,  DeltaY, DeltaX) :- ( Po<0, addToList(N,R,[H|T]), N is (X1+1,Y1), Pk1 is Po + (2*DeltaY), getLine(N,[X2,Y2],R ,Pk1 ,DeltaY, DeltaX) ) ; ( Po>0,  addToList(N,R,[H|T]), N is (X1+1,Y1+1), Pk1 is Po + (2*DeltaY-2*DeltaX), getLine(N,[X2,Y2],R, Pk1, DeltaY, DeltaX) ).


% To find overlapping of two polygons

findMiddlePoint([[X3,Y3],[X4,Y4]],MX,MY) :- MX is (X3+X4)/2 , MY is (Y3+Y4)/2.

overlapping([[[X1,Y1],[X2,Y2]]|T1], [[[X3,Y3],[X4,Y4]]|T2]) :- findMiddlePoint([[X3,Y3],[X4,Y4]],MX,MY), lineNotIntersect([[X1,Y1],[MX,MY]],[[X3,Y3],[X4,Y4]]),

