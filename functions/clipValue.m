function out = clipValue(in,valMin, valMax)
% check if value is valid
out=in;
for i = 1  : size(in)
	if in(i) < valMin
		out(i) = valMin;
	elseif in(i) > valMax
		out(i) = valMax;
	end
end