function object=getStringsVector(filename)

    addpath(genpath('/usr/not-backed-up/YAMLMatlab_0.4.3')); 
    yaml_file =filename;
    YamlStruct = ReadYaml(yaml_file)
    object=YamlStruct.ListFile
 
end