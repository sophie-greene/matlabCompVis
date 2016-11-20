function [ssim]=ssimFrame_slow(imgRef,imgTest,K,W,L)
imgRef = double(imgRef);
imgTest = double(imgTest);


C1 = (K(1)*L)^2;
C2 = (K(2)*L)^2;

mx   = filter2(W, imgRef);
my   = filter2(W, imgTest);
mx_sq = mx.*mx;
my_sq = my.*my;
mx_my = mx.*my;
%local application of ssim calculations
sigmax_sq = filter2(W, imgRef.*imgRef) - mx_sq;
sigmay_sq = filter2(W, imgTest.*imgTest) - my_sq;
sigmaxy = filter2(W, imgRef.*imgTest) - mx_my;


   ssim_matrix = ((2*mx_my + C1).*(2*sigmaxy + C2))./((mx_sq + my_sq + C1).*(sigmax_sq + sigmay_sq + C2));


ssim = mean2(ssim_matrix);