function [ output ] =  myShrinkImageByFactorD( img, d )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [rows, columns] = size(img);
    output = zeros(floor(rows/d), floor(columns/d));
    m=1;n=1;
    for i = 1:d:rows
        for j = 1:d:columns
            output(m,n)=img(i,j);
                n = n+1;
        end
        m = m+1;
        n=1;
    end
    output = uint8(output);
end

