%% CS 663 : Digital Image Processing : Assignment 1
%% Question 1(a): Image Shrinking
tic;
myNumOfColors = 256;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
img = imread('../data/circles_concentric.png');
d=2;
shrinked2 = myShrinkImageByFactorD(img, d);
save '../images/Q1(a)_d=2' shrinked2;
d=3;
shrinked3 = myShrinkImageByFactorD(img, d);
save '../images/Q1(a)_d=3' shrinked3;
%INPUT IMAGE
figure;
imshow(img, 'Colormap',myColorScale);
title('Input Image', 'FontWeight','bold');
daspect ([1 1 1]);
axis tight;
%colorbar;
% OUTPUT FOR d=2
figure;
imshow(shrinked2, 'Colormap',myColorScale);
title('Output for d=2', 'FontWeight', 'bold');
daspect ([1 1 1]);
axis tight;
%colorbar;
% OUTPUT FOR d=3
figure;
imshow(shrinked3, 'Colormap',myColorScale);
title('Output for d=3', 'FontWeight','bold');
daspect ([1 1 1]);
axis tight;
%colorbar;
toc;
%% Question 1(b): Image Enlargement using Bilinear Interpolation.
tic;
img = imread('../data/barbaraSmall.png');
output = myBilinearInterpolation(img);
save '../images/Q1(b)' output;
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
