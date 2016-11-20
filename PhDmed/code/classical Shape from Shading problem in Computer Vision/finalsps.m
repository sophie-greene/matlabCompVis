z = double(rgb2gray(imread('sps1_s.jpg')));

% z = double((imread('mozart1.pgm')));

clc

s = size(z);
z = z/max(max(z));

% z = awgn(z,20);

gradx = 0.5*imfilter(z,[-1 0 1]);
grady = 0.5*imfilter(z,[-1 0 1]');

frac = 0.5;

t = gradx;
t(gradx<frac*max(max(gradx))) = 0;

t2 = gradx;
t2(gradx>frac*min(min(gradx))) = 0;

t3 = grady;
t3(grady<frac*max(max(grady))) = 0;

t4 = grady;
t4(grady>frac*min(min(grady))) = 0;

gt = zeros(s);
ft = zeros(s);

ft(t~=0) = -2;
ft(t2~=0) = 2;
gt(t3~=0) = 2;
gt(t4~=0) = -2;

ft1 = ft;
gt1 = gt;
y = ft.^2 + gt.^2;

ft1(y~=4) = 0;
gt1(y~=4) = 0;

ite = 10000;
lamb = 1;

fs = ft1;
gs = gt1;
 
laplacian = (1/8)*[1 1 1; 1 0 1; 1 1 1];

for k = 1:ite
    k;
    r1 = ((-1*(fs.^2))+(-1*(gs.^2))+4)./(((fs.^2))+((gs.^2))+4);
    r2 = 1./(((fs.^2))+((gs.^2))+4).^2;
    fsmooth = imfilter(fs,laplacian);
    fdata = (1/lamb)*32*fs.*r2.*(z-r1);
%     fs = fsmooth + fdata;
    fs(ft==0) = fsmooth(ft==0) - fdata(ft==0);
    gsmooth = imfilter(gs,laplacian);
    gdata = (1/lamb)*32*gs.*r2.*(z-r1);
%     gs = gsmooth + gdata;
    gs(gt==0) = gsmooth(gt==0) - gdata(gt==0);
end

p = (fs./2).*((1+r1)./r1);
q = (gs./2).*((1+r1)./r1);

r = 1./((p.^2 + q.^2 + 1).^2);

% mesh(r1);

p1 = p; q1 = q;
p1(z==0) = 0;
q1(z==0) = 0;

ps=zeros(s);
qs=zeros(s);

for i= 1:s(2)
    ps(:,i) = sum(p1(:,1:i),2);
end

ps(z==0) = 0;

for i = 1:s(1)
    qs(i,:)= sum(q1(i:end,:));
end

qs(z==0) = 0;

zs = ps+qs;

figure;subplot(1,2,1),imshow(p,[]);title('p');subplot(1,2,2),imshow(q,[]);title('q');hold on;
figure;subplot(1,2,1),imshow(fs,[]);title('f');subplot(1,2,2),imshow(gs,[]);title('g');hold on;
figure;subplot(1,2,1),mesh(r1);title('3-D from f,g');subplot(1,2,2),mesh(r);title('3-D from p,q');hold on;