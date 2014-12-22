road1(A,B) :- road(A,C), member(C,B).
road1(A,B) :- road(C,A), member(C,B).

interconnected([],L) .
interconnected([H|T],A) :- road1(H,A), interconnected(T,A).

road(f,l).
road(f,g).
road(e,f).
road(a,e).
road(b,a).
road(c,d).
road(m,d).
road(d,n).


