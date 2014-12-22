:- use_module(library(clpfd)).


n_factorial(0, 1).
n_factorial(N, F) :-  N #> 0, N1 #= N - 1, F #= N * F1,	n_factorial(N1,F1).


% multi(A,B,R) :- {R = A*B,maximize( A)}.

%multiplication(A,B,R) :- R #= A*B, label([A]).
multiplication(A,B,R) :- R #= A*B.
xxx([A,B,C]):- between(1,4,A),label(A),between(1,4,B),label(B),between(1,4,C),label(C),all_different([A,B,C]).
