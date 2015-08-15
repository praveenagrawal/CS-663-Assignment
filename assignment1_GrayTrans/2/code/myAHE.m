function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % This function implemets Adaptive Histogram Equalization on the given
    % input Image and for specified window size
    A = imread('../data/TEM.png');
    % A = imresize(A, 0.5);  % In order to decrease run-time
    tstart = tic;
    width = 105; % width of window
    [X_lengthA, Y_lengthA] = size(A); % Dimensions of image matrix
    % N_total = X_lengthA*Y_lengthA;  % Total number of pixels
    conc = ((width-rem(width,2))/2)-abs(rem(width,2)-1);   % Number of zeros to be concatenated to matrix; odd as well as even widths are taken care of
    C1 = zeros(conc, Y_lengthA);    % Zero array to be used for concatenation
    C2 = zeros(X_lengthA+(2*conc), conc);  % Zero array to be used for concatenation
    B_temp1 = [C1; A; C1];         % Concatenating rows
    B = [C2, B_temp1, C2];   % Image is concatenated with appropriate number of zeros in order to take care of corner pixels
    i = 1; j = 1;      % i and j denote the corner pixel co-ordinate of window
    [X_lengthB, Y_lengthB] = size(B);

    % Pre-allocating
    Win_B = zeros(width, width);
    A_mod = zeros(X_lengthB, Y_lengthB);

    for i = 1:(X_lengthB-width+1)
        for j = 1:(Y_lengthB-width+1)
            Win_B = B(i:(i+width-1), j:(j+width-1));   % Image B after windowing

            % Histogram Equalization
            [count bin] = imhist(Win_B);
            count = count/(width*width);   % Normalizing
            A_mod(i+conc, j+conc) = sum(count(1:(Win_B(conc+1, conc+1)+1)));

        end
        % i % debugging purpose
    end

    tstop = toc(tstart);

    A_mod = A_mod((conc+1:X_lengthB-conc),(conc+1:Y_lengthB-conc));  %removing padded zeros
    figure(1);
    title('Original Image');
    imshow(A);
    figure(2);
    title('On application of Adaptive Histogram Equalization');
    imshow(A_mod,[]);



end

