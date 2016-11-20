imgdir='/usr/not-backed-up/Webcambmp/';
image = double(rgb2gray(imread(strcat(imgdir,'2012-11-30-110245.bmp'))));

z = image;

% load('sphere');
% z = en;

s = size(z);

p = imfilter(z,[-0.5 0.5]);
q = imfilter(z,[-0.5 0.5]');
 
ps = zeros(size(z));
qs = zeros(size(z));

ps(p>0.2*max(max(p))) = 255;
ps(p<0.2*min(min(p))) = -255;

qs(q>0.2*max(max(q))) = 255;
qs(q<0.2*min(min(q))) = -255;

% ps = 255*ones(size(z));
% qs = 255*ones(size(z));
% 
% 
% ps(z>0.9*max(max(z))) = 0;
% qs(z>0.9*max(max(z))) = 0;

px = zeros(size(ps));
px(ps~=0) = 1;

qy = zeros(size(qs));
qy(qs~=0) = 1;

ps1 = ps;
qs1 = qs;

ite = 2000;
lamb = .25;

z = z/max(max(z));

fs = 2*ps./(1+((1+ps.^2+qs.^2).^(0.5)));
gs = 2*ps./(1+((1+ps.^2+qs.^2).^(0.5)));

 
% for k = 1:ite
%     k
%     for i = 2:s(1)-1
%         for j = 2:s(2)-1
% %                 r = ((-1*(fs(i,j)^2))+(-1*(g(i,j)^2))+4)/(((f(i,j)^2))+((g(i,j)^2))+4);
% %                 r1 = (1/(fs(i,j)^2+gs(i,j)^2+4)^2);
%              r = 1/((((ps(i,j)^2) + (qs(i,j)^2) + 1))^(0.5));
%             if (px(i,j)~=1)
% %                    fs(i,j) = (0.125*(fs(i-1,j)+fs(i+1,j)+fs(i,j-1)+fs(i,j+1)+fs(i-1,j-1)+fs(i-1,j+1)+fs(i+1,j-1)+fs(i+1,j+1))) + ((1/lamb)*fs(i,j)*r1*(z(i,j)-r)); 
%                   ps(i,j) = (0.125*(ps(i-1,j)+ps(i+1,j)+ps(i,j-1)+ps(i,j+1)+ps(i-1,j-1)+ps(i-1,j+1)+ps(i+1,j-1)+ps(i+1,j+1))) + ((1/lamb)*255*ps(i,j)*(r^3)*(z(i,j)-r));
%             end
%             if (qy(i,j)~=1)
% %                    gs(i,j) = (0.125*(gs(i-1,j)+gs(i+1,j)+gs(i,j-1)+gs(i,j+1)+gs(i-1,j-1)+gs(i-1,j+1)+gs(i+1,j-1)+gs(i+1,j+1))) + ((1/lamb)*gs(i,j)*r1*(z(i,j)-r)); 
%                   qs(i,j) = (0.125*(qs(i-1,j)+qs(i+1,j)+qs(i,j-1)+qs(i,j+1)+qs(i-1,j-1)+qs(i-1,j+1)+qs(i+1,j-1)+qs(i+1,j+1))) + ((1/lamb)*255*qs(i,j)*(r^3)*(z(i,j)-r));
%             end
%         end
%     end
% end

% ps2 = ps/max(max(abs(ps)));
% qs2 = qs/max(max(abs(qs)));
% 
% zs = 1./((((ps2.^2) + (qs2.^2) + 1)).^(0.5));

fs2 = 2*fs/max(max(abs(fs)));
gs2 = 2*gs/max(max(abs(gs)));

zs = ((-1*(fs.^2))+(-1*(gs.^2))+4)/(((fs.^2))+((gs.^2))+4);

subplot(1,2,1),imshow(fs2,[]);
subplot(1,2,2),imshow(zs,[]);