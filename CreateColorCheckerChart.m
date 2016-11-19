% Script to make (synthesize) a perfect X-Rite Color Checker Chart
% from the X-Rite supplied sRGB values.
% (This chart has been known in the past as the Gretag Macbeth ColorChecker Chart,
% and the Munsell ColorChecker Chart.)

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;

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

sRGB_Values = uint32([...
115,82,68
194,150,130
98,122,157
87,108,67
133,128,177
103,189,170
214,126,44
80,91,166
193,90,99
94,60,108
157,188,64
224,163,46
56,61,150
70,148,73
175,54,60
231,199,31
187,86,149
8,133,161
243,243,242
200,200,200
160,160,160
122,122,121
85,85,85
52,52,52]);

% Ask user for the width of the image in pixels and
% ask user for the grid width in pixels.
% Grid width is pretty close to 2.02% on an actual, real x-rite Color Checker chart.
defaultValue = {'1280', '26'};
titleBar = 'Enter an integer value';
userPrompt = {'Enter the width of the image in pixels', 'Enter the width of the grid lines in pixels'};
caUserInput = inputdlg(userPrompt, titleBar, 1, defaultValue);
if isempty(caUserInput),return,end; % Bail out if they clicked Cancel.
imageWidth = round(str2num(cell2mat(caUserInput(1))));
% Check for a valid integer.
if isnan(imageWidth)
    % They didn't enter a number.  
    % They clicked Cancel, or entered a character, symbols, or something else not allowed.
    imageWidth = defaultValue;
    message = sprintf('I said it had to be an integer.\nI will use %d and continue.', defaultValue);
    uiwait(warndlg(message));
end

gridWidth = round(str2num(cell2mat(caUserInput(2))));
% Check for a valid integer.
if isnan(gridWidth)
	% They didn't enter a number.
	% They clicked Cancel, or entered a character, symbols, or something else not allowed.
	gridWidth = defaultValue;
	message = sprintf('I said it had to be an integer.\nI will use %d and continue.', defaultValue);
	uiwait(warndlg(message));
end
% Chip width is pretty close to 14.0% on an actual, real x-rite Color Checker chart.
chipWidth = int32((imageWidth - 7 * gridWidth)/ 6);
% Image height is 4 chip widths + 5 grid widths.
imageHeight = 4 * (chipWidth + gridWidth) + gridWidth;

% See if they want labels on the image.
promptMessage = sprintf('Do you want to display color chip names and RGB values over the image?');
reply = questdlg(promptMessage, 'Display labels?', 'Yes', 'No', 'Yes');
if strcmpi(reply, 'Yes')
	displayLabels = true;
else
	displayLabels = false;
end

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

% Ask user if they want to save the image.
promptMessage = sprintf('This is the Color Checker Color Rendition Chart\nusing sRGB color values as defined by X-Rite, Inc.\nwhich is the manufacturer.\n\n Do you want to save this image?');
titleBarCaption = 'Done.  Now Save Image?';
button = questdlg(promptMessage, titleBarCaption, 'Yes, Save', 'No, Quit', 'No, Quit');
if strcmp(button, 'No, Quit')
	% User does not want to save, so we're done.  Exit program.
	return;
end

% User wants to save the image.  See if they want the annotation or not.
promptMessage = sprintf('Do you want to save this image with or without the text?');
titleBarCaption = 'Save text annotations?';
button = questdlg(promptMessage, titleBarCaption, 'With Text', 'Without Text', 'With Text');
% Get the name of the file that the user wants to save.
startingFolder = pwd;
defaultFileName = fullfile(startingFolder, 'Color Checker Chart.png');
[baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file');
if baseFileName == 0
	% User clicked the Cancel button.  Exit program.
	return;
end
fullFileName = fullfile(folder, baseFileName);

% Change mouse pointer (cursor) to an hourglass or the "wait" cursor as defined by your operating system.
% QUIRK: use 'watch' and you'll actually get your "wait" cursor, not a watch.
set(gcf, 'Pointer', 'watch');
drawnow;	% Cursor won't change right away unless you do this.

% Send any existing file to the recycle folder so that  we don't completely blow it away.
% Turn file recycling on. Delete a file and move it to the recycle bin or temporary folder:
if exist(fullFileName, 'file')
	recycle on; % Enable delete to send files to the recycle bin instead of making them totally vanish.
	delete(fullFileName); % Do the actual delete (recycle).
end

% Save the image.
if strcmp(button, 'Without Text')
	imwrite(rgbImage, fullFileName);
	message = sprintf('Image has been saved with imwrite() to file:\n\n%s', fullFileName);
else
	% Save with annotations.
	% Check for export_fig
	hasExport_fig = ~isempty(which('export_fig'));
	if hasExport_fig
		% User does have export_fig, so use it.
		% Save just axes, not figure, so we won't have tick marks.
		axis('off');	% Turn off tick marks.
		export_fig(gca, fullFileName); 
		message = sprintf('Image has been saved with export_fig() to file:\n\n%s', fullFileName);
	else
		% User does not have don't have export_fig,
		% so we'll have to try our luck with saveas().
		saveas(gcf, fullFileName);
		message = sprintf('Image has been saved with saveas() to file:\n\n%s', fullFileName);
	end
end
msgbox(message);

% Change mouse pointer (cursor) to an arrow.
set(gcf,'Pointer','arrow');
drawnow;	% Cursor won't change right away unless you do this.