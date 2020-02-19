function [ Norm] = color_calibrate(Source,Target)

% RGB to LAB colour space conversion for Source/Ref Image
SourceLab = applycform(im2double(Source), makecform('srgb2lab'));

% Means of Source image channels in Lab Colourspace
ms = mean(reshape(SourceLab, [], 3));

% Standard deviations of Source image channels in Lab Colourspace
stds = std(reshape(SourceLab, [], 3));


% RGB to LAB colour space conversion for Target Image
TargetLab = applycform(im2double(Target), makecform('srgb2lab'));

% Means of Target image channels in Lab Colourspace
mt = mean(reshape(TargetLab, [], 3));

% Standard deviations of Target image channels in Lab Colourspace
stdt = std(reshape(TargetLab, [], 3));


% Normalise each channel based on statistics of source and target images
NormLab(:,:,1) = ((SourceLab(:,:,1)-ms(1))*(stdt(1)/stds(1)))+mt(1);
NormLab(:,:,2) = ((SourceLab(:,:,2)-ms(2))*(stdt(2)/stds(2)))+mt(2);
NormLab(:,:,3) = ((SourceLab(:,:,3)-ms(3))*(stdt(3)/stds(3)))+mt(3);

% LAB to RGB conversion
Norm = applycform(NormLab, makecform('lab2srgb'));
end

