
function [hcorner,lines]=findRec(BW)
Pi=22/7;
[H, theta, rho] = hough(BW);
corners=corner(BW);
for i=1:length(corners)
    for j=1:length(corners)
    dist(i,j)=norm(corners(i,:)-corners(j,:));
    end
end
%Find the peaks in the Hough transform matrix, H
P = houghpeaks(H,4,'threshold',ceil(0.5*max(H(:))));
%
x = theta(P(:,2));
y = rho(P(:,1));
%Find lines in the image using the houghlines function.
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',80);

% for k = 1:length(lines)
%     xy = [lines(k).point1; lines(k).point2];
%     % corners{k}=xy;
%
%     % Determine the endpoints of the longest line segment
%     len{k} = norm((lines(k).point1 - lines(k).point2));
% end
% cnt=1
% for k = 1:length(lines)
%     if (mod(k,2))
%         corner(cnt,:)=lines(k).point1;
%         cnt=cnt+1
%         corner(cnt,:)=lines(k).point2;
%         cnt=cnt+1
%     else
%         corner(cnt,:)=lines(k).point2;
%         cnt=cnt+1
%         corner(cnt,:)=lines(k).point1;
%         cnt=cnt+1
%     end
% end
cnt=1;
prev1=0;
prev2=0;
for i=1:length(lines)
%     thetas(i)=lines(i).theta;
%     rhos(i)=lines(i).rho;
%     points1(i,:)=lines(i).point1;
%     points2(i,:)=lines(i).point2;
%     p1mag(i)=norm(lines(i).point1);
%     p2mag(i)=norm(lines(i).point2);

if((norm(prev1)>norm(lines(i).point2)-5)&&(norm(prev2)<norm(lines(i).point2)+5))
    hcorner(cnt,:)=lines(i).point2;
    cnt=cnt+1;
    hcorner(cnt,:)=lines(i).point1;
     cnt=cnt+1;
     prev2=lines(i).point1;
     prev1=lines(i).point2;
else
     hcorner(cnt,:)=lines(i).point1;
    cnt=cnt+1;
    hcorner(cnt,:)=lines(i).point2;
     cnt=cnt+1;
     prev1=lines(i).point1;
     prev2=lines(i).point2;
end
     
end
%angle between Lines
% for i=1:length(lines)
%     ang(i,:)=abs(thetas-thetas(i));
%     p1diff(i,:)=abs(p1mag-p1mag(i));
%     p2diff(i,:)=abs(p2mag-p2mag(i));
% end
% mang=((ang>80)&(ang<90)& (p2diff<5));
% 
% ang=ang.*mang;
% %find lines which are perpendicular
% [tem ,ind]=max(ang);
% [~,L1]=max(tem);
% L2=ind(L1);
%find 4th point using the angles info
% coeff=[1, -tan(Pi*lines(L2).theta/180); ...
%         1, -tan(Pi*lines(L1).theta/180)]
% val=[lines(L2).point1(2)-(lines(L2).point1(1)*tan(Pi*lines(L2).theta/180));...
%     lines(L1).point1(2)-(lines(L1).point1(1)*tan(Pi*lines(L1).theta/180))]
% point=(val'/(coeff))
%         hcorner(1,:)=lines(L1).point1;
%        
%         hcorner(2,:)=lines(L1).point2;
%       
%         hcorner(3,:)=lines(L2).point1;
%     hcorner(4,:)=point;

%corners=reshape(cell2mat(corner'),5,2)

end