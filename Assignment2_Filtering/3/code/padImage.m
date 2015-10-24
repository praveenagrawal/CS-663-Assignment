function [ B ] = padImage( img, winSize )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   Padding an image by repeating pixels on the boundaries for a window of
%   size winSize*winSize
    [inRows, inColumns] = size(img);
    conc = ((winSize-rem(winSize,2))/2)-abs(rem(winSize,2)-1);   % Number of zeros to be concatenated to matrix; odd as well as even widths are taken care of
    % Padding for corner pixels and pixels at edges
    C1 = repmat(img(1,:), conc, 1);   % repeating 1st row
    C2 = repmat(img(:,1), 1, conc); % repeating 1st coulumn
    C3 = repmat(img(inRows,:), conc, 1); % repeating last row
    C4 = repmat(img(:,inRows),1, conc); % repeating last column
    Cul = img(1,1)*ones(conc, conc); % Upper left corner
    Cur = img(1,inRows)*ones(conc, conc); % Upper right corner
    Cll = img(inRows,1)*ones(conc,conc); % Lower left corner
    Clr = img(inRows, inRows)*ones(conc,conc); % Lower right corner
    B_temp1 = [Cul,C1,Cur];
    B_temp2 = [Cll,C3,Clr];
    B_temp3 = [C2,img,C4];
    B = [B_temp1;B_temp3;B_temp2];

end

