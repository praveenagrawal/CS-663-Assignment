%% MyMainScript
%% CS 663 : Digital Image Processing : Assignment 3
% Question 3:  Mean-Shift Segmentation

tic;
%% Your code here
clear;
clc;

num = 200;
ColorScale = [ [0:1/(num-1):1]' , [0:1/(num-1):1]' , [0:1/(num-1):1]' ];

% Image
imgIn = imread('../data/baboonColor.png');
hs = 32  % Spatial kernel bandwidth
hrgb = 32 % RGB-color kernel bandwidth
N = 200 % Number of nearest neighbours
Niter = 40 % Number of iterations
[imgInBlur imgUpdated] = myMeanShiftSegmentation(imgIn, hs, hrgb, N, Niter);

figure();
imshow([imgInBlur imgUpdated]);
title('Left: Original Image || Right: Mean-shift Segmented Image');

r1 = imgInBlur(:,:,1);
g1 = imgInBlur(:,:,2);
b1 = imgInBlur(:,:,3);

r2 = imgUpdated(:,:,1);
g2 = imgUpdated(:,:,2);
b2 = imgUpdated(:,:,3);

figure();
subplot(1,2,1)
scatter3(r1(:), g1(:), b1(:)); title('Scatter plot of original image');
subplot(1,2,2)
scatter3(r2(:), g2(:), b2(:)); title('Scatter plot of segmented image');


imgOut = [imgInBlur imgUpdated];
save '../images/imgSegmented' imgOut;

toc;
