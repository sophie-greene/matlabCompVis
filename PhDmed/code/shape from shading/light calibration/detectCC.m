clear;
close all;
addpath(genpath('calib_data'));
addpath(genpath('lightDirectionSnaps'));
addpath(genpath('/usr/not-backed-up/Dropbox/PhDmed/code/Matlab_Functions'));

he=imread('/usr/not-backed-up/CalibData/cam3/light3pos0.bmp');


% cform = makecform('srgb2lab');
% lab_he = applycform(he,cform);
% ab = double(lab_he(:,:,2:3));
% nrows = size(ab,1);
% ncols = size(ab,2);
% ab = reshape(ab,nrows*ncols,2);
% 
% nColors = 2;
% % repeat the clustering 3 times to avoid local minima
% [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
%                                       'Replicates',3);
%         pixel_labels = reshape(cluster_idx,nrows,ncols);
% 
% 
% rgb_label = repmat(pixel_labels,[1 1 3]);
% 
% 
%     color = he;
%     color(rgb_label ~= 2) = 0;
%     seg=color;
    gray=rgb2gray(he);
    mask=gray>70;
 seg=gray%255*uint8(mask);

figure;subplot(2,2,1);
imshow(he), title('original image');

%he=histeq(he);
BW=edge(seg,'canny',.5);
subplot(2,2,2); imshow(BW),title('edge detector out');

hold off;
%get corners
[img,lines]=findRec(BW);
%img=cell2mat(cor)
%[img,~]=corner(seg(:,:,1),[],[],[],.8);
% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
z=zeros(size(img,1)+1,size(img,2));
z(1:size(img,1),:)=img;
z(size(img,1)+1,:)=img(size(img,1),:);
hold off;
subplot(2,2,1); hold on;
plot(z(:,1),z(:,2),'Color','r','LineWidth',2,'MarkerSize',10);
%z=sortrows(z,2);
x=z(:,1)';
y=z(:,2)';
mask=poly2mask(x,y,480,640);
subplot(2,2,3); imshow(double(mask)),title('generated mask');
M(:,:,1)=mask;
M(:,:,2)=mask;
M(:,:,3)=mask;
s=he.*uint8(M);
subplot(2,2,4);imshow(s),title('masked image');
