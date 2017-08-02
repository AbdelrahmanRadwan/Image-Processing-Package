function D = MatchFingers(F1, F2, TD, TM)
    
    resultSize = size(F1);
    F2 = imresize(F2, [resultSize(1), resultSize(2)]);
    
    [firstEndPoints, firstBifurcations] = ExtractMinutiae(F1);
    [secondEndPoints, secondBifurcations] = ExtractMinutiae(F2);
    
    [T, numOfPts] = size(secondEndPoints);
    secondEndPoints = [secondEndPoints; zeros(1, numOfPts)];
    ptCloud = pointCloud(secondEndPoints);
    
    [T, numOfPts] = size(firstEndPoints);
    
    numberOfMatches = 0;
    
    for i = 1:numOfPts 
        currentCoor = [firstEndPoints(:, i); 0];
        [nearestPoint, dist] = findNearestNeighbors(ptCloud, currentCoor, 1);
        if dist <= TD
            numberOfMatches = numberOfMatches + 1;
            %if ()
        end
    end
    
end