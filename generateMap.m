function [map] = generateMap()

%Get map dimensions
mapX = randi(29) + 3;
mapY = randi(29) + 3;
map = cell(mapY, mapX);

%Generate map
for i = 1:mapY
    for I = 1:mapX
        
        %Draw walls & exit
        if i == 1 || i == mapY
            map{I, i} = 'x';
        elseif I == 1 || I == mapX
            if I == mapX && i == mapY - 1
                map{I, i} = 'd';
            else
                map{I, i} = 'x';
            end
            
        %Draw interior with a 1/20 chance of health potion    
        else
            if randi(20) < 20
                map{I, i} = 'o';
            else
                map{I, i} = 'p';
            end
        end
    end
end

%Set character position
map{2, 2} = 'C';