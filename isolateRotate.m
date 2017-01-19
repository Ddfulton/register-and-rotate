 
function out = isolateRotate(filename, fp1, fp2, zSlice, padding)
%% 
% Takes a file, the coordinates of two fluorescent protein dots, a z-slice.
% Crops the image to a smaller size and places the labelled proteins on
% opposite sides of the image.

slice = normalizeSlice(getSlice(filename, zSlice, padding));

fp1 = fp1 + padding;
fp2 = fp2 + padding;

%% Add markers
if strcmp(filename(1), 'R')
   color = {'red'};
else
    color = {'green'};
end

slice = insertMarker(slice, [fp1(1), fp1(2); fp2(1), fp2(2)], 'color', color);

%% Crop the image
rows = [fp1(2) fp2(2)];
cols = [fp1(1) fp2(1)];

newSmallestRow = min(rows) - 30;
newBiggestRow = max(rows) + 30 - newSmallestRow;
slice(1:newSmallestRow, :, :) = []; % Chop off top
slice(newBiggestRow:end, :, :) = []; % Chop off bottom

newSmallestColumn = min(cols) - 30;
newBiggestColumn = max(cols) + 30 - newSmallestColumn;
slice(:, 1:newSmallestColumn, :) = []; % Chop off left
slice(:, newBiggestColumn:end, :) = []; % Chop off right


%% Rotate based on trigonometry to put both FPs on x-axis
x = fp1(1) - fp2(1);
y = fp1(2) - fp2(2);

rotationDegrees = atan(y/x) * 180 / pi;

out = imrotate(slice, rotationDegrees);

end