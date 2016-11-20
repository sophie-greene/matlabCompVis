
clear;
close all;
addpath(genpath('calib_data'));
addpath(genpath('Corner'));
addpath(genpath('lightDirectionSnaps'));
path='/usr/not-backed-up/CalibData/';
for cam=1:8
    for light=1:2
        
        name=strcat(path,'cam',num2str(cam-1),'/light',num2str(light-1),'pos0.bmp')
        I=imread(name);
        Igray=rgb2gray(I);
        img{cam}{light}=corner(I,[],[],[],.999);
        
        z=zeros(size(img{cam}{light},1)+1,size(img{cam}{light},2));
        z(1:size(img{cam}{light},1),:)=img{cam}{light}
        [r,c]=find(Igray);
        % find all points inside the rectangle
        [in , on]=inpolygon(r,c,img{cam}{light}(:,1),img{cam}{light}(:,2));
        
        z(size(img{cam}{light},1)+1,:)=img{cam}{light}(1,:);
       figure;
        imshow(I)
        hold on;
        plot(z(:,2),z(:,1),'Color','r','LineWidth',4,'MarkerSize',10);
        
        hold off;
    end
end