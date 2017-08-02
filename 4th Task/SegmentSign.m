function [SegmentedSign, SignShape] = SegmentSign(InputImage)
    SmoothGrayImage = imgaussfilt(InputImage(:, :, 1), 2);
    imshow(SmoothGrayImage);
    maxRad = uint16(min(size(SmoothGrayImage)) / 2);
    for i = maxRad:-100:85
        range = [(i - 50), (i + 50)];
        [centers, radii] = imfindcircles(SmoothGrayImage, range, 'ObjectPolarity', 'bright', 'Sensitivity', 0.95);
        if (size(radii) ~= 0)
            break;
        end
    end
    rad = radii(1, 1);
    %imcrop(InputImage, [centers(1, 1) - rad, centers(1, 2) - rad, rad * 2, rad * 2]);
    hold on
    viscircles(centers, radii,'EdgeColor','b');
end