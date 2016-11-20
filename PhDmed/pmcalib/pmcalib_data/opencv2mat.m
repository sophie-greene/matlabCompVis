function opencv2mat(filename,outfile)
fin = fopen(filename,'r');
fout = fopen(outfile,'w');

while ~feof(fin);
   s = fgetl(fin);
   s = strrep(s, '%YAML:1.0', '');
   s=strrep(s, '!!opencv-matrix', '');
%     s=strrep(s, ' -', '');
%      s=strrep(s, '"p', '''p');
%       s=strrep(s, 'g"', 'g''');
   fprintf(fout,'%s\n',s);
   %disp(s);
end

fclose(fin);
fclose(fout);
end