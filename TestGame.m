%Blank Slate
clear
clc
close all

%Initial values
characterStats = {100, 1, 0, 10, 70, 'Exo-Suit', 0, 'Laser Sword'};
continueGame = true;
firstCycle = false;
loadingSave = 'n';
mapLevel = 1;

%{
Ask if loading save
loadingSave = input('Would you like to load a save (Y/N)? ', 's');

%Clear screen & verify input
if strcmp(loadingSave,'y') || strcmp(loadingSave,'n')
else
    while strcmpi(loadingSave,'y') == 0 && strcmpi(loadingSave,'n') == 0
        clc
        disp('Why no into good?')
        loadingSave = lower(input('Would you like to load a save (Y/N)? ', 's'));
    end
end
%}

%If yes, ask which save  
if strcmp(loadingSave,'y')
    clc
    disp('Loading Save...')
    firstCycle = true;
    
%If no, print out intro,
else
    clc
    fprintf('A long time ago, in a galaxy far, far away. Hitler did nothing wrong.\n')
    input('Press Enter to continue.','s')
    
    %Print character info
    [Map] = generateMap();
end

%Run the game
while continueGame
     
    %Draws starter map
    clc
    %if firstCycle
    %else
        drawMap(Map, characterStats)
    %end
    
    
    %Ask what player wants to do
    playerAction = input('What do you want to do (? for help)? ','s');
    
    %Act based upon what was given
    clc
    switch lower(playerAction)
        
        %Print help
        case '?'
            fprintf('Commands:\n')
            fprintf('Up\n')
            fprintf('Down\n')
            fprintf('Left\n')
            fprintf('Right\n')
            fprintf('Stats\n')
            %fprintf('Save\n')
            input('Press Enter to continue.', 's')

        %Move up
        case 'up'
            input('Moving Up...')
            [Map, characterStats] = move(Map, 'up', characterStats);

        %Move down
        case 'down'
            input('Moving Down...')
            [Map, characterStats] = move(Map, 'down', characterStats);

        %Move left
        case 'left'
            input('Moving Left...')
            [Map, characterStats] = move(Map, 'left', characterStats);

        %Move right
        case 'right'
            input('Moving Right...')
            [Map, characterStats] = move(Map, 'right', characterStats);

        %List player characteristics    
        case 'stats'
            fprintf('Level %d:\n\tExperience: %d\n\tHealth Points: %d\n\tAttack Power: %d\n\tBase Accuracy: %d\n\tArmor: %s (%d)\n\tWeapon: %s\n', characterStats{2}, characterStats{3}, characterStats{1}, characterStats{4}, characterStats{5}, characterStats{6}, characterStats{7}, characterStats{8})
            input('Press Enter to continue.')

        %{
        Save the game
        case 'save'
            input('Saving...')
        %}

        %They cannot of into spell
        otherwise
            fprintf('You''ve borked your language!\n')            
    end
end