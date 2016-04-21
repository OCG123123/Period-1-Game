function [map] = generateMap()

%Get map dimensions 7x7 to 24x24 & pre-allocate cell
mapRows = randi(17) + 7;
mapColumns = randi(17) + 7;
map = cell(mapRows, mapColumns);

%Generate map
for mapRow = 1:mapRows
    for mapColumn = 1:mapColumns
        
        %Draw walls & exit
        if mapRow == 1 || mapRow == mapRows
            map{mapRow, mapColumn} = 'x';
        elseif mapColumn == mapColumns && mapRow == mapRows - 1
            map{mapRow, mapColumn} = 'd';
        elseif mapColumn == 1 || mapColumn == mapColumns
            map{mapRow, mapColumn} = 'x';
            
        %Draw interior with 1/200 chance of treasure chest and ~1/50 chance of health potion    
        else
            if randi(200) == 200
                map{mapRow, mapColumn} = 't';
            elseif randi(50) == 50
                map{mapRow, mapColumn} = 'p';
            else
                map{mapRow, mapColumn} = 'o';
            end
        end
    end
end

%Set character position
map{2, 2} = 'C';
end