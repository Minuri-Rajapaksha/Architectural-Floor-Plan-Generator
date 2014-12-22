


traverse( [] ).
traverse( [H|T] ) :-
	traverse( H ),
	traverse( T ).

noop( X ).
noop_nobind( X, _X ).
noop_bind( X, X ).
