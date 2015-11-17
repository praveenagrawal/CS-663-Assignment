% Database credit (ORL face database): Olivetti Research Laboratory
function recogRate = q2a(k, directoryname)
%% PCA on ORL face database
%directoryname = uigetdir('/home/ankita/Acads/Sem 7/CS663-DIP/Assign/Assign 4', 'Choose the folder which contains your database');

%k = 100;
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
avg = avg';
X = bsxfun(@minus,X,avg); % Subtracting mean from all image vectors
L = X'*X;
[W,D] = eig(L); % W: columns are eigen vectors 
                % D: diagonal elements are eigen values
V = X*W; % (d X N matrix) Eigen vectors of X*X'
V = fliplr(V); % So that first k columns correspond to top k eigen values
V = V(:,1:k); % Eigenvectors corresponding to top k eigen values
              % Eigen space: d X k
% Unit normalizing
temp2 = V.^2;
temp = sum(temp2);
temp = sqrt(temp);
temp1 = repmat(temp,d,1);
V = V./temp1;
              
for i = 1:k
    z = reshape(V(:,i),112,92);
    %figure()
    %imshow(z);
end
Coeff_training = V'*X; % size: k X N || Eigen coefficients of training dataset


% Testing dataset
l = 1;
for i = 1:Nperson
    for j = t+1:10
        s = strcat('s',num2str(i));
        m = strcat(num2str(j),'.pgm');
        path = strcat(directoryname,'/',s,'/',m);
        y = imread(path);
        y = double(y);
        y = reshape(y,d,1);
        y = y-avg;
        Y(:,l) = y;  % every column of X represents a 112 x 92 size image
        l = l+1;
    end
end
Coeff_testing = V'*Y; % size: k X N || Eigen coefficients of testing dataset

% Testing for person_id for each of the image in test data
for i = 1:N
    diff = bsxfun(@minus,Coeff_training,Coeff_testing(:,i));
    diff = diff.^2;
    diff = sum(diff);
    diff = sqrt(diff);
    [minDiff,index] = min(diff);
    Diff(i) = minDiff;
    person_id(i) = ceil(index/5);
end
error = 0;
for i = 1:N
   if ((person_id(i)) ~= ceil(i/5)) 
       error = error+1;
   end
end
recogRate = (1 - (error/N))*100;

end