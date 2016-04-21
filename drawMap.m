function drawMap(Map, characterStats)

    %Print character info
    clc
    fprintf('Level %d:\n\t%d experience\n\t%d health\n\n', characterStats{2}, characterStats{3}, characterStats{1})
    
    %Pregenerate map dimensions & print map
    mapSize = size(Map);
    for i = 1:mapSize(1)
        for I = 1:mapSize(2)
            if I == mapSize(2)
                fprintf('%s\n', Map{i,I})
            else
                fprintf('%s ', Map{i,I})
            end
        end
    end
end