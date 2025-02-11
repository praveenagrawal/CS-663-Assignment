function [img, imgN, imgOut, mask] = myBilateralFiltering(img, winSize, sSD, iSD)

% A = load('../data/barbara.mat');
% img = A.imageOrig;
[Xlength Ylength] = size(img);
minPixel = min(min(img)); % Value of minimum intensity pixel   
maxPixel = max(max(img)); % Value of maximum intensity pixel
noise = (0.05*(maxPixel-minPixel)).*randn(Xlength, Ylength);   % Gaussian noise
imgN = img + noise;  % Corrupted image
% winSize = 105;
% sSD = 1.6; % Standard deviation for spatial kernel
% iSD = 9.5; % Standard deviation for intensity kernel
x = 0:75;
y = 0:round(sqrt(2)*(winSize-1)/2);  % This is the maximum value spatial difference can reach
sKernel(1:length(y)) = (1/sqrt(2*pi*sSD*sSD))*exp(-(y.*y)/(2*sSD*sSD));
iKernel(1:76) = (1/sqrt(2*pi*iSD*iSD))*exp(-(x.*x)/(2*iSD*iSD)); 
iKernel(77:256) = 0;  % Intensity difference beyond 76 is assigned zero weight

% Weights corresponding to spatial kernel will remain constant
sWt = zeros(winSize, winSize);
mid = (winSize+1)/2;
for i = 1:winSize
    for j = 1:winSize
        sDist = round(sqrt(((mid-i)^2)+((mid-j)^2)));
        sWt(i,j) = sKernel(sDist+1);
    end
end

imgOut = zeros(Xlength, Ylength);
for i = 1:Xlength
    for j = 1:Ylength
        wylen = min(mid, min(j, Ylength-j+1))+mid-1; % no. of columns of window
        wxlen = min(mid, min(i, Xlength-i+1))+mid-1; % no. of rows of window
        ystart = max(1, j-(mid-1)); yend = ystart+wylen-1; % co-ordinates where window on the image will start and end
        xstart = max(1, i-(mid-1)); xend = xstart+wxlen-1;
        wystart = max(1, mid+1-j); wyend = wystart+wylen-1; % co-ordinates where the actual window will start and end
        wxstart = max(1, mid+1-i); wxend = wxstart+wxlen-1;
        iDiff = abs(round(imgN(xstart:xend, ystart:yend)-imgN(i, j)))+1; %intensity difference matrix
        iWt = iKernel(iDiff);
        imgNu = sum(sum(imgN(xstart:xend, ystart:yend).*sWt(wxstart:wxend, wystart:wyend).*iWt));  % Numerator
        imgDi = sum(sum(sWt(wxstart:wxend, wystart:wyend).*iWt));
        imgOut(i, j) = imgNu/imgDi;
        
    end
end

% Root-Mean-Squared-Difference
add = 0;
for i = 1:Xlength
    for j = 1:Ylength
        add = add+((img(i,j)-imgOut(i,j))^2);
    end
end
rmsd = sqrt(add/(Xlength*Ylength))

% Display Images
img = uint8(img);
imgN = uint8(imgN);
imgOut = uint8(imgOut);
mask = mat2gray(sWt);

end