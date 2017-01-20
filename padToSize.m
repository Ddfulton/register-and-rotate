function out = padToSize(I, pad)
    % Max size is 113
    % Goal: 150 x 150
    % Add to the ends
    rows = size(I, 1);
    cols = size(I, 2);
    z = size(I, 3);
    extraRows = pad - rows;
    extraCols = pad - cols;
    
    rowAddition = zeros(extraRows, cols, z);
    colAddition = zeros(extraRows + rows, extraCols, z);
    
    I = [I; rowAddition];
    I = [I colAddition];
    
    out = I;
end