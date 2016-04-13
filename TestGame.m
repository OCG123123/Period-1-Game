%Blank Slate
clear
clc
close all

%Initial values
HP = 100;
continueGame = true;
firstCycle = false;

%Ask if loading save
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
    
    %Print character info, and load up the map
    [mapLevel, Map, ignore1] = xlsread('Levels\Level1.xls');
    drawMap(Map, HP)
end

%Run the game
while continueGame
    
    %Draws starter map unless loading save.
    clc
    if firstCycle
    else
        drawMap(Map, HP)
    end
    
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
            fprintf('Save\n')
            input('Press Enter to continue.', 's')

        %Move up
        case 'up'
            input('Moving Up...\n')
            [Map, HP] = move(Map, 'up', HP);

        %Move down
        case 'down'
            input('Moving Down...\n')
            [Map, HP] = move(Map, 'down', HP);

        %Move left
        case 'left'
            input('Moving Left...\n')
            [Map, HP] = move(Map, 'left', HP);

        %Move right
        case 'right'
            input('Moving Right...\n')
            [Map, HP] = move(Map, 'right', HP);

        %Save the game
        case 'save'
            input('Saving...\n')

        %They cannot of into spell
        otherwise
            fprintf('You''ve borked your language!\n')            
    end
end