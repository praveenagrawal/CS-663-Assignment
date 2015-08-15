function [A_out] = myHE(A)
    [X_length, Y_length] = size(A); % Dimensions of image matrix
    N_total = X_length*Y_length; % Total number of pixels

    [count, bin] = imhist(A); % bin: Ranges from 0 to 256
                              % count: Denotes number of pixels having value equal
                              % to the corresponding bin value
    count = count/N_total;    % Normalizing
    A_out = zeros(X_length, Y_length);

    % Equalizing
    for i = 1:X_length
        for j = 1:Y_length
            A_out(i,j) = sum(count(1:A(i,j)+1));
        end
    end
end