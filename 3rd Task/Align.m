function [AlignedImage, Corners] = Align(InputImage, DW, DH)
    
    corners = ones(4, 2);
    Corners = [0, 0; DW - 1, 0; 0, DH - 1; DW - 1, DH - 1];
    [H, W, numberOfChannels] = size(InputImage);
    
    for y = 1:H
        for x = 1:W
            Color = [InputImage(y, x, 1), InputImage(y, x, 2), InputImage(y, x, 3)];
            if ([205, 0, 0] <= Color & Color <= [255, 50, 50])
                corners(1, :) = [x, y];
            elseif ([0, 205, 0] <= Color & Color <= [50, 255, 50])
                corners(2, :) = [x, y];
            elseif ([0, 0, 205] <= Color & Color <= [50, 50, 255])
                corners(3, :) = [x, y];
            elseif ([205, 205, 0] <= Color & Color <= [255, 255, 50])
                corners(4, :) = [x, y];
            end
        end
    end
    
    transformation = fitgeotrans(corners, Corners, 'affine');
    AlignedImage = imwarp(InputImage, transformation);
    Corners = transformPointsForward(transformation, Corners);
    disp(Corners);
    
end
