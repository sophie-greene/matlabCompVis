function [pos rot trans cam] = camera_position_test()


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
cam1cm=cam1cm';
cam2cm=cam2cm';
cam3cm=cam3cm';
cam4cm=cam4cm';
cam5cm=cam5cm';
cam6cm=cam6cm';
cam7cm=cam7cm';

cam0_rot = cam0_rot';
cam1_rot = cam1_rot';
cam2_rot = cam2_rot';
cam3_rot = cam3_rot';
cam4_rot = cam4_rot';
cam5_rot = cam5_rot';
cam6_rot = cam6_rot';
cam7_rot = cam7_rot';


rot(1,:,:) = cam0_rot;
rot(2,:,:) = cam1_rot;
rot(3,:,:) = cam2_rot;
rot(4,:,:) = cam3_rot;
rot(5,:,:) = cam4_rot;
rot(6,:,:) = cam5_rot;
rot(7,:,:) = cam6_rot;
rot(8,:,:) = cam7_rot;

trans(1,:,:) = cam0trans;
trans(2,:,:) = cam1trans;
trans(3,:,:) = cam2trans;
trans(4,:,:) = cam3trans;
trans(5,:,:) = cam4trans;
trans(6,:,:) = cam5trans;
trans(7,:,:) = cam6trans;
trans(8,:,:) = cam7trans;


%camera locations
pos(1,:)=-cam0_rot'*cam0trans;
pos(2,:)=-cam1_rot'*cam1trans;
pos(3,:)=-cam2_rot'*cam2trans;
pos(4,:)=-cam3_rot'*cam3trans;
pos(5,:)=-cam4_rot'*cam4trans;
pos(6,:)=-cam5_rot'*cam5trans;
pos(7,:)=-cam6_rot'*cam6trans;
pos(8,:)=-cam7_rot'*cam7trans;

%camera matrices

cam(1,:,:) = cam0cm;
cam(2,:,:) = cam1cm;
cam(3,:,:) = cam2cm;
cam(4,:,:) = cam3cm;
cam(5,:,:) = cam4cm;
cam(6,:,:) = cam5cm;
cam(7,:,:) = cam6cm;
cam(8,:,:) = cam7cm;




%Plotting positions

% figure;
% hold on;
% %c0=pos(1,:);c1=pos(2,:);c2=pos(3,:);c3=pos(4,:);c4=pos(5,:);c5=pos(6,:);c6=pos(7,:);c7=pos(8,:);
% quiver3(0,0,0,pos(1,1),pos(1,2),pos(1,3),'b');
% quiver3(0,0,0,pos(2,1),pos(2,2),pos(2,3),'r');
% quiver3(0,0,0,pos(3,1),pos(3,2),pos(3,3),'g');
% quiver3(0,0,0,pos(4,1),pos(4,2),pos(4,3),'cyan');
% quiver3(0,0,0,pos(5,1),pos(5,2),pos(5,3),'cyan');
% quiver3(0,0,0,pos(6,1),pos(6,2),pos(6,3),'b');
% quiver3(0,0,0,pos(7,1),pos(7,2),pos(7,3),'r');
% quiver3(0,0,0,pos(8,1),pos(8,2),pos(8,3),'g');
% hold off;
