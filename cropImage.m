function out = cropImage(slice, rows, cols)
    newSmallestRow = min(rows) - 30;
    newBiggestRow = max(rows) + 30 - newSmallestRow;
    slice(1:newSmallestRow, :, :) = []; % Chop off top newSmallestRow rows
    slice(newBiggestRow:end, :, :) = []; % Chop off bottom newBiggestRow rows

    newSmallestColumn = min(cols) - 30;
    newBiggestColumn = max(cols) + 30 - newSmallestColumn;
    slice(:, 1:newSmallestColumn, :) = []; % Chop off left
    slice(:, newBiggestColumn:end, :) = []; % Chop off right
    
    out = slice;
end