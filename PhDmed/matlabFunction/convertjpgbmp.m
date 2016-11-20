function [  ] = convertjpgbmp( directoryName )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cd(directoryName);
outputfolder=strcat(directoryName,'bmp');
mkdir(outputfolder);
d=dir;
for i=3:length(d)
    str=d(i).name;
    I=imread(str,'jpg');
    %change name to bmp
    str=strcat(str(1:length(str)-4),'.bmp');
    imwrite(I,strcat(outputfolder,'/',str),'bmp');
end

end

