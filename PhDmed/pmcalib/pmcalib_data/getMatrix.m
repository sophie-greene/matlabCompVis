function[object, image, files]=getMatrix(filename,firstItem,secondItem)

    addpath(genpath('/usr/not-backed-up/YAMLMatlab_0.4.3')); 
    yaml_file = filename;
    YamlStruct = ReadYaml(yaml_file);
    temp=getfield( YamlStruct,firstItem);
    mat=getfield( temp,'data');
 
    object= cell2mat(mat);
    
    object=(reshape(object,3,[]))';
    tempr=getfield( YamlStruct,secondItem);
    matr=getfield( tempr,'data');
    
   image= cell2mat(matr);
   image=image';
    image=(reshape(image,2,[]))';
    files=YamlStruct.FileList;
end