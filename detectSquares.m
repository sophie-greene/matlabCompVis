addpath(genpath('/export/mailgrp2_d/scssaq/scssaq/3dReconstruction/calib_data')); 

I = imread('video7.jpg');
I=rgb2gray(I);
I = wiener2(I,[100 100]);

figure, imshow(I), title('original image');

[~, threshold] = edge(I, 'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

se90 = strel('square', 1);

% se180=strel('line', 1, 180);
% se270=strel('line', 1, 270);
BWsdil = imdilate(BWs, [se90]);
figure, imshow(BWsdil), title('dilated gradient mask');

BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

seD = strel('diamond',1);
%seD1 = strel('diamond',1);
BWfinal = imerode(BWnobord,[seD ]);
BWfinal = imerode(BWfinal,[seD ]);
figure, imshow(BWfinal), title('segmented image');

BWoutline = bwperim(BWfinal);
figure; imshow(BWoutline);
Segout = I;
Segout(BWoutline) = 255;
figure, imshow(Segout), title('outlined original image');