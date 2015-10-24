%% CS 663 : Digital Image Processing : Assignment 1
% Question 3: Patch Based Filtering
tic;
num = 200;
ColorScale = [ [0:1/(num-1):1]' , [0:1/(num-1):1]' , [0:1/(num-1):1]' ];

img = load('../data/barbara.mat');
img = img.imageOrig;
filter = fspecial('gaussian', [5 5], 0.66);
imgBlurred = imfilter(img, filter);
imgResized = myShrinkImageByFactorD(imgBlurred,2);
imgResizedsize = size(imgResized);
imgCorrupted = imgResized+(0.05*(max(max(imgResized))))*randn(size(imgResized));
sigma = 5.1;
[imgFiltered, mask] = myPatchBasedFiltering(imgCorrupted, sigma);
save '../images/Q3(optimal_sigma)' imgFiltered;
RMSD = sqrt(sum(sum((imgResized-imgFiltered).^2))/(imgResizedsize(1)*imgResizedsize(2)));

figure;
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
title('Input Image', 'FontWeight','bold');
subplot(1,3,1), imshow(uint8(imgResized));
colorbar;
axis on;
title('Corrupted Image', 'FontWeight','bold');
subplot(1,3,2), imshow(uint8(imgCorrupted));
colorbar;
axis on;
title('Output Image', 'FontWeight','bold');
subplot(1,3,3), imshow(uint8(imgFiltered));
colorbar;
axis on;

figure;
imshow(mask);
title('Gaussian Mask', 'FontWeight','bold');
colormap(ColorScale); colormap gray; daspect ([2 2 2]);% axis tight;
colorbar;
axis image;

%Optimal sigma of the filter is
sigma
%Optimal RMSD
RMSD

[imgFiltered, mask] = myPatchBasedFiltering(imgCorrupted, sigma*0.9);
RMSD = sqrt(sum(sum((imgResized-imgFiltered).^2))/(imgResizedsize(1)*imgResizedsize(2)));
%RMSD with 0.9*sigma
RMSD

[imgFiltered, mask] = myPatchBasedFiltering(imgCorrupted, sigma*1.1);
RMSD = sqrt(sum(sum((imgResized-imgFiltered).^2))/(imgResizedsize(1)*imgResizedsize(2)));
%RMSD with 1.1*sigma
RMSD

toc;
