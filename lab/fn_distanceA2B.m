function [d] = fn_distanceA2B(A3N,B3N)
A = A3N; [o,Na] = size(A);
B = B3N; [o,Nb] = size(B);
C = sqdistance(A,B);
d = sqrt(C);
%for m = 1:Na
%    for n = 1:Nb
%        d(m,n) = sqrt((A(1,m)-B(1,n))^2 + (A(2,m)-B(2,n))^2 + (A(3,m)-B(3,n))^2);
%    end
%end
