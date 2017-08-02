function result = Brightness(image, channel, offset)
  result = image;
  switch(channel)
  case 'R'
    result(:, :, 1) = image(:, :, 1) + offset;
    return;
  case 'G'
    result(:, :, 2) = image(:, :, 2) + offset;
    return;
   case 'B'
    result(:, :, 3) = image(:, :, 3) + offset;
    return;
  end 
end