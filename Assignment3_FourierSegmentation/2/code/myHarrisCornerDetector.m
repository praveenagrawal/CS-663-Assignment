function [ Ix, Iy, lambda1, lambda2, cornerness ] =  myHarrisCornerDetector( imgInput, sigmaBlur, sigmaWeight, k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    h = waitbar(0,'Detecting Corners. Please wait...');
    filter = fspecial('gaussian', [5 5], sigmaBlur);
    imgBlur = imfilter(imgInput, filter);
    [Ix, Iy] = gradient(imgBlur);
    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;
    IxIy = Ix.*Iy;
    [rows, columns] = size(imgInput); 
    lambda1 = zeros(size(imgInput));
    lambda2 = zeros(size(imgInput));
    cornerness = zeros(size(imgInput));
    windowSize = 9;
    padIx2 = zeros(rows+2*windowSize, columns+2*windowSize);
    padIy2 = zeros(rows+2*windowSize, columns+2*windowSize);
    padIxIy = zeros(rows+2*windowSize, columns+2*windowSize);
    padIx2(windowSize+1:windowSize+rows, windowSize+1:windowSize+columns) = Ix2;
    padIy2(windowSize+1:windowSize+rows, windowSize+1:windowSize+columns) = Iy2;
    padIxIy(windowSize+1:windowSize+rows, windowSize+1:windowSize+columns) = IxIy;
    weight = fspecial('gaussian', [windowSize windowSize], sigmaWeight);
    for i = 1:1:rows
        for j = 1:1:columns
            H = zeros(2,2);
            Sx2 = sum(sum(weight.*padIx2(i+floor(windowSize/2):windowSize+i+floor(windowSize/2)-1, j+floor(windowSize/2):windowSize+j+floor(windowSize/2)-1)));
            Sy2 = sum(sum(weight.*padIy2(i+floor(windowSize/2):windowSize+i+floor(windowSize/2)-1, j+floor(windowSize/2):windowSize+j+floor(windowSize/2)-1)));
            SxSy = sum(sum(weight.*padIxIy(i+floor(windowSize/2):windowSize+i+floor(windowSize/2)-1, j+floor(windowSize/2):windowSize+j+floor(windowSize/2)-1)));
            H = [Sx2, SxSy; SxSy, Sy2];
            eigenvalues = eig(H);
            lambda1(i,j) = eigenvalues(1);
            lambda2(i,j) = eigenvalues(2);
            cornerness(i,j) = det(H) - k*trace(H);
        end
        waitbar(i/rows);
    end
    close(h);
end

