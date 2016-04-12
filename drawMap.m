function drawMap(Map,HP)
    %Print character info, and load up the map
    clc
    fprintf('HP: %0.0d\n', HP)
    for i = 1:10
        for I = 1:10
            if I == 10
                fprintf('%s\n', Map{i,I})
            else
                fprintf('%s ', Map{i,I})
            end
        end
    end
end