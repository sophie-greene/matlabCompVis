function [ssim]=ssimFrame(imgRef,imgTest,width,height,K,W,L)
imgRef = double(imgRef);
imgTest = double(imgTest);

% automatic downsampling
f = max(1,round(min(width,height)/256));
%downsampling by f
%use a simple low-pass filter 
if(f>1)
    lpf = ones(f,f);
    lpf = (1./(f*f))*lpf;
    imgRef = imfilter(imgRef,lpf,'symmetric','same');
    imgTest = imfilter(imgTest,lpf,'symmetric','same');

    imgRef = imgRef(1:f:end,1:f:end);
    imgTest = imgTest(1:f:end,1:f:end);
end

C1 = (K(1)*L)^2;
C2 = (K(2)*L)^2;

ssim_map = filter2(W, imgRef, 'valid');        % gx
w1 = filter2(W, imgTest, 'valid');              % gy
w2 = ssim_map.*w1;                                % gx*gy
w2 = 2*w2+C1;                                     % 2*(gx*gy)+C1 = num1
w1 = (w1-ssim_map).^2+w2;                         % (gy-gx)^2+num1 = den1
ssim_map = filter2(W, imgRef.*imgTest, 'valid');  % g(x*y)
ssim_map = (2*ssim_map+(C1+C2))-w2;               % 2*g(x*y)+(C1+C2)-num1 = num2
ssim_map = ssim_map.*w2;                          % num
imgRef = imgRef.^2;                                   % x^2
imgTest = imgTest.^2;                                   % y^2
imgRef = imgRef+imgTest;                                 % x^2+y^2

if (C1 > 0 && C2 > 0)
   w2 = filter2(W, imgRef, 'valid');           % g(x^2+y^2)
   w2 = w2-w1+(C1+C2);                            % den2
   w2 = w2.*w1;                                   % den
   ssim_map = ssim_map./w2;                       % num/den = ssim
else
   w3 = filter2(W, imgRef, 'valid');           % g(x^2+y^2)
   w3 = w3-w1+(C1+C2);                            % den2
   w4 = ones(size(w1));
   index = (w1.*w3 > 0);
   w4(index) = (ssim_map(index))./(w1(index).*w3(index));
   index = (w1 ~= 0) & (w3 == 0);
   w4(index) = w2(index)./w1(index);
   ssim_map = w4;
end

ssim = mean2(ssim_map);