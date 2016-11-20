clear all;
close all;

addpath(genpath('../calib_data'));
camera_position_test

addpath(genpath('../pmcalib_data'));
addpath(genpath('../pmcalib'));

load('albedo.mat');
load('chipNames.mat');
load('sRGB_Values.mat');

%compare CCFind results with opencv results
% for i=1:8
% I=imread(strcat('cam',num2str(i-1),'light1pos0.bmp'));
%     [pos, m]=CCFind(I)
%     if size(pos,1)>0
%     temp=ones(size(pos,1),1);
%     Cr=[pos temp];
%     
%    % Cr=CcV/(m{i})';
%    
%     figure;
%     hold on;
%     plot(abs(pos(:,2))/max(abs(pos(:,2))),abs(pos(:,1))/max(abs(pos(:,1))),'og');
%     plot(abs(Cr(:,2))/max(abs(Cr(:,2))),abs(Cr(:,1))/max(abs(Cr(:,1))),'+b');
%   hold off
%     figure;
%     imshow(I)
%     hold on;
%     plot(pos(:,2),pos(:,1),'sr');
%     
% %     for K = 1:size(pos,1)
% %         text(pos(K,2),pos(K,1),chipNames(K));
% %     end
%     hold off;
%      end
% end





%I{1}=double(rgb2gray(I{1}));
% for i=1:24
% r=pos(1,1);
% c=pos(1,2);
% %l{i}=n.*I(r,c)/albedo(i);
% end
hold off;
% I=rgb2gray(I);
% I = wiener2(I,[100 100]);
%
% figure, imshow(I), title('original image');
%
% [~, threshold] = edge(I, 'sobel');
% fudgeFactor = .5;
% BWs = edge(I,'sobel', threshold * fudgeFactor);
% figure, imshow(BWs), title('binary gradient mask');
%
% se90 = strel('square', 1);
%
% % se180=strel('line', 1, 180);
% % se270=strel('line', 1, 270);
% BWsdil = imdilate(BWs, [se90]);
% figure, imshow(BWsdil), title('dilated gradient mask');
%
% BWdfill = imfill(BWsdil, 'holes');
% figure, imshow(BWdfill);
% title('binary image with filled holes');
%
% BWnobord = imclearborder(BWdfill, 4);
% figure, imshow(BWnobord), title('cleared border image');
%
% seD = strel('diamond',1);
% %seD1 = strel('diamond',1);
% BWfinal = imerode(BWnobord,[seD ]);
% BWfinal = imerode(BWfinal,[seD ]);
% figure, imshow(BWfinal), title('segmented image');
%
% BWoutline = bwperim(BWfinal);
% figure; imshow(BWoutline);
% Segout = I;
% Segout(BWoutline) = 255;
% figure, imshow(Segout), title('outlined original image');