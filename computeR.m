function R = computeR(x,y,z,p,q,I0)
%focal length is given
%albedo assumed 1
% assume 1 light sourse at position l1 TODO:get using Macbeth chart
l1=[10,12,0];
F=1;
R=I0*((p*(z+yq)*(l1(1)+(x*(z/F))))...
-(q(z+(x*p))*(l1(2)-(y*(z/F)))) ...
-((z/F)*(z+(x*p)*(z+(y*q)))));
