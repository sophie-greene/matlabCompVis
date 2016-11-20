addpath(genpath('D:\Dropbox\matlabfunctions\')); 
opencv2mat('point/cam0.yml','pt0.yml');
YamlStruct = ReadYaml('pt0.yml');
pt0=double(uint16(reshape(cam0points',2,length(cam0points)/2)))';
pt7=double(uint16(reshape(cam7points',2,length(cam7points)/2)))';
figure(1);
im=imread('calImg_cam0/calibrate0.bmp');

imshow(im);

figure(2);
im = imread('calImg_cam7/calibrate0.bmp');
imshow(im);

for i =1:size(pt0,1)
    color = [rand() rand() rand()];
    figure(1);
    hold on;
    plot(pt0(i,1), pt0(i,2),'x','color',color);
    hold off;
    figure(2);
    hold on;
    plot(pt7(i,1), pt7(i,2),'x','color',color);
    hold off;
end
 x1=ones(size(pt0,1),1);
 x2= ones(size(pt7,1),1);
F = det_F_algebraic([pt0(1:end,:) x1]',[pt7(1:end,:) x2]',1,640*480)