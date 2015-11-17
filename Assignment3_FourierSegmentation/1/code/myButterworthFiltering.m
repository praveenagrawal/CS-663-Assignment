function [ imgFiltered, filter ] =  myButterworthFiltering( imgInput, n, D0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    imgInput = double(imgInput);
    imgFFT = fft2(imgInput);
    imgFFTShifted = fftshift(imgFFT);    
    filter = zeros(size(imgFFTShifted));
    [rows, columns] = size(imgInput);
    for i = 1:1:rows
        for j = 1:1:columns
            D = ((i-rows/2).^2+(j-columns/2).^2).^0.5;
            filter(i,j) = 1/(1+(D/D0).^(2*n));
        end
    end
    fftFiltered = fftshift(filter.*imgFFTShifted);
    imgFiltered = ifft2(fftFiltered);
end

