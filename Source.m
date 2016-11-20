clc;
clear all;

% lights direction

light1=[0 0 40];
light2=[20 5 40];
light3=[-5 15 40];
light4=[-10 -10 40];
light5=[5 -10 40];
light6=[5 20 40];

%normalize lights direction

light1 = light1 / norm(light1);
light2 = light2 / norm(light2);
light3 = light3 / norm(light3);
light4 = light4 / norm(light4);
light5 = light5 / norm(light5);
light6 = light6 / norm(light6);

% read images





img1 = imread('s_ss1.bmp');
img2 = imread('s_ss2.bmp');
img3 = imread('s_ss3.bmp');
img4 = imread('s_ss4.bmp');
img5 = imread('s_ss5.bmp');
img6 = imread('s_ss6.bmp');



%{

img1 = imread('s_ss1.bmp');
img2 = imread('s_ss2.bmp');
img3 = imread('s_ss3.bmp');
img4 = imread('s_ss4.bmp');
img5 = imread('s_ss5.bmp');
img6 = imread('s_ss6.bmp');


img1 = imread('s_gg1.bmp');
img2 = imread('s_gg2.bmp');
img3 = imread('s_gg3.bmp');
img4 = imread('s_gg4.bmp');
img5 = imread('s_gg5.bmp');
img6 = imread('s_gg6.bmp');


img1 = imread('s_cc1.bmp');
img2 = imread('s_cc2.bmp');
img3 = imread('s_cc3.bmp');
img4 = imread('s_cc4.bmp');
img5 = imread('s_cc5.bmp');
img6 = imread('s_cc6.bmp');


img1 = imread('ellipse1.bmp');
img2 = imread('ellipse2.bmp');
img3 = imread('ellipse3.bmp');
img4 = imread('ellipse4.bmp');
img5 = imread('ellipse5.bmp');
img6 = imread('ellipse6.bmp');
%}

% light directions 
S= [light1; light2 ;light3; light4; light5; light6];
%S= [light1; light2 ;light3; light4];

% initialize normal map
b=ones(size(img1,1), size(img1,2),3);
b=double(b);

% initialize gradient map
p=ones(size(img1,1), size(img1,2));
p=double(p);
q=p;

% initialize depth map
Z=ones(size(img1,1), size(img1,2));
Z=double(Z);


for i=1:size(img1,1)
    for j=1:size(img1,2)
       
        E=[img1(i,j) img2(i,j) img3(i,j) img4(i,j) img5(i,j) img6(i,j)];
        %E=[img1(i,j) img2(i,j) img3(i,j) img4(i,j)];
        E=double(E');
       
        tb= (inv(S'*S))*S'*E;
       
        nbm = norm(tb);
        if( nbm == 0)
            b(i,j,:) = 0; 
        else
            b(i,j,:) = tb / nbm; 
        end
        
        
        tM = [b(i,j,1) b(i,j,2) b(i,j,3)];
        nbm = norm(tM);
        if( nbm == 0)
            tM = [0 0 0];
        else
            tM = tM / nbm; 
        end        
        p(i,j)=tM(1,1);
        q(i,j)=tM(1,2);
    end
end


%depth map
for i=1:2:size(img1,1)
    for j=1:2:size(img1,2)
        Z(i,j) = sum(q(1:i, 1)) + sum(p(i,1:j));
    end
end
Z = Z*-1;

figure(1);
hold on;

for i=1:5:size(img1,1)
    for j=1:5:size(img1,2)
       
        plot3(j+b(i,j,1),i+b(i,j,2),b(i,j,3),'b' );
    end
end
hold off;

figure(2);
mesh(Z);


