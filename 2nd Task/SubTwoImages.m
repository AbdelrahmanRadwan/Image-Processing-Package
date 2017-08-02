function result = SubTwoImages(firstImage, secondImage)
    resultSize = size(firstImage);
    tempImage = double(imresize(secondImage, [resultSize(1), resultSize(2)]));
    result = double(firstImage) - tempImage;
    result = uint8(Contrast(result, 0, 255));
end