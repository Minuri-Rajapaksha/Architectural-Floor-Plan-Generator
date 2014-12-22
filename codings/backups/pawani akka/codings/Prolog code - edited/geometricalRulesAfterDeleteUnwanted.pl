% To write the output of the polog predicate to a text file
lengthL([1,2,3,4,5],N), open('out.txt', write, Out), write(Out,N), close(Out).



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
combineTwoPolygons([H1|T1],[H2|T2],BL) :- addToList(H1,BL,T1), addToList(H2,BL,T2),combineTwoPolygons(T1,T2).

	% To add element to a list
	addToList(H,[H|T],T).
	addToList(X,[H|T],[H|R]) :- addToList(X,T,R).
