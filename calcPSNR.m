%calculate MSE,PSNR
% input: fileRef, fileTest; are names of YUV files of the videos under
% comparison;
% Resolution of both files is equal and is given to be 768X432
%fileRef,
%SM Greene

function [psnr]=calcPSNR(fileRef,fileTest,width,height,L)
    %calculate number of frames nFrame for both files 
    %and make sure they have equal nFrame
    fileMeta=dir(fileRef);
    fileSize=fileMeta.bytes;
    %calculate the number of frames nFrame
    %the sum of the Y(width) multiplied by Y(height) and
    % U(width) multiplied U(height) and 
    % V(width) multiplied V(height) 
    %((width*height)+((width/2)*(height/2))+((width/2)*(height/2)))=
    % ((3/2)*width*height);
    nFrameR=(fileSize*2)/(3*width*height);
    clear fileMeta;
    fileMeta=dir(fileTest);
    fileSize=fileMeta.bytes;
    nFrameT=(fileSize*2)/(3*width*height);
    if nFrameR~=nFrameT 
        error('inequal number of frames');
    end;
    %open reference file
    fIdRef=fopen(fileRef);
    fIdTest=fopen(fileTest);
    %read frame by frame and calculate mse and psnr for each
    psnr=0;
    
    for intIndex=1:nFrameR
      yuvRef=readYUVFrame(fIdRef,width,height);  
      yuvTest=readYUVFrame(fIdTest,width,height);
      psnr=psnr+psnrFrame(yuvRef,yuvTest,L);
      
    end
    psnr=psnr/nFrameR;
end
