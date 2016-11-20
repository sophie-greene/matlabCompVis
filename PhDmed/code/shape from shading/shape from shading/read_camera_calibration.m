a = textread('C:/Users/Rafa/Documents/Leeds/calib_data-moving cams/cam1Extrinsic.yml','%s');

translation(1) = str2num(a{18});
translation(2) = str2num(a{19});
translation(3) = str2num(a{20});

rotation(1,1)  = str2num(a{32});
rotation(1,2)  = str2num(a{33});
rotation(1,3)  = str2num(a{34});
rotation(2,1)  = str2num(a{35});
rotation(2,2)  = str2num(a{36});
rotation(2,3)  = str2num(a{37});
rotation(3,1)  = str2num(a{38});
rotation(3,2)  = str2num(a{39});
rotation(3,3)  = str2num(a{40});