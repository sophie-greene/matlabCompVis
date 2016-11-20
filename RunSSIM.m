%recommended by Wang
K=[.01,.03];
% create a symetric lowpass Gausssian filter of size 11 x 11 and sigma1.5
W=fspecial('gaussian',11,1.5);
L=255;

fileRef='../video/bs/bs1_25fps.yuv';

fileTest='../video/bs/bs8_25fps.yuv';
width=768;
height=432;
[ssim]=calcSSIM(fileRef,fileTest,height,width,K,W,L);