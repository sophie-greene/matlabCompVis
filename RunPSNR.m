

%recommended by Wang
K=[.01,.03];
% create a symetric lowpass Gausssian filter of size 11 x 11 and sigma1.5
W=fspecial('gaussian',11,1.5);
L=255;

folders={'bs','mc','pa','pr','rb','rh','sf','sh','st','tr'};
%initialise 

width=768;
height=432;

PN=[];
names=[];
SM=[];
MSM=[];
[~,sz]=size(folders);  
%keyboard;
cnt=1;
psnr=0;
ssim=0;
mssim=0;
psnrf=0;
ssimf=0;
mssimf=0;
vsnr=0;
vif=0;
vifp=0;
uqi=0;
ifc=0;
nqm=0;
wsnr=0;
snr=0;
level = 5;
weight = [0.0448 0.2856 0.3001 0.2363 0.1333];


for i=1:sz
  
   files=dir(strcat('../video/',folders{i},'/'));
   fileRef=strcat('../video/',folders{i},'/',regexprep(files(3).name,strcat(folders(i),'(\w*)_'),strcat(folders(i),'1_')));
    for j=3:size(files)
        fileTest=strcat('../video/',folders{i},'/',files(j).name);
        
        if strcmp(fileTest,fileRef)==0
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
                
                for intIndex=1:nFrameR
                  yuvRef=readYUVFrame(fIdRef,width,height);  
                  yuvTest=readYUVFrame(fIdTest,width,height);
%                   psnr=psnr+psnrFrame(yuvRef,yuvTest,L);
%                   ssim=ssim+ssimFrame_slow(yuvRef(:,:,1),yuvTest(:,:,1),K,W,L);
%                   mssim = mssim+ ssim_mscale_new(yuvRef(:,:,1),yuvTest(:,:,1), K, W, level, weight, 'product');
%                   psnrf=psnrf+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'PSNR');
                  ssimf=ssimf+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'SSIM');
%                   mssimf=mssimf+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'MSSIM');
%                   vsnr=vsnr+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'VSNR');
%                   vif=vif+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'VIF');
%                   vifp=vifp+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'VIFP');
%                   uqi=uqi+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'UQI');
%                   ifc=ifc+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'IFC');
%                   nqm=nqm+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'NQM');
%                   wsnr=wsnr+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'WSNR');
%                   snr=snr+metrix_mux(yuvRef(:,:,1),yuvTest(:,:,1),'SNR');
                end
%                  psnr=psnr/nFrameR;
%                 ssim=ssim/nFrameR;
%                 mssim=mssim/nFrameR;
%                  psnrf=psnrf/nFrameR;
%                   ssimf=ssimf/nFrameR;
                  mssimf=mssimf/nFrameR;
%                   vsnr=vsnr/nFrameR;
%                   vif=vif/nFrameR;
%                   vifp=vifp/nFrameR;
%                   uqi=uqi/nFrameR;
%                   ifc=ifc/nFrameR;
%                   nqm=nqm/nFrameR;
%                   wsnr=wsnr/nFrameR;
%                   snr=snr/nFrameR;
                fprintf('%s,%.4f\n',ssim);
                %fileTest,psnr,ssim,mssim,psnrff,mssimf,vif,vifp,uqi,ifc,nqm,wsnr,snr
           cnt=cnt+1;
         end
     end
end
