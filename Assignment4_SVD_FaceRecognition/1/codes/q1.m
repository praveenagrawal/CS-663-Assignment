%% DIP Assign4 - Q.1

% A: Input Matrix
% Areconstructed: reconstructed matrix using mySVD routine
% Snew: singular values using mySVD routine
% SOrig: singular values using MATLAB's SVD function
% U: Left singular vectors using mySVD routine
% UOrig:  Left singular vectors using MATLAB's SVD function
% V: Right singular vectors using mySVD routine
% VOrig: Right singular vectors using MATLAB's SVD function

%% Case 1: m = n
A = rand(5,5);
[Areconstructed,U,Snew,V,UOrig,SOrig,VOrig] = mySVD(A,5,5);
A
Areconstructed
Snew
SOrig
U
UOrig
V
VOrig

%% Case 2: m > n
A = rand(6,4);
[Areconstructed,U,Snew,V,UOrig,SOrig,VOrig] = mySVD(A,6,4);
A
Areconstructed
Snew
SOrig
U
UOrig
V
VOrig

%% Case 13: m < n
A = rand(4,6);
[Areconstructed,U,Snew,V,UOrig,SOrig,VOrig] = mySVD(A,4,6);
A
Areconstructed
Snew
SOrig
U
UOrig
V
VOrig

%% Comments
% Concerns with finding U, V and S directly as eigen values and eigen 
% vectors of AA' and A'A:
%   1. The order of columns of U, V and S is exactly opposite of that of
% original U, V and S (but that is not a major concern as far as the three
% of them have consistent ordering).
%   2. If x is an eigen vector of A, so is -x; and so U and V might have one
% or more columns as negative of the columns of original U and V. Even
% here, if all columns of both U and V are negated it is not a concern.
% 
% Way to deal with these concerns:
%   For instance, A = USV' ==> AV = US ==> U'A = SV'
% We will use one of the two expressions depending on whether m >/</= n.
% S is a diagonal matrix:
%   So, U will simply be columns of AV divided by corresponding diagonal 
% elements of S, as far as they are non-zero.
%   OR
%   V will simply be rows of U'A divided by corresponding diagonal 
% elements of S, as far as they are non-zero.


