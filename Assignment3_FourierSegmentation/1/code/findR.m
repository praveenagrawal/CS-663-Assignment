function [ R ] = findR( imgInput, percent )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    imgInput = double(imgInput);
    imgFFT = fft2(imgInput);
    imgFFTShifted = fftshift(imgFFT);
    [rows, columns] = size(imgFFT);
    totalSum = sum(sum(abs(imgFFTShifted).^2));
    filterSum = 0;
    for R = 1:1:floor(rows/2)
        filter = fspecial('disk', R);   %Creates a circular mask of radius R
        filter(filter>0)=1;
        imgFFTMask = imgFFTShifted(floor(rows/2)-R:floor(rows/2)+R, floor(columns/2)-R:floor(columns/2)+R);
        filterSum = sum(sum(abs(filter.*imgFFTMask).^2));
        if(filterSum/totalSum > percent/100)
            break;
        end
    end
end

