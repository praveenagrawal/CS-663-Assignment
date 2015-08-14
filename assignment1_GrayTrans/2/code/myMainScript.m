%% CS 663 : Digital Image Processing : Assignment 1
%% Question 2(a):  Linear Contrast Stretching
tic;
myNumOfColors = 255;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
img = imread('../data/barbara.png');
StretchedImg = myLinearContrastStretching(img);
save '../images/Q2(a)_Barbara' StretchedImg;
% INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
daspect ([1 1 1]);
axis tight;
colormap(myColorScale);
colormap gray;
colorbar;
% OUTPUT IMAGE
figure;
imshow(StretchedImg, 'Colormap',myColorScale);
title('Output Image', 'FontWeight', 'bold');
colorbar;

img = imread('../data/TEM.png');
StretchedImg = myLinearContrastStretching(img);
save '../images/Q2(a)_TEM' StretchedImg;
% INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
colorbar;
% OUTPUT IMAGE
figure;
imshow(StretchedImg, 'Colormap',myColorScale);
title('Output Image', 'FontWeight', 'bold');
colorbar;

img = imread('../data/canyon.png');
img_red = img(:,:,1);
img_green = img(:,:,2);
img_blue = img(:,:,3);
StretchedImg_red = myLinearContrastStretching(img_red);
StretchedImg_green = myLinearContrastStretching(img_green);
EnhancedImg_blue = myLinearContrastStretching(img_blue);
StretchedImg = cat(3, StretchedImg_red, StretchedImg_green, EnhancedImg_blue);
save '../images/Q2(a)_canyon' StretchedImg;
% INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
colorbar;
% OUTPUT IMAGE
figure;
imshow(StretchedImg, 'Colormap',myColorScale);
title('Output Image', 'FontWeight', 'bold');
colorbar;
toc;
%% Question 2(b): Histogram Equalization (HE).
tic;
img = imread('../data/barbara.png');
EnhancedImg = myHE(img);
save '../images/Q2(b)_Barbara' EnhancedImg;
% INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
daspect ([1 1 1]);
axis tight;
colormap(myColorScale);
colormap gray;
colorbar;
% OUTPUT IMAGE
figure;
imshow(EnhancedImg, 'Colormap',myColorScale);
title('Output Image', 'FontWeight', 'bold');
colorbar;

img = imread('../data/TEM.png');
EnhancedImg = myHE(img);
save '../images/Q2(b)_TEM' EnhancedImg;
% INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
colorbar;
% OUTPUT IMAGE
figure;
imshow(EnhancedImg, 'Colormap',myColorScale);
title('Output Image', 'FontWeight', 'bold');
colorbar;

img = imread('../data/canyon.png');
img_red = img(:,:,1);
img_green = img(:,:,2);
img_blue = img(:,:,3);
EnhancedImg_red = myHE(img_red);
EnhancedImg_green = myHE(img_green);
EnhancedImg_blue = myHE(img_blue);
EnhancedImg = cat(3, EnhancedImg_red, EnhancedImg_green, EnhancedImg_blue);
save '../images/Q2(b)_canyon' EnhancedImg;
% INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
colorbar;
% OUTPUT IMAGE
figure;
imshow(EnhancedImg, 'Colormap',myColorScale);
title('Output Image', 'FontWeight', 'bold');
colorbar;
toc;
%% Question 1(c):  Image Enlargement using Nearest-Neighbor Interpolation
tic;
img = imread('../data/barbaraSmall.png');
output = myNearestNeighborInterpolation(img);
save '../images/Q1(c)' output;
%INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
daspect ([1 1 1]);
axis tight;
%colorbar;
% OUTPUT IMAGE
figure;
imshow(output, 'Colormap',myColorScale);
title('Output Image', 'FontWeight','bold');
daspect ([1 1 1]);
axis tight;
%colorbar;
toc;
