function out = rotationValue(fp1, fp2)
    x = fp1(1) - fp2(1);
    y = fp1(2) - fp2(2);
    
    out = atan(y/x) * 180 / pi;
end