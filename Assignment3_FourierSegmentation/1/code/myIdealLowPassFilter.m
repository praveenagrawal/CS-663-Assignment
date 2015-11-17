function [ imgFiltered ] = myIdealLowPassFilter( imgInput, R )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    imgInput = double(imgInput);
    imgFFT = fft2(imgInput);
    imgFFTShifted = fftshift(imgFFT);
    [rows, columns] = size(imgFFT);
    mask = fspecial('disk', R);   %Creates a circular mask of radius R
    mask(mask>0)=1;
    filter = zeros(size(imgFFT));
    filter(rows/2-R:rows/2+R, columns/2-R:columns/2+R) = mask;
    imgFFTFiltered = fftshift(filter.*imgFFTShifted);
    imgFiltered = ifft2(imgFFTFiltered);
    imgFiltered = abs(imgFiltered);    
end

