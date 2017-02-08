function out = cropImage(slice, lRFP, rRFP, spindle)
    % Crops the image around an index of rows, cols
    
    % Keep label on
    slice(1:lRFP(2) - 30, :, :) = [];
    lRFP(2) = 30;
    rRFP(2) = 30;
    
    slice(:, 1:lRFP(1) - 30, :) = [];
    lRFP(1) = 30;
    rRFP(1) = lRFP(1) + spindle;
    
    slice(60:end, :, :) = [];
    
    slice(:, 60+spindle:end, :) = [];
    
%     slice = insertMarker(slice, lRFP, 'color', 'red');
%     slice = insertMarker(slice, rRFP, 'color', 'red');
    
    out = slice;
end