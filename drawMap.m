function drawMap(Map,HP)
    %Print character info, and load up the map
    clc
    fprintf('HP: %0.0d\n', HP)
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