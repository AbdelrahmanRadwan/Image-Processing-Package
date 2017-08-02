function result = GeometricLinearTransform(image , transformation)
  
  [hight, width, numberOfChannels] = size(image);
  
  newTopLeftCorner = transformation * [0; 0; 1];
  newTopRightCorner = transformation * [width - 1; 0; 1];
  newBottomLeftCorner = transformation * [0; hight - 1; 1];
  newBottomRightCorner = transformation * [width - 1; hight - 1; 1];
  
  cornersMatrix = int16([newTopLeftCorner, newTopRightCorner, newBottomLeftCorner, newBottomRightCorner]);
  minValues = min(cornersMatrix, [], 2);
  cornersMatrix = (cornersMatrix - [minValues, minValues, minValues, minValues]);
  
  maxValues = max(cornersMatrix, [], 2);
  newWidth = maxValues(1) + 1;
  newHight = maxValues(2) + 1;
  
  result = uint8(zeros(newHight, newWidth, numberOfChannels));
  
  translationMatrix = [1.0, 0.0, double(-minValues(1)); 0.0, 1.0, double(-minValues(2)); 0.0, 0.0, 1.0];
  
  transformation = translationMatrix * transformation;
  
  inverseTransformation = transformation^-1;
  
  for y = 1:newHight
    for x = 1:newWidth
      transforormedPosition = [x - 1; y - 1; 1];
      oldPosition = int16(inverseTransformation * double(transforormedPosition));
      oldRow = oldPosition(2) + 1;
      oldCol = oldPosition(1) + 1;
      if ((0 < oldRow) && (oldRow < hight + 1)) && ((0 < oldCol) && (oldCol < width + 1))
        result(y, x, :) = image(oldRow, oldCol, :);
      end
    end  
  end
  
end