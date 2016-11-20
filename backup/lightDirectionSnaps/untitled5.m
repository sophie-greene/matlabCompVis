I = imread('video2.jpg');

figure; imshow(I)
T = maketform('projective',cam2_rot);
R = makeresampler('cubic','circular');
J = tformarray(I,T,R,[1 2],[2 1],[100 100],[],[]);
figure; imshow(J), imshow(J)