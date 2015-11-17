% Database credit (ORL face database): Olivetti Research Laboratory
function q4(directoryname, threshold)

%% PCA on ORL face database
%directoryname = uigetdir('/home/ankita/Acads/Sem 7/CS663-DIP/Assign/Assign 4', 'Choose the folder which contains your database');

k = 175;
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
              
Coeff_training = V'*X; % size: k X N || Eigen coefficients of training dataset


falsenegative = 0;
falsepositive = 0;
%threshold = 2900;
abc = 1;

%% Testing dataset

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
        norm_y(l) = sqrt(sum((y.^2)));
        Y(:,l) = y;  % every column of X represents a 112 x 92 size image
        l = l+1;
    end
end
Coeff_testing = V'*Y; % size: k X N || Eigen coefficients of testing dataset

% Testing for person_id for each of the image in test data
for i = 1:N
    diff = bsxfun(@minus,Coeff_training,Coeff_testing(:,i));
    diff = diff.^2;
    %diff = max(diff);
    diff = sum(diff);
    diff = sqrt(diff);
    avg1(i) = mean(diff);
    [minDiff,index] = min(diff);
    Diff(i) = minDiff;
    if (Diff(i) >= threshold) 
        check(abc) = 0;
        falsenegative = falsenegative+1;
    else
        check(abc) = 1;
    end
    abc = abc+1;
end
falsenegative = falsenegative/N


% Testing dataset
Nperson = 5;
t = 10;
N = 50;
l = 1;
Y1 = zeros(d,N);

for i = 36:40
    for j = 1:t
        s = strcat('s',num2str(i));
        m = strcat(num2str(j),'.pgm');
        path = strcat(directoryname,'/',s,'/',m);
        y = imread(path);
        y = double(y);
        y = reshape(y,d,1);
        y = y-avg;
        norm_y(l) = sqrt(sum((y.^2)));
        Y1(:,l) = y;  % every column of X represents a 112 x 92 size image
        l = l+1;
    end
end
Coeff_testing1 = V'*Y1; % size: k X N || Eigen coefficients of testing dataset

% Testing for person_id for each of the image in test data
for i = 1:N
    diff = bsxfun(@minus,Coeff_training,Coeff_testing1(:,i)); % k X N
    diff = diff.^2;
    diff = sum(diff);
    diff = sqrt(diff); % 1 X N
    avg2(i) = mean(diff);
    [minDiff,index] = min(diff);
    Diff1(i) = minDiff;
    if (Diff1(i) >= threshold) 
        check(abc) = 0;
    else
        check(abc) = 1;
        falsepositive = falsepositive+1;
    end
    abc = abc+1;
end

falsepositive = falsepositive/N

figure()
plot(Diff); title('Error for images in trained data');
savefig( '../images/ActualData');

figure()
plot(Diff1); title('Error for images NOT in trained data');
savefig( '../images/ErroneousData');

figure()
plot(Diff(1:50));
hold on;
plot(Diff1,'r');
legend('Data in trained dataset', 'Data NOT in trained dataset');

savefig( '../images/ErrorComparison');

