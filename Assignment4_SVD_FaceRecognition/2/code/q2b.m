% YALE database
function recogRate = q2b(k, directoryname)

%directoryname = uigetdir('/home/ankita/Acads/Sem 7/CS663-DIP/Assign/Assign 4', 'Choose the folder which contains your database');

Nperson = 38;
t = 30; % 30 images as training data
d = 192*168;
N = 38*30;
l = 1;
%k = 1000;
X = zeros(d,N);
Y = zeros(d,N);

for i = 1:(Nperson+1)
    if i ~= 14
        i
        if i<10 s = strcat('yaleB0',num2str(i));
            else s = strcat('yaleB',num2str(i));
        end
            folder = strcat(directoryname,'/',s);
            files = dir(fullfile(folder, '*.pgm'));
        for j = 1:t
            m = files(j).name;
            path = strcat(folder,'/',m);
            x = imread(path);
            x = double(x);
            x = reshape(x,d,1);
            X(:,l) = x;  % every column of X represents a 112 x 92 size image
            l = l+1;
        end
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
V1 = V(:,4:k+3); % Eigenvectors corresponding to top k eigen values
              % Eigen space: d X k
% Unit normalizing
temp2 = V1.^2;
temp = sum(temp2);
temp = sqrt(temp);
temp1 = repmat(temp,d,1);
V1 = V1./temp1;
              
for i = 1:k
    z = reshape(V1(:,i),192,168);
    %figure()
    %imshow(uint8(z));
end
Coeff_training = V1'*X; % size: k X N || Eigen coefficients of training dataset


% Testing dataset
l = 1;

for i = 1:(Nperson+1)
    i
    if i ~= 14
        if i<10 s = strcat('yaleB0',num2str(i));
            else s = strcat('yaleB',num2str(i));
        end
            folder = strcat(directoryname,'/',s);
            files = dir(fullfile(folder, '*.pgm'));
        for j = t+1:60
            m = files(j).name;
            path = strcat(folder,'/',m);
            y = imread(path);
            y = double(y);
            y = reshape(y,d,1);
            Y(:,l) = y;  % every column of X represents a 112 x 92 size image
            l = l+1;
        end
    end
end
Coeff_testing = V1'*Y; % size: k X N || Eigen coefficients of testing dataset

% Testing for person_id for each of the image in test data
for i = 1:N
    diff = bsxfun(@minus,Coeff_training,Coeff_testing(:,i));
    diff = diff.^2;
    diff = sum(diff);
    diff = sqrt(diff);
    [minDiff,index] = min(diff);
    person_id(i) = ceil(index/30);
end
error = 0;
for i = 1:N
    m = ceil(i/30);
   if ((person_id(i)) ~= m) 
       error = error+1;
   end
end
recogRate = (1 - (error/N))*100;