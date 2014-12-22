p( a ).
p( f( a ) ).
p( (a, b) ).
p( X ).

p( a, a ).
p( a, b ).

q( f( X, X ) ).
q( f( X, Y ) ).

r( f( X, X ), X ).
r( f( X, X ), Y ).

s( X, f( X, X ) ).
s( Y, f( X, X ) ).

tuple( (a,b,c,d,e) ).

t :-
	throw( 'this is an error message' ).




display( X ) :-
	write( X ).
