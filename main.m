

% Hard coded for right now
coords = '12062016_001.mat';
load(coords);
coords = data_cell;

% Image number in the set. This will be placed in a loop later.
num = '001';
GFP = strcat('GFP_', num, '.tif');
RFP = strcat('RFP_', num, '.tif');

for i = 1:10
    % Need two points and z slice to produce the isolated/rotated image
    % [x, y, z, intensity]
    
    gfp1 = coords{i+1, 1}(1:2);
    gfp2 = coords{i+1, 3}(1:2);
    rfp1 = coords{i+1, 5}(1:2);
    rfp2 = coords{i+1, 6}(1:2);
    zRFP = coords{i+1, 6}(3); 
    zGFP = coords{i+1, 1}(3);

    R = isolateRotate(RFP, rfp1, rfp2, zRFP, 30);
    G = isolateRotate(GFP, gfp1, gfp2, zGFP, 30);
    
    figure, imshow(R);
    figure, imshow(G);

end

out = 1;

