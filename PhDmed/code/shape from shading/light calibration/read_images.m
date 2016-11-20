function [masks, L, imgs] = read_images(dataPath,RESIZE_X,RESIZE_Y,rot,trans,pos)


dirs = dir(dataPath);
camNames = {dirs([dirs.isdir]).name};
camNames = setdiff(camNames, {'.', '..'});
for camNumber = 1:numel(camNames)
    
    % read images
    imgFiles = dir(fullfile(dataPath, camNames{camNumber}, 'cam*.jpg'));
    maskFiles = dir(fullfile(dataPath, camNames{camNumber}, 'mask*.jpg'));
    
    maskPath = fullfile(dataPath, camNames{camNumber}, maskFiles(1).name);
    %read mask
    temp = imread(maskPath);
    temp = rgb2gray(temp);
    temp = imresize(temp,[RESIZE_Y,RESIZE_X]);
    mask = temp;
    mask(temp > 100) = 1;
    mask(temp <= 100) = 0;
    masks(camNumber,:,:) = mask;

    % mask = zeros(240,320);
    % mask(2:end-1,2:end-1) = 1;
    %mask = double(temp)/double(max(max(temp)));

    % process images
    for i = 1: numel(imgFiles)
         
        imgPath = fullfile(dataPath, camNames{camNumber}, imgFiles(i).name);
        temp = imread(imgPath);
        temp = rgb2gray(temp);
        temp = imresize(temp,[RESIZE_Y,RESIZE_X]);
         temp = double(temp)/double(max(max(temp)));
        %temp(find(temp>0.80)) = 0.80;
        imgs(camNumber,i,:,:) = temp;
    
%             figure;
%             imshow(shiftdim(imgs(camNumber,i,:,:),2));
    
        aux = regexp(imgFiles(i).name,'cam','split');
        cam_num = str2num(aux{2}(1)) + 1;
        aux = regexp(imgFiles(i).name,'light','split');
        light_num = str2num(aux{2}(1)) + 1;
        light(i,:) = shiftdim(rot(cam_num,:,:),1)*pos(light_num,:)'+trans(cam_num,:)';
    end

    light(:,2) = light(:,2)*-1;
    light(:,3) = light(:,3)*-1;
    light(:,3) = light(:,3)+50;
    for i = 1: size(imgs,2)
     L(camNumber,i,:)= light(i,:) / norm(light(i,:));
    end
end
