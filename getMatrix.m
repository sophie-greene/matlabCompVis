function[matrix]=getMatrix(filename,item)

    addpath(genpath('D:\Dropbox\YAMLMatlab_0.4.3\')); 
    yaml_file = filename;
    YamlStruct = ReadYaml(yaml_file);
    temp=getfield( YamlStruct,item);
    mat=getfield( temp,'data');
    col= getfield( temp,'cols');
    row= getfield( temp,'rows');
    matrix= cell2mat(mat);
    matrix=(reshape(matrix,row,col))';
    
end