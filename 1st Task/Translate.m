function result = Translate(image, Xoffset)

% Get image dimnsions
[H, W, L] = size(image) ;

% Create new buffer
result = uint8(zeros(H, W, L));

% Apply the translation (pixel by pixel)
for	y=1:H
	for x=1:W
		newX = x + Xoffset ;
		if (newX > W || newX < 1)
      if (newX == 0)
        newX = W;
      else   
			  newX = mod(newX, W);
      end  
		end 
		result(y, newX, :) = image(y, x, :);
	end
end
end