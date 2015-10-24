function img_enhanced = myUnsharpMasking(img, winSize, s, sigma)
% A = load('../data/superMoonCrop.mat');
% A = load('../data/lionCrop.mat');
% img = A.imageOrig;

filter = fspecial('gaussian', winSize, sigma);
img_filter = imfilter(img, filter);      % Blurring
img_inverted = 1 - img_filter;           % Inverted Blur Image
img_edge = s*img_inverted;               % Scaling of inverted, blurred image
img_enhanced = img + img_edge;           % Enhanced output
img_enhanced = mat2gray(img_enhanced);
img = mat2gray(img);
