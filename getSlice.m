function out = getSlice(filename, n, padding)

% This function returns the nth slice of a tiff images as a double
% array. Pads the image for viewing pleasure and in case a FP is right on
% the edge.

info = imfinfo(filename);

num_images = numel(info);

imSize = [info(1).Height info(1).Width n];

images = zeros(imSize);


slice = mat2gray(imread(filename, n, 'Info', info)); 

out = padarray(slice, [padding, padding]);

clear filename;
clear imSize;
clear info;
clear num_images;
clear zSlices;
clear i;

end