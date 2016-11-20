I=imread('/usr/not-backed-up/CalibData/cam0/light3pos0.bmp');
BW=rgb2gray(I)>64;
imshow(BW);
[row col]=size(BW);

    
    contour = bwtraceboundary(BW, [row, col], 'W', 8, 50,...
        'clockwise');
    if(~isempty(contour))
        hold on;
        plot(contour(:,2),contour(:,1),'g','LineWidth',2);
        hold on;
        plot(col, row,'gx','LineWidth',2);
    else
        hold on; plot(col, row,'rx','LineWidth',2);
    end
