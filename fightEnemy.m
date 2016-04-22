function  characterEndStats = fightEnemy(characterEnterStats, mapLevel, enemyData)

%Clear text & set initial variables
clc
enemyAnalyzed = 0;
enemyTurn = 0;
[background1, background2] = audioread('Music/Skaven-Future Crew - The Alchemist.wav');
[player1, player2] = audioread('Sound Effects/Sword Attack.wav');
[enemy1, enemy2] = audioread('Sound Effects/Prole Attack.wav');
combatPlayer = audioplayer(background1, background2);
playerAttack = audioplayer(player1, player2);
enemyAttack = audioplayer(enemy1, enemy2);
play(combatPlayer);

%Get possible enemy spawns
enemies = size(enemyData);
for enemyRow = 1:enemies(1)
    for enemyColumn = 1:enemies(2)
        if enemyData{enemyRow, 5} <= mapLevel && enemyData{enemyRow, 6} >= mapLevel
            potentialEnemies{enemyRow, enemyColumn} = enemyData{enemyRow, enemyColumn}; %#ok<AGROW>
        end
    end
end

%Select enemy to fight
randomEnemy = size(potentialEnemies);
enemy = randi(randomEnemy(1));

%Isolate the enemy's stats
enemyStats = cell(1,7);
for enemyDetails = 1:randomEnemy(2)
    enemyStats{1, enemyDetails} = potentialEnemies{enemy, enemyDetails};
end

%Print out the fight screen while hp is greater than 0
while enemyStats{2} > 0 && characterEnterStats{1} > 0
    
    %Print out your data
    fprintf('Your Stats:\n\t%d HP\n\t%d Accuracy\n\t%s Armor (%d)\n\t%d AP (+%d from %s)\n\n', characterEnterStats{1}, characterEnterStats{5}, characterEnterStats{6}, characterEnterStats{7}, characterEnterStats{4} + characterEnterStats{9}, characterEnterStats{9}, characterEnterStats{8})
    
    %Print enemy data if analyzed, name if not.
    if enemyAnalyzed == 1
        fprintf('You''re fighting a %s.\n\tHP: %d\n\tAP: %d\n\n', enemyStats{1}, enemyStats{2}, enemyStats{3})
    else
        fprintf('You''re fighting a %s.\n\n', enemyStats{1})
    end
    
    turn = input('What do you want to do? (? for help) ', 's');
    clc
    
    %Do the turn
    switch lower(turn)
        
        %Normal attack
        case 'attack'
            if characterEnterStats{5} >= randi(100)
                playerDamage = characterEnterStats{4} + characterEnterStats{9};
                enemyStats{2} = enemyStats{2} - playerDamage;
                fprintf('You''ve dealt %.0f damage to the %s\n\n', playerDamage, enemyStats{1})
                play(playerAttack)
            else
                fprintf('You missed!\n')
            end
            enemyTurn = 1;
            
        %Power attack: 1.5x damage and .67x accuracy    
        case 'power'
            if characterEnterStats{5} >= randi(100) * (3/2)
                playerDamage = (characterEnterStats{4} + characterEnterStats{9}) * (3/2);
                enemyStats{2} = enemyStats{2} - playerDamage;
                fprintf('You''ve dealt %.0f damage to the %s\n\n', playerDamage, enemyStats{1})
                play(playerAttack)
            else
                fprintf('You missed!\n')
            end
            enemyTurn = 1;
            
        %Aimed attack: .67x damage and 1.5x accuracy    
        case 'aimed'
            if characterEnterStats{5} >= randi(100) / (3/2)
                playerDamage = (characterEnterStats{4} + characterEnterStats{9}) / (3/2);
                enemyStats{2} = enemyStats{2} -  playerDamage;
                fprintf('You''ve dealt %.0f damage to the %s\n\n', playerDamage, enemyStats{1})
                play(playerAttack)
            else
                fprintf('You missed!\n')
            end
            enemyTurn = 1;
            
         %Print help
        case '?'
            fprintf('Possible moves:\n')
            fprintf('\tattack\n')
            fprintf('\tpower\n')
            fprintf('\taimed\n')
            fprintf('\tanalyze\n')
            fprintf('\t?\n')
            
        %Do analysis    
        case 'analyze'
            fprintf('You''ve analyzed your enemy!\n\n')
            enemyAnalyzed = 1;
            enemyTurn = 1;
            
        %If into potato    
        otherwise
            fprintf('You need to correctly type in your action!\n\n')
    end
    input('Press Enter to continue.', 's')
    stop(playerAttack)
    stop(enemyAttack)
    clc
    
    %Run enemy turn if player turn is consumed and enemy is still alive
    if enemyTurn == 1 && enemyStats{2} > 0
        damage = enemyStats{3} + randi(enemyStats{4}) - characterEnterStats{7};
        
        %Enemies cannot do negative damage.
        if damage < 0
            damage = 0;
        end
        
        characterEnterStats{1} = characterEnterStats{1} - damage;
        fprintf('%s does %0.f damage to you.\n\n', enemyStats{1}, damage)
        enemyTurn = 0;
        play(enemyAttack)
    end
    
    %Restart combat music if it has stopped
    if isplaying(combatPlayer) == 0
        play(combatPlayer)
    end
        
end

%Print out victory if victory
if characterEnterStats{1} > 0
    fprintf('You''ve defeated the %s !\n', enemyStats{1})
    fprintf('You''ve gained %.0f experience.\n', enemyStats{7})
    characterEnterStats{3} = characterEnterStats{3} + enemyStats{7};
end
clc

%Stop the music
stop(combatPlayer)

%Assign new character values
characterEndStats = characterEnterStats;
end