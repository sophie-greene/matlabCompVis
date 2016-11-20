function  [imgYuv]=readYUVFrame(fileId,width,height) 
subSampleMat = [1, 1; 1, 1];
 % read Y component
        buf = fread(fileId, width * height, 'uchar');
        imgYuv(:, :, 1) = reshape(buf, width, height).'; % reshape

        % read U component
        buf = fread(fileId, width / 2 * height / 2, 'uchar');
        imgYuv(:, :, 2) = kron(reshape(buf, width / 2, height / 2).', subSampleMat); % reshape and upsample

        % read V component
        buf = fread(fileId, width / 2 * height / 2, 'uchar');
        imgYuv(:, :, 3) = kron(reshape(buf, width / 2, height / 2).', subSampleMat); % reshape and upsample

        % normalize YUV values
        % imgYuv = imgYuv / 255;

end