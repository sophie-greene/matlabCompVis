function [pts a b c xx yy] = calc_epipolar_line(rL, F, imgR)
% purpose: calculates the epipolar line given a point in another image
% and a fundamental matrix defines the relationship between the
% two images
%
% outputs: pts - a 2xn array where row 1 is x values and row 2 are y
% values of the epipolar line in the other image. if
% there are no points in the right image then pts will be
% [NaN; NaN]
% a, b, c - the coefficients that define a line: ax + by + c = 0
%
% arguments: rL - set of points in a left image
% F - the fundamental matrix linking a left image to a right
% image through the equation rL' F rR = 0
% imgR - the right image (will be used for dimensions to
% calculate pts output)
%
% last updated: 2/22/2013 (eric squires)


    w = rL' * F; %calculate left side of rL' F rR = 0
    
    a = w(1,2); %from w rR = 0, we get the dot product of
    b = w(1,1); % w1 * rR1 + w2 * rR2 + w3 = 0
    c = w(1,3); % (this is the same thing as ax + by + c = 0)
    
    [rows cols] = size(imgR); %get the dimensions of the image
    xx = 1:cols; %let x-vary over the entire x-domain
    yy = (-c - b .*xx)./a; %calculate corresponding y given line equation
    
    idx = find(yy > 0 & yy < rows); %returns the indices of y that are within the image
    
    if isempty(idx)
        pts = [NaN; NaN];
    else
        pts = [xx(idx) ; yy(idx)];
    end

end