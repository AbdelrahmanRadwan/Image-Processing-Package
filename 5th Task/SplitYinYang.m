function [YinImage, YangImage] = SplitYinYang(InputImage)
    [H W L] = size(InputImage);
    
    if L == 3
        YinImage = rgb2gray(InputImage);
        YangImage = rgb2gray(InputImage);
    else
        YinImage = (InputImage);
        YangImage = (InputImage);
    end
    
    YinImage = imbinarize(YinImage);
    YangImage = imbinarize(YangImage);
    figure,imshow(YinImage);
    
    SE = strel('square', 5);
    YinImage = imerode(YinImage, SE);
    YinImage = imfill(YinImage, 'holes');
    [L W] = size(YinImage);
    y = round(L/2);
    counter = 1;
    MIN = 10000;
    for x = 1:W
        if(YinImage(y, x) == 0)
            counter = counter + 1;
        else
            if(counter ~= 1)
                MIN = min(MIN, counter);
                counter = 1;
            end
        end
    end
    
    if(counter ~= 1)
        MIN = min(MIN, counter);
    end
    SE = strel('disk', MIN + 2, 0);
    YinImage = imdilate(YinImage, SE);
    YinImage = imerode(YinImage, SE);
    SE = strel('square', 5);
    YinImage = imdilate(YinImage, SE);
    
    SE = strel('square', 2);
    YangImage = imerode(YangImage, SE);
    BW = YangImage;
    BW1 = BW;
    CC = bwconncomp(YangImage);
    numPixels = cellfun(@numel, CC.PixelIdxList);
    maximum = max(numPixels);
    [secBiggest,idx] = max(numPixels < maximum);
    BW(CC.PixelIdxList{idx}) = 0;
    [biggest,idx] = max(numPixels);
    BW1(CC.PixelIdxList{idx}) = 0;
    YangImage = BW & ~BW1;
    YangImage = imdilate(YangImage, SE);
    
    
    figure,imshow(YinImage);
    figure,imshow(YangImage);
end