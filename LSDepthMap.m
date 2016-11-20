function [z] = LSDepthMap(rowIdx, colIdx, matVals, v,objectPixelRow, objectPixelCol,rowIdxF, colIdxF, matValsF, g,dims,weight )


  numPixels = length(v)/2;
  
  rowIdx = rowIdx + 1;
  colIdx = colIdx + 1;
  
  rowIdxF = rowIdxF + 1;
  colIdxF = colIdxF + 1;
  
  linearIdx = sub2ind([2*numPixels,numPixels],rowIdx,colIdx);
  linearIdxF = sub2ind([2*numPixels,numPixels],rowIdxF,colIdxF);
  
  M = sparse(2*numPixels, numPixels);
  F = sparse(2*numPixels, numPixels);
  
  M(linearIdx) = matVals;
  F(linearIdxF) = matValsF;
  
  
% u = 0.0005;
  
    %plot(weight(1));
    

  A = [M;sqrt(weight(1))*F];
  b = [v;sqrt(weight(1))*g];
  tic
  x = A \ b;
  toc;
  %x = x - min(x);

  nrows = dims(1);
  ncols = dims(2);
  objectPixels = [objectPixelRow objectPixelCol];
  tempShape = zeros(nrows, ncols);
  for d = 1:numPixels
      pRow = objectPixels(d, 1);
      pCol = objectPixels(d, 2);
      tempShape(pRow, pCol) = x(d, 1);
  end

  z  = zeros( nrows, ncols);
  for i = 1:nrows
      for j = 1:ncols
          z(i, j) = tempShape(nrows-i+1, j);
      end
  end
 surfl(z); shading interp; colormap gray
   %  axis([0 320 0 320 0 320]);
  
end

