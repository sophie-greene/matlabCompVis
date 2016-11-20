close all;
addpath(genpath('D:\Dropbox\matlabfunctions')); 
addpath(genpath('D:\Dropbox\multi\fundMat\')); 
addpath(genpath('D:\Dropbox\shape from shading_new\shape from shading\'));
opencv2mat('multi/fundMat/cam1cam4.yml','temp.yml')
F=getfMatrix('temp.yml','fundamental')

I1=imread('multi/calImg_cam1/calibrate0.bmp');

I2=imread('multi/calImg_cam4/calibrate0.bmp');
% point=[ 434 190]
% [pts a b c xx yy] = calc_epipolar_line([point 1]',F, I2)
% [rows cols]=size(I2);
% valx=1:cols;
% valy=(-c -b .*valx)./a;
% indx = find(valy > 0 & valy < rows);
%  if isempty(indx)
%         p = [NaN; NaN];
%     else
%         p = [valx(indx) ; valy(indx)];
%     end
% figure;
% imshow(I1);
% hold on;
% plot(point(1),point(2),'xg');
% figure;
% imshow(I2);
% hold on;
% plot(valx,valy,'w');
% plot(pts(1,:),pts(2,:),'y');
% hold off;
% point=[pts(:,4) ]
% [pts a b c xx yy] = calc_epipolar_line([point' 1]', F', I1)
% figure(1);
% hold on;
[m n] = size(I1);
 


figure(1),imshow(I1); 
figure(2),imshow(I2); 

% Start plotting:
point=[ 377 360]
left_x=point(1);
left_y=point(2);
figure(1);    
hold on;
plot(left_x, left_y, 'r*'); 
hold off;
% Getting the epipolar line on the RIGHT image:

left_P = [left_x; left_y; 1];
right_P = F*left_P;
right_epipolar_x = 1:2*m;

% Using the eqn of line: ax+by+c=0; y = (-c-ax)/b
right_epipolar_y = (-right_P(3)-right_P(1)*right_epipolar_x)/right_P(2);

figure(2); hold on; plot(right_epipolar_x, right_epipolar_y, 'r');

hold off;
% Now finding the other epipolar line on the left image itself:
    
% We know that left epipole is the 3rd column of V.
% We get V from svd of F. F=UDV'
[FU, FD, FV] = svd(F);
left_epipole = FV(:,3);
left_epipole = left_epipole/left_epipole(3);

% Hence using the left epipole and the given input point on left
% image we plot the epipolar line on the left image
left_epipolar_x = 1:2*m;
left_epipolar_y = left_y + (left_epipolar_x-left_x)*(left_epipole(2)-left_y)/(left_epipole(1)-left_x);
        
figure(1); hold on; plot(left_epipolar_x, left_epipolar_y, 'r');hold off;

% plot(pts(1,:),pts(2,:),'y');
% hold off;