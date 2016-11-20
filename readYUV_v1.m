%read YUV
%04/05/2012
%SM Greene
%input: file, resolution width x height of the video
    width=768;
    height=432;
    
    f_in='../video/bs/bs1_25fps.yuv';
    fileMeta=dir(f_in);
    fileSize=fileMeta.bytes;
    [fId_ref, ~]=fopen(f_in,'r');
    clear filemeta f_in; 
    %calculate the number of frames nFrame
    %the sum of the Y(width) multiplied by Y(height) and
    % U(width) multiplied U(height) and 
    % V(width) multiplied V(height) 
    %((width*height)+((width/2)*(height/2))+((width/2)*(height/2)))=
    % ((3/2)*width*height);
    nFrame=(2*fileSize)/(3*width*height);
    
    for i=1:nFrame;    
        clear yuv;
        Y=fread(fId_ref, [width, height], '*uint8');
        U=fread(fId_ref, [width/2, height/2], '*uint8');
        U=imresize(U,2);
        
        V=fread(fId_ref, [width/2, height/2], '*uint8');
        V=imresize(V,2);
        yuv(:,:,1)=Y;
        yuv(:,:,2)=U;
        yuv(:,:,3)=V;
        % convert YUV image to RGB
        %RGB=C*YUV
        load conversion.mat
        yuv=double(yuv);
        yuv= reshape(yuv, height* width, 3);
        yuv(:, 2 : 3) = yuv(:, 2 : 3) - 127;
      
        rgb = (yuvToRgb *yuv.').';
        rgb= reshape(rgb, height, width, 3);
        rgb = uint8(clipValue(rgb, 0, 255));
        mov(nFrame)=im2frame(uint8(rgb));
    end; 
    implay(mov);
    fclose(fId_ref);

