% Database credit (ORL face database): Olivetti Research Laboratory
function [V1,X,avg] = q3(k, directoryname)
%% PCA on ORL face database
%directoryname = uigetdir('/home/ankita/Acads/Sem 7/CS663-DIP/Assign/Assign 4', 'Choose the folder which contains your database');

Nperson = 35;
t = 5;
l = 1;
N = 35*5;
d = 92*112;
X = zeros(d,N);
Y = zeros(d,N);

% Creating training dataset matrix
for i = 1:Nperson
    for j = 1:t
        s = strcat('s',num2str(i));
        m = strcat(num2str(j),'.pgm');
        path = strcat(directoryname,'/',s,'/',m);
        x = imread(path);
        x = double(x);
        x = reshape(x,d,1);
        X(:,l) = x;  % every column of X represents a 112 x 92 size image
        l = l+1;
    end
end

avg = sum(X')/N;  % Mean of all the image vectors
avg = avg'; % d X 1
X = bsxfun(@minus,X,avg); % Subtracting mean from all image vectors
L = X'*X;
[W,D] = eig(L); % W: columns are eigen vectors 
                % D: diagonal elements are eigen values
V = X*W; % (d X N matrix) Eigen vectors of X*X'
V = fliplr(V); % So that first k columns correspond to top k eigen values
V1 = V(:,1:k); % Eigenvectors corresponding to top k eigen values
              % Eigen space: d X k
% Unit normalizing
temp2 = V1.^2;
temp = sum(temp2);
temp = sqrt(temp);
temp1 = repmat(temp,d,1);
V1 = V1./temp1;   % Eigen space