 function out = isolateRotate(filename, fp1, fp2, zSlice, padding, rotationDegrees)
%% isolateRotate
% Takes a file, the coordinates of two fluorescent protein dots, a z-slice.
% Crops the image to a smaller size and places the labelled proteins on
% opposite sides of the image.

% Crop the GFP based on the RFP crop
% RFP returns the crop information and the rotation information
%% RFP or GFP?
if filename(1) == 'R'
    RFP = 1;
else
    RFP = 0;
end

%% Fetch slice
slice = normalizeSlice(getSlice(filename, zSlice, padding));

fp1 = fp1 + padding;
fp2 = fp2 + padding;

%% Crop the image
%
rows = [fp1(2) fp2(2)];
cols = [fp1(1) fp2(1)];

slice = cropImage(slice, rows, cols);

% spindleLength = sqrt( (fp2(1) - fp1(1))^2 + (fp2(2) - fp2(1))^2 );

%% Add markers
if RFP
   color = {'red'};
else
   color = {'green'};
end

% Offset the original points based on the crop
[newfp1 newfp2] = offsetImage(fp1, fp2, rows, cols);

slice = insertMarker(slice, [newfp1; newfp2], 'color', color);

%% Rotate based on trigonometry to put both FPs on x-axis
rotated = imrotate(slice, rotationDegrees);

out = {rotated, newfp1, newfp2};

% Must crop again to ensure first RFP is in the same place each time

end