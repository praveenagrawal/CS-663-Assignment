%% MyMainScript
%% CS 663 : Digital Image Processing : Assignment 2
%% Question 1:  Unsharp Masking

tic;
%% Your code here
num = 200;
ColorScale = [ [0:1/(num-1):1]' , [0:1/(num-1):1]' , [0:1/(num-1):1]' ];

% Image 1
A1 = load('../data/superMoonCrop.mat');
img1 = A1.imageOrig;
img1Out = myUnsharpMasking(img1, 25, 0.25, 10);
figure(1);
imshow([img1, img1Out]);
colormap(ColorScale); colormap gray; daspect ([1 1 1]); % axis tight
colorbar;
axis image;
title('Moon: Original Image (on left) and Edge-Sharpened image (on right)');

% Saving image file
save '../images/Q1_Moon' img1Out;

% Image 2
A2 = load('../data/lionCrop.mat');
img2 = A2.imageOrig;
img2Out = myUnsharpMasking(img2, 25, 0.3, 10);
figure(2);
imshow([img2, img2Out]);
colormap(ColorScale); colormap gray; daspect ([1 1 1]); % axis tight
colorbar;
axis image;
title('Lion: Original Image (on left) and Edge-Sharpened image (on right)');

% Saving image file
save '../images/Q1_Lion' img2Out;

toc;
