function result = Warp(image, Pts1, Pts2)
    Pts1(3, :) = 1;
    Pts2(3, :) = 1;
    transformation = (Pts2 * Pts1') * ((Pts1 * Pts1')^-1);
    result = GeometricLinearTransform(image, transformation);
end