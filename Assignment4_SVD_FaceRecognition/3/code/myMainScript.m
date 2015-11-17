%% MyMainScript

% Run-time ~ 16 seconds
tic;
%% Your code here
clear;
clc;

%% Reconstruction of faces

directoryname = uigetdir('/home', 'Choose the folder which contains your database');
testImg = imread(strcat(directoryname,'/s1/1.pgm'));
testImg1 = reshape(testImg,92*112,1);
k = [2, 10, 20, 50, 75, 100, 125, 150, 175];
figure(1);
set(gcf,'numbertitle','off','name','Reconstrunction of faces using different values of k') 

for i = 1:length(k)
    [V1,X,avg] = q3(k(i),directoryname);
    Coeff_training = V1'*X; % k X N
    temp = V1*Coeff_training;
    outImg = avg + temp(:,1);  % Because we wish to reconstruct just the first image
    outImg = reshape(outImg,112,92);
    subplot(2,5,i+1);
    subimage(uint8(outImg));
    
end
subplot(2,5,1);
subimage(testImg);
savefig( '../images/ImgReconstruction');
%% Eigen Faces

[V_25,X,avg] = q3(k(i),directoryname);
figure(2);
set(gcf,'numbertitle','off','name','Eigen faces for k = 5');
for i = 1:25
    subplot(5,5,i);
    temp = V_25(:,i);
    temp = reshape(temp,112,92);
    subplot(5,5,i);
    imshow(temp,[]);
end
savefig( '../images/EigenFaces');

figure(3);
set(gcf,'numbertitle','off','name','FFT of eigen faces for k = 5');
for i = 1:25
    subplot(5,5,i);
    temp = V_25(:,i);
    temp = reshape(temp,112,92);
    fft_EF = fft2(temp);
    fft_EF = fftshift(fft_EF);
    fft_EF = log10(1+fft_EF)
    subplot(5,5,i);
    imshow(fft_EF,[]);
end
savefig( '../images/EigenFacesFFT');


toc;
