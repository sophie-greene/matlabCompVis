function[translationVector, rotationMatrix]=getMatrix(filename,firstItem,secondItem)

    addpath(genpath('/usr/not-backed-up/YAMLMatlab_0.4.3')); 
    yaml_file = filename;
    YamlStruct = ReadYaml(yaml_file);
    temp=getfield( YamlStruct,firstItem);
    mat=getfield( temp,'data');
    col= getfield( temp,'cols');
    row= getfield( temp,'rows');
    translationVector= cell2mat(mat);
    translationVector=(reshape(translationVector,row,col))';
    tempr=getfield( YamlStruct,secondItem);
    matr=getfield( tempr,'data');
        colr= getfield( tempr,'cols');
    rowr= getfield( tempr,'rows');
    rotationMatrix= cell2mat(matr);
    rotationMatrix=(reshape(rotationMatrix,rowr,colr))';
end