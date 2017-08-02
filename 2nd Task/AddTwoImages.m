function result = AddTwoImages(firstImage, secondImage, fraction)
    result = zeros(size(firstImage));
    if 0 <= fraction && fraction <= 1
        resultSize = size(firstImage);
        tempImage = imresize(secondImage, [resultSize(1), resultSize(2)]);
        result = uint8((firstImage .* fraction) + (tempImage .* (1 - fraction)));
    end
end