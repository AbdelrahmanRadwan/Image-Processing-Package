function result = GetImageChannel(image, channelName)
result = image;
[H W L] = size(image);
if (L == 1)
    return;
end
zeroMatrix = zeros(H, W);
if (strcmp(channelName, 'Red'))
    result(:,:,2) = zeroMatrix;
    result(:,:,3) = zeroMatrix;
elseif (strcmp(channelName, 'Green'))
    result(:,:,1) = zeroMatrix;
    result(:,:,3) = zeroMatrix;
elseif (strcmp(channelName, 'Blue'))
    result(:,:,1) = zeroMatrix;
    result(:,:,2) = zeroMatrix;
end
end