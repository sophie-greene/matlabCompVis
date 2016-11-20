clear;
close all;
addpath(genpath('calib_data'));
addpath(genpath('lightDirectionSnaps'));
addpath(genpath('/usr/not-backed-up/Dropbox/PhDmed/code/Matlab_Functions'));
Irgb=imread('/export/mailgrp2_d/scssaq/captureVideo/CalibData/cam0/light6pos0.bmp');
%isolate the yellow circle. yellow hue value [50-65]/255 http://mkweb.bcgsc.ca/color_summarizer/?faq
Ihsv=rgb2hsv(Irgb);
im_y_mask(:,:,1)=Ihsv(:,:,1)>.2 & Ihsv(:,:,1)<.3& Ihsv(:,:,2)>.3 ...
    & Ihsv(:,:,3)>.2;
im_y_mask(:,:,2)=im_y_mask(:,:,1);
im_y_mask(:,:,3)=im_y_mask(:,:,1);
im_y=Ihsv.*im_y_mask;
[centers, radii, ~] = imfindcircles(im_y,[50 150])
figure;imshow(Ihsv);hold on; plot(centers(:,1),centers(:,2),'xr');hold off
%green hue value [85-170]/255 
im_g_mask(:,:,1)=Ihsv(:,:,1)>.4 & Ihsv(:,:,1)<.5 ...
                    & Ihsv(:,:,2)>.3& Ihsv(:,:,3)>.2;
im_g_mask(:,:,2)=im_g_mask(:,:,1);
im_g_mask(:,:,3)=im_g_mask(:,:,1);
im_g=Ihsv.*im_g_mask;
[centers, radii, ~] = imfindcircles(im_g,[2 15])
hold on; plot(centers(:,1),centers(:,2),'xg');hold off
%dark blue hue value [85-170]/255 
im_b_mask(:,:,1)=Ihsv(:,:,1)>.5 & Ihsv(:,:,1)<.9& ...
    Ihsv(:,:,2)>.3& Ihsv(:,:,3)>.8;
im_b_mask(:,:,2)=im_b_mask(:,:,1);
im_b_mask(:,:,3)=im_b_mask(:,:,1);
im_b=Ihsv.*im_b_mask;
[centers, radii, ~] = imfindcircles(im_b,[2 15])
hold on; plot(centers(:,1),centers(:,2),'xb');hold off