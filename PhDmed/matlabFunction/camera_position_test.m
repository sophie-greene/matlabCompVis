% create mat compatible yml files
opencv2mat('cam0Extrinsic.yml','cam0e.yml');
opencv2mat('cam1Extrinsic.yml','cam1e.yml');
opencv2mat('cam2Extrinsic.yml','cam2e.yml');
opencv2mat('cam3Extrinsic.yml','cam3e.yml');
opencv2mat('cam4Extrinsic.yml','cam4e.yml');
opencv2mat('cam5Extrinsic.yml','cam5e.yml');
opencv2mat('cam6Extrinsic.yml','cam6e.yml');
opencv2mat('cam7Extrinsic.yml','cam7e.yml');

opencv2mat('cam0Intrinsics.yml','cam0i.yml');
opencv2mat('cam1Intrinsics.yml','cam1i.yml');
opencv2mat('cam2Intrinsics.yml','cam2i.yml');
opencv2mat('cam3Intrinsics.yml','cam3i.yml');
opencv2mat('cam4Intrinsics.yml','cam4i.yml');
opencv2mat('cam5Intrinsics.yml','cam5i.yml');
opencv2mat('cam6Intrinsics.yml','cam6i.yml');
opencv2mat('cam7Intrinsics.yml','cam7i.yml');
%---------------------------------------------------------------------------------
%cameras extrinsic params
%---------------------------------------------------------------------------------
[cam0trans, cam0_rot]=getMatrix('cam0e.yml','translationVector','rotationMatrix');
[cam1trans, cam1_rot]=getMatrix('cam1e.yml','translationVector','rotationMatrix');
[cam2trans, cam2_rot]=getMatrix('cam2e.yml','translationVector','rotationMatrix');
[cam3trans, cam3_rot]=getMatrix('cam3e.yml','translationVector','rotationMatrix');
[cam4trans, cam4_rot]=getMatrix('cam4e.yml','translationVector','rotationMatrix');
[cam5trans, cam5_rot]=getMatrix('cam5e.yml','translationVector','rotationMatrix');
[cam6trans, cam6_rot]=getMatrix('cam6e.yml','translationVector','rotationMatrix');
[cam7trans, cam7_rot]=getMatrix('cam7e.yml','translationVector','rotationMatrix');

[cam0cm, cam0_dist]=getMatrix('cam0i.yml','cameraMatrix','DistCoeffs');
[cam1cm, cam1_dist]=getMatrix('cam1i.yml','cameraMatrix','DistCoeffs');
[cam2cm, cam2_dist]=getMatrix('cam2i.yml','cameraMatrix','DistCoeffs');
[cam3cm, cam3_dist]=getMatrix('cam3i.yml','cameraMatrix','DistCoeffs');
[cam4cm, cam4_dist]=getMatrix('cam4i.yml','cameraMatrix','DistCoeffs');
[cam5cm, cam5_dist]=getMatrix('cam5i.yml','cameraMatrix','DistCoeffs');
[cam6cm, cam6_dist]=getMatrix('cam6i.yml','cameraMatrix','DistCoeffs');
[cam7cm, cam7_dist]=getMatrix('cam7i.yml','cameraMatrix','DistCoeffs');
cam0cm=cam0cm';
cam0cm=cam0cm';
% camera locations
c0=-cam0_rot'*cam0trans';
c1=-cam1_rot'*cam1trans';
c2=-cam2_rot'*cam2trans';
c3=-cam3_rot'*cam3trans';
c4=-cam4_rot'*cam4trans';
c5=-cam5_rot'*cam5trans';
c6=-cam6_rot'*cam6trans';
c7=-cam7_rot'*cam7trans';

%camera locations
% c0=cam0trans;
% c1=cam1trans;
% c2=cam2trans;
% c3=cam3trans;
% c4=cam4trans;
% c5=cam5trans;
% c6=cam6trans;
% c7=cam7trans;

% yaml_file = '/export/mailgrp2_d/scssaq/recon/3dReconstruction/objectpoints.yml';
% YamlStruct = ReadYaml(yaml_file);
% for i=1:8
%     temp=getfield( YamlStruct,'objectpoints');
%     temp= cell2mat(temp)
%     temps{i}=reshape(temp,20,2)
%     end
%     x = 345;
%     y = 284;
%     p = [x;y;1];
%    
%    rt = zeros(3,4);
%    rt1=zeros(3,4);
%    
%    rt(1:3,1:3) = cam0_rot;
%    rt(1:3,4) = cam0trans;
%    rt1(1:3,1:3) = cam1_rot;
%    rt1(1:3,4) = cam1trans;
%   s=cam0cm'*rt*[0;0;0;1]
%   s1=cam1cm'*rt1*[0;0;0;1]

% c0=c0-c0;
% c1=c1-c0;
% c2=c2-c0;
% c3=c3-c0;
% c4=c4-c0;
% c5=c5-c0;
% c6=c6-c0;
% c7=c7-c0;
figure;
hold on;
%Plotting positions based on translations only
quiver3(0,0,0,c0(1),c0(2),c0(3),'b');

quiver3(0,0,0,c1(1),c1(2),c1(3),'r');

quiver3(0,0,0,c2(1),c2(2),c2(3),'g');

quiver3(0,0,0,c3(1),c3(2),c3(3),'cyan');

quiver3(0,0,0,c4(1),c4(2),c4(3),'cyan');

quiver3(0,0,0,c5(1),c5(2),c5(3),'b');

quiver3(0,0,0,c6(1),c6(2),c6(3),'r');

quiver3(0,0,0,c7(1),c7(2),c7(3),'g');

hold off;
% figure;
% hold on;
% plot3(c0(1),c0(2),c0(3),'bo');
% 
% plot3(c1(1),c1(2),c1(3),'rx');
% 
% plot3(c2(1),c2(2),c2(3),'go');
% 
% plot3(c3(1),c3(2),c3(3),'cyano');
% 
% plot3(c4(1),c4(2),c4(3),'cyano');
% 
% plot3(c5(1),c5(2),c5(3),'bo');
% 
% plot3(c6(1),c6(2),c6(3),'rx');
% 
% plot3(c7(1),c7(2),c7(3),'go');
% hold off;
% %plot3(c0(1),c0(2),c0(3),'ro');
