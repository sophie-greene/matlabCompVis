
clear all;
I = imread('/usr/not-backed-up/Webcambmp/2012-11-30-110600.bmp');
I = rgb2gray(I);
imshow(I);

S = gradient(double(I));
imshow(S)
