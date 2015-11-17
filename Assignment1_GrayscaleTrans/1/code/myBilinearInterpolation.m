function [ output ] = myBilinearInterpolation( img )
%UNTITLED Summary of this function goes here
    img=double(img);
    [in_rows, in_columns] = size(img);
    output = zeros(3*in_rows-2, 2*in_columns-1);
    [output_rows, output_columns] = size(output);
    for i = 1:1:output_rows
       for j = 1:1:output_columns
           m = floor((i+2)/3);
           n = floor((j+1)/2);
           x1 = 3*m-2;
           x2 = 3*(m+1)-2;
           y1 = 2*n-1;
           y2 = 2*(n+1)-1;
           area = (x2-x1)*(y2-y1);
           if(mod(i,3)==1 && mod(j,2)==1)
               output(i,j) = img(m,n);
           elseif (i==output_rows)
               output(i,j) = ((img(m,n)+img(m,n+1))/2);
           elseif (j==output_columns)
               output(i,j) = ((img(m,n)*(i-x1))+(img(m+1,n)*(x2-i)))/(x2-x1);
           else
               output(i,j) = ((img(m,n)*(x2-i)*(y2-j)+img(m,n+1)*(x2-i)*(j-y1)+img(m+1,n)*(i-x1)*(y2-j)+img(m+1,n+1)*(i-x1)*(j-y1))/area);
           end
       end
    end
    output = uint8(output);
end