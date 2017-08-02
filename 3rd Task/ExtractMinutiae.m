function [Endpoints, Bifurcations] = ExtractMinutiae(InputImage)
    
    [H, W] = size(InputImage);
    InputImage = ~imbinarize(InputImage);
    BW = bwmorph(InputImage, 'thin', inf);
    Endpoints = [1; 1];
    Bifurcations = [1; 1];
    pic = ones(H, W, 3);
    
    for y = 1:H
        for x = 1:W
            
            Color = BW(y, x);
            if Color == 1
                numberOfBlackNeighbors = 0;
                for j = -1:1
                    if (1 <= y + j) && (y + j <= H)
                        for i = -1:1
                            if (i == 0 && j == 0)
                                continue;
                            elseif (1 <= x + i) && (x + i <= W)
                                currentNeighborColor = BW(y + j, x + i);
                                if currentNeighborColor == 1
                                    numberOfBlackNeighbors = numberOfBlackNeighbors + 1;
                                end
                            end
                        end
                    end
                end
                if (numberOfBlackNeighbors == 1)
                    Endpoints = [Endpoints, [y; x]];
                    pic(y, x, :) = [255, 0, 0];
                elseif (numberOfBlackNeighbors == 3)
                    Bifurcations = [Bifurcations, [y; x]];
                    pic(y, x, :) = [0, 0, 255];
                else
                    pic(y, x, :) = ~(InputImage(y, x));
                end
            end
            
        end
    end
    
    [T, N, num] = size(Endpoints);
    Endpoints = Endpoints(:, 2:N, :);
    
    [T, N, num] = size(Bifurcations);
    Bifurcations = Bifurcations(:, 2:N, :);
    
    imshow(pic);
end