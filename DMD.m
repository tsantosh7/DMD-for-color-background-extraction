%% clear and close all
clc; clear all; close all;
%% Read frames from baseline
% Frames = zeros(120, 160, 100);
myFolder = 'C:\Users\santo\Downloads\baseline'; % change here for your baseline
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);

for k = 1:length(jpegFiles)
    baseFileName = jpegFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
%     imageArray = imread(fullFileName);
%     imageArrayResized = imresize(imageArray, [120 160]);
%     Frames(:,:,k) = imageArrayResized(:,:,1);
    I = im2double((imread(fullFileName)));
    S{1}(:,k) =reshape(I(:,:,1),1,[]);
    S{2}(:,k) =reshape(I(:,:,2),1,[]);
    S{3}(:,k) =reshape(I(:,:,3),1,[]);
    gray_S(:,k) = reshape(rgb2gray(I),1,[]);
end
[m,n] = size(rgb2gray(I));
calibration = I;
         
clc

%% Compute DMD on all the colour channels
 
[rgbImage_background] = Compute_Color_DMD_BGI(S,m,n);

%% Computer the color calibration
  
imshow(rgbImage_background,[])