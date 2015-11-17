function [Areconstructed,U,Snew,V,UOrig,SOrig,VOrig] = mySVD(A,m,n)
% A is m x n matrix
% U is m x m matrix
% V is n x n matrix
% S is m x n matrix


AU = A*A';   % m x m
AV = A'*A;   % n x n
[V,S] = eig(AV);  % Here S will be n x n
V = fliplr(V);
[U,S] = eig(AU);  % Here S will be m x m
U = fliplr(U);
if m<=n
    U = zeros(m,m); % ie we will be estimating U using derived V
end
if m>n
    V = zeros(n,n); % ie we will be estimating V using derived U
end
S = sqrt(S);
S = fliplr(S);    % Ordering from highest eigen value to lowest
S = S';
S = fliplr(S);
S = abs(S);

if m>n
    array = zeros(1,n);
    k = 1;
    for i = 1:m
        if ((S(i,i) > 0.00001) || (S(i,i) < -0.00001))    % notes all the 
            array(k) = i; % indices of columns where eigen values are 
            k = k+1;      % non-zero
        end
    end
    for i = 1:n
        Snew(:,i) = S(:,array(i));
    end
    temp = U'*A;
    for k = 1:n
        V(k,:) = temp(k,:)/Snew(k,k);
    end
    V = V';
end

if m<n
    % Finding S
    for j = (m+1):n
        S(:,j) = zeros(m,1);
    end
    Snew = S;
    % Finding U
    temp = A*V;
    for k = 1:m
        U(:,k) = temp(:,k)/Snew(k,k);
    end
        
end

if m==n
    % Finding S
    Snew = S;
    % Finding U
    temp = A*V;
    for k = 1:m
        U(:,k) = temp(:,k)/Snew(k,k);
    end
end

Areconstructed = U*Snew*V';
% For comparision purpose    
[UOrig, SOrig, VOrig] = svd(A);

end