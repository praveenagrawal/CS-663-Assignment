function [ output ] = myHE( Img )
%UNTITLED Summary of this function goes here
    Img = double(Img);
    [X_length, Y_length] = size(Img); % Dimensions of image matrix
    output = zeros(X_length, Y_length);
    N_total = X_length*Y_length; % Total number of pixels

    [count, bin] = imhist(Img); % bin: Ranges from 0 to 256
                              % count: Denotes number of pixels having value equal
                              % to the corresponding bin value
    count = count/N_total;    % Normalizing

    % Equalizing
    for i = 1:X_length
        for j = 1:Y_length
            output(i,j) = sum(count(1:Img(i,j)+1));
        end
    end
end

