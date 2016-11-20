clear;
close all;
addpath(genpath('calib_data'));
addpath(genpath('Corner'));
addpath(genpath('lightDirectionSnaps'));


he=imread('/usr/not-backed-up/CalibData/cam4/light3pos0.bmp');

cform = makecform('srgb2lab');
lab_he = applycform(he,cform);
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
        pixel_labels = reshape(cluster_idx,nrows,ncols);

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

L = lab_he(:,:,1);
blue_idx = find(pixel_labels == blue_cluster_num);
L_blue = L(blue_idx);
is_light_blue = im2bw(L_blue,graythresh(L_blue));
nuclei_labels = repmat(uint8(0),[nrows ncols]);
nuclei_labels(blue_idx(is_light_blue==false)) = 1;
nuclei_labels = repmat(nuclei_labels,[1 1 3]);
seg = he;
seg(nuclei_labels ~= 0) = 0;
figure;subplot(2,2,1);
imshow(seg), title('colour seg out');
BW=edge(seg(:,:,1),'canny',.2);
subplot(2,2,2); imshow(BW),title('edge detector out');

hold off;
%get corners
img=findRec(BW)
%img=cell2mat(cor)
%[img,~]=corner(seg(:,:,1),[],[],[],.8);
% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
z=zeros(size(img,1)+1,size(img,2));
z(1:size(img,1),:)=img;
z(size(img,1)+1,:)=img(1,:);
hold off;
subplot(2,2,1); hold on;
plot(z(:,2),z(:,1),'Color','r','LineWidth',2,'MarkerSize',10);
%z=sortrows(z,2);
x=z(:,1)';
y=z(:,2)';
mask=poly2mask(y,x,480,640);
subplot(2,2,3); imshow(double(mask)),title('generated mask');
M(:,:,1)=mask;
M(:,:,2)=mask;
M(:,:,3)=mask;
s=he.*uint8(M);
subplot(2,2,4);imshow(s),title('masked image');
