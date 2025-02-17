%% MyMainScript
%% CS 663 : Digital Image Processing : Assignment 2
%% Question 2: Bilateral Filtering

tic;
%% Your code here
num = 200;
ColorScale = [ [0:1/(num-1):1]' , [0:1/(num-1):1]' , [0:1/(num-1):1]' ];

% Image 1
A = load('../data/barbara.mat');
img = A.imageOrig;

% Optimum parameters
[imgIn, imgN, imgOut, mask] = myBilateralFiltering(img, 105, 1.6, 9.5);

figure(1)
set(gcf,'numbertitle','off','name','Optimum Parameters: sSD, iSD') 
subplot(2,2,1)
imshow(imgIn)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Original Image');
subplot(2,2,2)
imshow(imgN)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Corrupted Image');
subplot(2,2,3)
imshow(imgOut)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Filtered image');
subplot(2,2,4)
imshow(mask)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Gaussian Mask');

% 0.9*sSD, iSD
[imgIn1, imgN1, imgOut1, mask1] = myBilateralFiltering(img, 105, 1.44, 9.5);

figure(2)
set(gcf,'numbertitle','off','name','Parameters: 0.9*sSD, iSD') 
subplot(2,2,1)
imshow(imgIn1)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Original Image');
subplot(2,2,2)
imshow(imgN1)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Corrupted Image');
subplot(2,2,3)
imshow(imgOut1)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Filtered image');
subplot(2,2,4)
imshow(mask1)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Gaussian Mask');


% 1.1*sSD, iSD
[imgIn2, imgN2, imgOut2, mask2] = myBilateralFiltering(img, 105, 1.76, 9.5);

figure(3)
set(gcf,'numbertitle','off','name','Parameters: 1.1*sSD, iSD') 
subplot(2,2,1)
imshow(imgIn2)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Original Image');
subplot(2,2,2)
imshow(imgN2)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Corrupted Image');
subplot(2,2,3)
imshow(imgOut2)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Filtered image');
subplot(2,2,4)
imshow(mask2)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Gaussian Mask');


% sSD, 0.9*iSD
[imgIn3, imgN3, imgOut3, mask3] = myBilateralFiltering(img, 105, 1.6, 8.55);

figure(4)
set(gcf,'numbertitle','off','name','Parameters: sSD, 0.9*iSD') 
subplot(2,2,1)
imshow(imgIn3)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Original Image');
subplot(2,2,2)
imshow(imgN3)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Corrupted Image');
subplot(2,2,3)
imshow(imgOut3)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Filtered image');
subplot(2,2,4)
imshow(mask3)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Gaussian Mask');


% sSD, 1.1*iSD
[imgIn4, imgN4, imgOut4, mask4] = myBilateralFiltering(img, 105, 1.6, 10.45);

figure(5)
set(gcf,'numbertitle','off','name','Parameters: sSD, 1.1*iSD') 
subplot(2,2,1)
imshow(imgIn4)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Original Image');
subplot(2,2,2)
imshow(imgN4)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Corrupted Image');
subplot(2,2,3)
imshow(imgOut4)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Filtered image');
subplot(2,2,4)
imshow(mask4)
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;
title('Gaussian Mask');

% Saving filtered output images
save '../images/Q2_Optimum' imgOut;
save '../images/Q2_Case1' imgOut1;
save '../images/Q2_Case2' imgOut2;
save '../images/Q2_Case3' imgOut3;
save '../images/Q2_Case4' imgOut4;

toc;
