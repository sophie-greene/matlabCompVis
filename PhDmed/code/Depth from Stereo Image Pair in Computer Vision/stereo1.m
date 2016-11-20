%Code written by Abhimitra Meka and Chinmay Marathe for the course Computer Vision (EE-702) - 2012 by Prof. Subhasis Chaudhuri at the Dept. of Electrical Engineering // at IIT Bombay. In case you want to use this code, please credit the abovementioned. 
imgdir='/usr/not-backed-up/Webcambmp/';
r=imread(strcat(imgdir,'2012-11-30-110245.bmp'));
l=imread(strcat(imgdir,'2012-11-30-110144.bmp'));

l=double(rgb2gray(l));
r=double(rgb2gray(r));

a=1/3;
b=1/3;
c=1/3;

w=5;
s=size(l);

dw=(w-1)/2;

r=[r zeros(s(1),70)];

r=[r;zeros(1,size(r,2))];

d=-1*ones(s);
for j=(w+1)/2:w:s(1)-dw
for i=(w+1)/2:w:s(2)-dw
    
    l1=l(j-dw:j+dw,i-dw:i+dw);
   
   di=[];
   
   for m=0:1
   for k=0:69
       di=[di sum(sum(abs(r(j+m-dw:j+m+dw,i-dw+k:i+dw+k)-l1)))];    
    end
   end
    [x y]=min(di);
    d(j,i)=y-1;
    d(j,i)=rem(d(j,i),70);
    [i j];
end
end

d=downsample(d,w,dw);
d=downsample(d',w,dw)';

d=interp2(d,(w+1)/2);

d=round(d);

depth = 1./d;

depth(depth==inf) = 1;

%d=medfilt2(d,[w w]);

imshow(depth,[]);