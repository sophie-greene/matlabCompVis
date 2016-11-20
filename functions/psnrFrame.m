function [psnr]= psnrFrame(yuvRef,yuvTest,L) 
    mse = mean((yuvRef(:) - yuvTest(:)).^2);
%     Err=yuvRef-yuvTest;
% %     since mse is not dependant on pixel's location in the image
%     Err= reshape(Err,[],1);% ----> Err(:)
%     [m,~]=size(Err);
%     mse=0;
%     for i=1:m
%         mse=mse+Err(i)^2;
%     end
%     mse=mse/m;
    psnr=10*log10(L^2/mse);
end
