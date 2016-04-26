%Blank Slate
clear
clc
close all

%Initial values
characterStats = {100, 1, 0, 6, 60, 'Exo-Suit', 0, 'Laser Sword', 0};
continueGame = true;
firstCycle = false;
loadingSave = 'n';
mapLevel = 1;
[~, ~, enemyData] = xlsread('Data/Enemies.xls');
[~, ~, armorTypes] = xlsread('Data/Armor.xls');
[~, ~, weaponTypes] = xlsread('Data/Weapons.xls');
[background1_1, background1_2] = audioread('Music/Quazar - Hybrid Song.mp3');
[background2_1, background2_2] = audioread('Music/Secretly Wishing - Schism Tracker.mp3');
[background3_1, background3_2] = audioread('Music/Skaven - War in the Middle Earth - Remix.mp3');
background1 = audioplayer(background1_1, background1_2);
background2 = audioplayer(background2_1, background2_2);
background3 = audioplayer(background3_1, background3_2);

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
    
    %Play music
    trackSelection = randi(3);
    if trackSelection == 1
        play(background1)
        currentAudio = background1;
    elseif trackSelection == 2
        play(background2)
        currentAudio = background2;
    else
        play(background3)
        currentAudio = background3;
    end
    
    %Print intro
    warning('off', 'MATLAB:printf:BadEscapeSequenceInFormat')
    fprintf('The world has been taken over by Space Communists.\n')
    fprintf('The freedom fighters are rising up under the leadership of John "The American" Smith,\n')
    fprintf('who has joined the movement to fight against the space tyrants.\n')
    fprintf('After years of rebellion, they have discovered the secret location of the Communist Gulag.\n')
    fprintf('John Smith will now enter the depths of the Gulag to commit...\n')
    fprintf(' _________     _______  _____            _   _ _____ _____ _____ _____  ______ \n')
    fprintf('|__   __\\ \\   / /  __ \\|  __ \\     /\\   | \\ | |_   _/ ____|_   _|  __ \\|  ____|\n')
    fprintf('   | |   \\ \\_/ /| |__) | |__) |   /  \\  |  \\| | | || |      | | | |  | | |__   \n')
    fprintf('   | |    \\   / |  _  /|  _  /   / /\\ \\ | . ` | | || |      | | | |  | |  __|  \n')
    fprintf('   | |     | |  | | \\ \\| | \\ \\  / ____ \\| |\\  |_| || |____ _| |_| |__| | |____ \n')
    fprintf('   |_|     |_|  |_|  \\_\\_|  \\_\\/_/    \\_\\_| \\_|_____\\_____|_____|_____/|______|\n\n')
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
        fprintf('Floor %d\n\n', mapLevel)
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
            [Map, characterStats, mapLevel] = move(Map, 'up', characterStats, mapLevel, enemyData, weaponTypes, armorTypes, currentAudio);

        %Move down
        case 'down'
            input('Moving Down...')
            [Map, characterStats, mapLevel] = move(Map, 'down', characterStats, mapLevel, enemyData, weaponTypes, armorTypes, currentAudio);

        %Move left
        case 'left'
            input('Moving Left...')
            [Map, characterStats, mapLevel] = move(Map, 'left', characterStats, mapLevel, enemyData, weaponTypes, armorTypes, currentAudio);

        %Move right
        case 'right'
            input('Moving Right...')
            [Map, characterStats, mapLevel] = move(Map, 'right', characterStats, mapLevel, enemyData, weaponTypes, armorTypes, currentAudio);

        %List player characteristics    
        case 'stats'
            fprintf('Level %d:\n\tExperience: %d\n\tHealth Points: %d\n\tAttack Power: %d\n\tBase Accuracy: %d\n\tArmor: %s (%d)\n\tWeapon: %s (+%d)\n', characterStats{2}, characterStats{3}, characterStats{1}, characterStats{4} + characterStats{9}, characterStats{5}, characterStats{6}, characterStats{7}, characterStats{8}, characterStats{9})
            input('Press Enter to continue.')

        %{
        Save the game
        case 'save'
            input('Saving...')
        %}

        %They cannot of into spell
        otherwise
            fprintf('Make sure to type your action correctly.\n')
            input('Press Enter to continue.', 's')            
    end    
    
    %Endgame if player hp is low
    if characterStats{1} < 0
        clc
        fprintf('You have died!\n')
        fprintf('Rest in pieces.\n')
        continueGame = false;
        input('Press Enter to continue.\n')
    end
    
    %Test for level up
    if characterStats{3} >= 100 * characterStats{2}
        
        %Get new character stats
        characterStats{3} = characterStats{3} - (100 * characterStats{2});
        characterStats{2} = characterStats{2} + 1;
        characterStats{1} = characterStats{1} + 20;
        characterStats{4} = characterStats{4} + 2;
        characterStats{5} = characterStats{5} + 5;
    end
    
    %Test to see if music has stopped and if it has, start a new song
    if isplaying(background1) == 0 && isplaying(background2) == 0 && isplaying(background3) == 0
        trackSelection = randi(3);
        if trackSelection == 1
            play(background1)
            currentAudio = background1;
        elseif trackSelection == 2
            play(background2)
            currentAudio = background2;
        else
            play(background3)
            currentAudio = background3;
        end
    end
        
end