function [newfp1, newfp2] = offsetImage(fp1, fp2, rows, cols)
    newSmallestRow = min(rows) - 30;
    newBiggestRow = max(rows) + 30 - newSmallestRow;
    
    newSmallestColumn = min(cols) - 30;
    newBiggestColumn = max(cols) + 30 - newSmallestColumn;
    
    newfp1 = [0 0];
    newfp1(1) = fp1(1) - newSmallestColumn;
    newfp1(2) = fp1(2) - newSmallestRow;

    newfp2 = [0 0];
    newfp2(1) = fp2(1) - newSmallestColumn;
    newfp2(2) = fp2(2) - newSmallestRow;
    
end