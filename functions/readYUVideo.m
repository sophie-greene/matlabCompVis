function [mov]=readYUVideo(width,height,fin)   
  
    s=dir(fin);
    filesize=s.bytes;
   
    frame=(filesize*2)/(width*height*3); 
    fileId = fopen(fin, 'r');
   % mov.size=frame;
    for f = 1 : 1 : frame
      % read YUV from file 
       [imgYuv]=readYUVFrame(fileId,width,height) ;
        % convert YUV to RGB
        imgRgb=convertYuvToRgb(reshape(imgYuv, height * width, 3));
        imgRgb = reshape(imgRgb, height, width, 3);
        mov(f) = im2frame(imgRgb);
    end
fclose(fileId);
end

