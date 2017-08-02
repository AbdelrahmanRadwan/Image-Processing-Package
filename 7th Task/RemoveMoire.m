function RestoredImage = RemoveMoire(InputImage)
    TempImage = rgb2gray(InputImage);
    figure, imshow(TempImage);
    F = fft2(TempImage);
    Fc = fftshift(F);
    S = log(1 + abs(Fc));
    phi = angle(F);
    f = ifft2(F);
    
    TempImage = TempImage - mean(TempImage(:));
    f = fftshift(fft2(TempImage));
    fabs = abs(f);

    roi = 50; thresh = 10000;
    local_extr = ordfilt2(fabs, roi^2, ones(roi));

    result = (fabs == local_extr) & (fabs > thresh);
    
    [H, W] = size(result);
    [r, c] = find(result);
    for i = 1:length(r)
        if (r(i) - H/2)^2 + (c(i) - W/2)^2 > 400   % periodic noise locates in the position outside the 20-pixel-radius circle
            Fc(r(i) - 10:r(i) + 10, c(i) - 10:c(i) + 10) = 0;  % zero the frequency components
        end
    end
    
    something = log(1 + abs(Fc));
    figure, imshow(something, []);
    test = ifft2(ifftshift(Fc));
    figure, imshow(uint8(test));
    
    %figure, imshow (f, []);
    %figure, imshow (S, []);
end