% Script to make (synthesize) a perfect X-Rite Color Checker Chart
% from the X-Rite supplied sRGB values.
% (This chart has been known in the past as the Gretag Macbeth ColorChecker Chart,
% and the Munsell ColorChecker Chart.)

% clc;    % Clear the command window.
% close all;  % Close all figures (except those of imtool.)
% clear;  % Erase all existing variables.
% workspace;  % Make sure the workspace panel is showing.
% % format longg;
% % format compact;

chipNames = {
'Dark Skin';
'Light Skin';
'Blue Sky';
'Foliage';
'Blue Flower';
'Bluish Green';
'Orange';
'Purple Red';
'Moderate Red';
'Purple';
'Yellow Green';
'Orange Yellow';
'Blue';
'Green';
'Red';
'Yellow';
'Magenta';
'Cyan';
'White';
'Neutral 8';
'Neutral 65';
'Neutral 5';
'Neutral 35';
'Black'};

sRGB_Values = m;

% Ask user for the width of the image in pixels and
% ask user for the grid width in pixels.
% Grid width is pretty close to 2.02% on an actual, real x-rite Color Checker chart.

    % They didn't enter a number.  
    % They clicked Cancel, or entered a character, symbols, or something else not allowed.
    imageWidth = 1280;


	% They didn't enter a number.
	% They clicked Cancel, or entered a character, symbols, or something else not allowed.
	gridWidth = 26;

% Chip width is pretty close to 14.0% on an actual, real x-rite Color Checker chart.
chipWidth = int32((imageWidth - 7 * gridWidth)/ 6);
% Image height is 4 chip widths + 5 grid widths.
imageHeight = 4 * (chipWidth + gridWidth) + gridWidth;


	displayLabels = true;


cols = (gridWidth + 1) : (chipWidth + gridWidth) : imageWidth;
rows = (gridWidth + 1) : (chipWidth + gridWidth) : imageHeight;
% width = max(cols); % Update this to get it accurate.
rgbImage = zeros(imageHeight, imageWidth, 3, 'uint8');

% Assign the chip colors to the proper locations in the RGB image.
chipNumber = 1;
for row = 1 : 4
	row1 = rows(row);
	row2 = row1 + chipWidth;
	for col = 1 : 6
		col1 = cols(col);
		col2 = col1 + chipWidth;
		% Assign red, green, and blue chips.
		rgbImage(row1:row2, col1:col2, 1) = sRGB_Values(chipNumber, 1);
		rgbImage(row1:row2, col1:col2, 2) = sRGB_Values(chipNumber, 2);
		rgbImage(row1:row2, col1:col2, 3) = sRGB_Values(chipNumber, 3);
		chipNumber = chipNumber + 1;
	end
end
imshow(rgbImage);
axis on;

% Annotate.  Place chip names and RGB values on the chips, if they chose to do so.
fontSize = 12;
if displayLabels
	chipNumber = 1;
	for row = 1 : 4
		row1 = rows(row) + chipWidth/2;
		for col = 1 : 6
			col1 = cols(col) + 3;
			% Place chip name
			chipName = chipNames{chipNumber};
			textLabel = sprintf('%s\nR=%3d\nG=%3d\nB=%3d', chipName, sRGB_Values(chipNumber, 1), sRGB_Values(chipNumber, 2), sRGB_Values(chipNumber, 3));
% 			if chipNumber == 16 || chipNumber == 19 || chipNumber == 20
			if sum(sRGB_Values(chipNumber, :)) > 470
				% Use black text over the yellow, white, and bright gray chips.
				text(double(col1), double(row1), textLabel, 'Color', 'k', 'FontSize', fontSize);
			else
				% Use white text over all the other chips.
				text(double(col1), double(row1), textLabel, 'Color', 'w', 'FontSize', fontSize);
			end
			chipNumber = chipNumber + 1;
		end % of loop over columns.
	end % of loop over rows.
	
	% Size axes (within the figure) so that we can see the bottom axis tick marks.
	% If you don't, all you'll be able to see are the side tick marks.
	set(gca, 'Units', 'Normalized', 'Position', [0.05 0.05 .9 .9]);
	fontSize = 14;
	
	% Display branding information.
	yTextBottom = 15; %double(gridWidth)
	text(gridWidth, yTextBottom, 'Color Checker Chart', 'Color', 'w', 'FontSize', fontSize);
	yTextBottom = double(imageHeight - gridWidth/2);
	text(gridWidth, yTextBottom, 'X-Rite', 'Color', 'w', 'FontSize', fontSize);
end % of "if displayLabels"

% Enlarge window to full screen size.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
drawnow;

