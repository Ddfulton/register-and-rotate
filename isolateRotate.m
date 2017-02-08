function out = isolateRotate(filename, rfp1, rfp2, gfp1, gfp2, zSlice, padding, rotationDegrees)
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

if rfp1(1) < rfp2(1) % If the first RFP is further left
    lRFP = rfp1 + padding;
    rRFP = rfp2 + padding;
else
    lRFP = rfp2 + padding;
    rRFP = rfp1 + padding;
end

%% Crop the image based on RFP coordinates
%
rows = [rfp1(2) rfp2(2)];
cols = [rfp1(1) rfp2(1)];

slice = cropImage(slice, rows, cols);

% spindleLength = sqrt( (fp2(1) - fp1(1))^2 + (fp2(2) - fp2(1))^2 );

%% Add markers
if RFP
   color = {'red'};
else
   color = {'green'};
end

% Offset the original points based on the crop
[newrfp1, newrfp2] = offsetImage(rfp1, rfp2, rows, cols);
[newgfp1, newgfp2] = offsetImage(gfp1, gfp2, rows, cols);
disp(newrfp1);
disp(newrfp2);
disp(newgfp1);
disp(newgfp2);

if RFP
    slice = insertMarker(slice, [newrfp1; newrfp2], 'color', color);
else
    slice = insertMarker(slice, [newgfp1; newgfp2], 'color', color);
end

%% Rotate based on trigonometry to put both FPs on x-axis
% Rotate it around 30, 30
% rotated = imrotate(slice, rotationDegrees);
rotated = rotateAround(slice, 30, 30, rotationDegrees);

out = {rotated, newrfp1, newrfp2};

% Must crop again to ensure first RFP is in the same place each time

end