function [Q,R] = qrmgs(A)
%QR (thin) factorization using modified Gram-Schmidt algorithm
%for full rank real-valued and complex valued matrices
[m,n] = size(A);
Q = zeros(m,n);
R = zeros(n,n);
d = zeros(1,n);
%factorization with orthogonal (not orthonormal) columns of Q:
for i = 1:n
    Q(:,i) = A(:,i);
    R(i,i) = 1;
    d(i) = Q(:,i)'*Q(:,i);
    for j = i+1:n
        R(i,j) = (Q(:,i)'*A(:,j))/d(i);
        A(:,j) = A(:,j) - R(i,j)*Q(:,i);
    end
end
%column normalization (columns of Q orthonormal)
for i = 1:n
    dd = norm(Q(:,i));
    Q(:,i) = Q(:,i)/dd;
    R(i,i:n) = R(i,i:n)*dd;
end
end