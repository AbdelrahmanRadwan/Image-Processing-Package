function result = Gamma(image, gammaValue)
    result = uint8(zeros(size(image)));
    if 0 <= gammaValue && gammaValue <= 5
        result = Contrast(double(image).^gammaValue, 0, 255);
    end
end