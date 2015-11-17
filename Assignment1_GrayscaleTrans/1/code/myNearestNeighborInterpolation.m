function [ output ] = myNearestNeighborInterpolation( img )
%UNTITLED Summary of this function goes here
    img=double(img);
    [in_rows, in_columns] = size(img);
    output = zeros(3*in_rows-2, 2*in_columns-1);
    [output_rows, output_columns] = size(output);
    for i = 1:1:output_rows
       for j = 1:1:output_columns
           m = (i+2)/3;
           n = (j+1)/2;
           output(i,j) = img(round(m), round(n));
       end
    end
    output = uint8(output);
end
