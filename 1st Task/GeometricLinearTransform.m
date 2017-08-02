function result = GeometricLinearTransform(image , transformation)
  
  [hight, width, numberOfChannels] = size(image);
  
  newTopLeftCorner = transformation * [0; 0];
  newTopRightCorner = transformation * [width - 1; 0];
  newBottomLeftCorner = transformation * [0; hight - 1];
  newBottomRightCorner = transformation * [width - 1; hight - 1];
  
  cornersMatrix = int16([newTopLeftCorner, newTopRightCorner, newBottomLeftCorner, newBottomRightCorner]);
  minValues = min(cornersMatrix, [], 2);
  cornersMatrix = (cornersMatrix - [minValues, minValues, minValues, minValues]);
  
  maxValues = max(cornersMatrix, [], 2);
  newWidth = maxValues(1) + 1;
  newHight = maxValues(2) + 1;
  
  result = uint8(zeros(newHight, newWidth, numberOfChannels));
  
  for y = 1:hight
    for x = 1:width
      position = [x - 1; y - 1];
      newPosition = int16(transformation * position) - minValues;
      newRow = newPosition(2) + 1;
      newCol = newPosition(1) + 1;
      for i = 1:numberOfChannels
         result(newRow, newCol, i) = image(y, x, i);
      end    
    end  
  end
  
end