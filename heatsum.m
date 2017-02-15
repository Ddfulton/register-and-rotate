% This function generates the heat sum of both GFP and RFP and puts it into
% a final matrix. It does not incorporate any z functionality, with the
% exception of calculating the spindle lengths in 3D.

% Because the RFPs are almost always either in the same plane or one plane
% apart, for each set of four coordinates I only add one slice to the RFP
% sum, chosen arbitrarily.

% The pictures live in data/<date>/GFP_<n>.tif and the coordinate datasets
% live in data/<date>/<n>.mat. This is made clear at the beginning of the
% outer loop.

Rsum = zeros(150, 150);
Gsum = zeros(150, 150);
totalPoints = 0;
spindleLengths = [];
threeDSpindleLengths = [];

for j = 1
    GFPFile = strcat('data/12072016/GFP_00', int2str(j), '.tif');
    RFPFile = strcat('data/12072016/RFP_00', int2str(j), '.tif');

    coords = strcat('data/12072016/00', int2str(j), '.mat');
    load(coords);
    coords = data_cell;

    dataLength = size(data_cell, 1) -1;

    totalPoints = totalPoints + dataLength;

    for i=1:dataLength
        
        gfp1 = coords{i+1, 1}(1:3); % this gives [cols, rows, z] for whatever reason
        gfp2 = coords{i+1, 3}(1:3);
        rfp1 = coords{i+1, 5}(1:3);
        rfp2 = coords{i+1, 6}(1:3);


        zRFP1 = rfp1(3);
        zRFP2 = rfp2(3);
        zGFP1 = gfp1(3);
        zGFP2 = gfp1(3);
        
        % Decide which RFP is left
        if rfp1(1) < rfp2(1) % If the first RFP is further left
            lRFP = rfp1;
            rRFP = rfp2;
        else
            lRFP = rfp2;
            rRFP = rfp1;
        end

        zRFP1pix = (mod(zRFP1-1, 7) + 1)*300/64;

        padding = 30;
        RFP = normalizeSlice(getSlice(RFPFile, zRFP1, padding));
        GFP = normalizeSlice(getSlice(GFPFile, zRFP1, padding)); 

        

        rotation = rotationValue(lRFP, rRFP);

        lRFP(1:2) = lRFP(1:2) + padding;
        rRFP(1:2) = rRFP(1:2) + padding;
        
        
        spindle_length = sqrt((lRFP(1) - rRFP(1))^2 + (lRFP(2) - rRFP(2))^2);
        spindleLengths = [spindleLengths, spindle_length];

        zDistance = abs(mod(zRFP1, 7) - mod(zRFP2, 7))*300/64;

        threeDSpindle = sqrt(sqrt((lRFP(1) - rRFP(1))^2 + (lRFP(2) - rRFP(2))^2 + (zDistance)^2));
        threeDSpindleLengths = [threeDSpindleLengths, threeDSpindle];

        % Note that after rotating only lRFP is in the right place
        RFP = rotateAround(RFP, lRFP(2), lRFP(1), rotation);
        GFP = rotateAround(GFP, lRFP(2), lRFP(1), rotation);

        % Crop around lRFP and rRFP. Note that the coords values are no longer
        % meaningful after the crop
        RFP = cropImage(RFP, lRFP, rRFP, spindle_length);
        GFP = cropImage(GFP, lRFP, rRFP, spindle_length);

        RFP = padToSize(RFP, 150);
        GFP = padToSize(GFP, 150);
        
        
        imshow(Rsum, []);
        Rsum = Rsum + RFP(:, :, 1);
        Gsum = Gsum + GFP(:, :, 1);

    end
end

imshow(Rsum, []);
figure, imshow(Gsum, []);