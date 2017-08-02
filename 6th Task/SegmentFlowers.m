function [NumberOfFlowers, NumberOfPetalsPerFlower] = SegmentFlowers(InputImage)
    TempImage = rgb2gray(InputImage);
    filter = fspecial('gaussian', 2);
    TempImage = imfilter(TempImage, filter);
    %imshow(TempImage);
    I = graythresh(TempImage);
    TempImage = im2bw(TempImage, I);
    %figure, imshow(TempImage);
    TempImage = bwmorph(TempImage, 'open', inf);
    %figure, imshow(TempImage);
    L = bwlabel(TempImage, 8);
    h = histogram(L);
    his = h.Values;
    edges = h.BinEdges;
    
    bins = zeros(size(his));
    
    for i = 1:size(his')
        bins(i) = (edges(i) + edges(i + 1)) / 2;
    end
    
    his(1) = [];
    bins(1) = [];
    freqMatrix = [his; bins];
    freqMatrix = sortrows(freqMatrix');
    freqMatrix = fliplr(freqMatrix');
    
    maxSize = freqMatrix(1, 1);
    NumberOfFlowers = 0;
    for i = 1:size(his')
        if freqMatrix(1, i) < maxSize / 2
            [r, c] = find(L == freqMatrix(2, i));
            TempImage(r, c) = 0;
            continue;
        end
        NumberOfFlowers = NumberOfFlowers + 1;
    end
    
    %figure, imshow(TempImage);
    BW = TempImage;
    [H, W] = size(TempImage);
    flower = logical(zeros(size(TempImage)));
    [r, c] = find(L == freqMatrix(2, 1));
    flower(r, c) = TempImage(r, c);
    info = regionprops(flower, 'area');
    imshow(flower);
    SE = strel('square', round(12 * (info.Area^0.5 / 3757^0.5)));
    flower = imerode(flower, SE);
    flower = bwmorph(flower, 'open', inf);
    
    imshow(flower);
    
    L = bwlabel(flower, 8);
    [his, edges] = histcounts(L);
    his(1) = [];
    NumberOfPetalsPerFlower = size(his');
    NumberOfPetalsPerFlower = NumberOfPetalsPerFlower(1);
    
    %figure, imshow(TempImage);
end