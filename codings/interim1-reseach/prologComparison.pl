
% Comparison

% Main predicate of comparison
compare(X,Y) :- alignTwoLists(X,Y,P,Q), compareInner(P,Q).

		% Prepare two lists in same length by adding zeros infront of the small list, & manage the lists in same length also
		alignTwoLists(X,Y,X,B) :- (longOrEqual(X,Y,R1),addZeros(R1,Z1), append(Z1,Y,B)).
		alignTwoLists(X,Y,A,Y) :-  (longOrEqual(Y,X,R2),  addZerosEqual(R2,Z2), append(Z2,X,A)).

			% Check whether the lists are in same length and if not return the exceeding elements of long list
			longOrEqual(X,[],X).
			longOrEqual([H1|P],[H2|Q],X) :- longOrEqual(P,Q,X).

			% Provide a list with zeros similar to the number of elements given by above method
			addZeros([],[]).
			addZeros([H|X],[0|Y]) :- addZeros(X,Y).

			% Provide an empty list if the exceeding list is empty
			addZerosEqual([X],[0]).
			addZerosEqual([H|X],[0|Y]) :- addZerosEqual(X,Y).

		% Inner predicate of comparison
		compareInner([T1|L1],[T2|L2]) :- large(T1,T2).
		compareInner([H1|T1],[H2|T2]) :- compareInner(T1,T2), H1 is H2.


% alignTwoLists(X,Y,A,B) :- (longOrEqual(X,Y,R1),addZeros(R1,Z1),
% append(Z1,Y,B), append([],X,A)) ; (longOrEqual(Y,X,R2),
% addZeros(R2,Z2), append(Z2,X,A), append([],Y,B)).

large(0,1).
large(0,2).
large(0,3).
large(0,4).
large(0,5).
large(0,6).
large(0,7).
large(0,8).
large(0,9).

large(1,2).
large(1,3).
large(1,4).
large(1,5).
large(1,6).
large(1,7).
large(1,8).
large(1,9).

large(2,3).
large(2,4).
large(2,5).
large(2,6).
large(2,7).
large(2,8).
large(2,9).

large(3,4).
large(3,5).
large(3,6).
large(3,7).
large(3,8).
large(3,9).

large(4,5).
large(4,6).
large(4,7).
large(4,8).
large(4,9).

large(5,6).
large(5,7).
large(5,8).
large(5,9).

large(6,7).
large(6,8).
large(6,9).

large(7,8).
large(7,9).

large(8,9).
