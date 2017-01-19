z = getSlice('RFP_001.tif', 11);

figure, imshow(z);

z(:, 1:200) = [];

figure, imshow(z);