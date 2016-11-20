function[matrix]=getfMatrix(filename,item)

    addpath(genpath('D:\Dropbox\YAMLMatlab_0.4.3\')); 
    yaml_file = filename;
    YamlStruct = ReadYaml(yaml_file);
    temp=getfield( YamlStruct,item);
    mat=getfield( temp,'data');
    col= getfield( temp,'cols');
    row= getfield( temp,'rows');
  for i=1:length(mat)
    matrix(i)= mat{i};
  end
    matrix=(reshape(matrix,row,col))';
    
end