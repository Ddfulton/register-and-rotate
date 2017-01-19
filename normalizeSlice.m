function out = normalizeSlice(single_slice);

% This function returns a double with intensity values normalized to 0 - 1
% so that they may be easily displayed with imshow

im = single_slice;

% brightest = max(im(:));
darkest = min(im(:));

%Background subtraction
%darkest value will be subtracted from each elemet in im without for loop
im_bg_sub = im - darkest;

%brightest pixel normalization
brightest = max(im_bg_sub(:));
%each element in im_bg_sub will be divided by brightest value without a for
%loop.  the dot in ./ means apply to each element in matrix.  You do not
%need to specify this for addition and subtraction since that is the only
%interpretation in matrix math.
out = im_bg_sub./brightest;

%the rest of code is not necessary, unlike other programming languages
%MATLAB is very slow executing for loops.  You will want to avoid them as
%much as possible, even if you do pre-allocate like you did here.

% rows = size(im, 1);
% cols = size(im, 2);
% 
% newIm = zeros(rows, cols);
% 
% for i = 1:rows
%     for j = 1:cols
%         newIm(i, j) = (im(i, j) - darkest) / (brightest - darkest);
%     end
% end
% 
% out = newIm;
% 
% clear i;
% clear j;
% clear rows;
% clear cols;
% clear brightest;
% clear ans;
% clear im;
% clear images;
% clear first_slice;

end