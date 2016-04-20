function  characterEndStats = fightEnemy(characterEnterStats, mapLevel, enemyData)
characterEndStats = characterEnterStats;

%Clear text & set initial variables
clc
enemyAnalyzed = 0;
enemyTurn = 0;

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
while enemyStats{2} > 0
    
    %Print enemy data if analyzed, name if not.
    if enemyAnalyzed == 1
        fprintf('You''re fighting a %s.\n\tHP: %d\n\tAP: %d', enemyStats{1}, enemyStats{2}, enemyStats{3})
    else
        fprintf('You''re fighting a %s.\n', enemyStats{1})
    end
    
    turn = input('What do you want to do? (? for help)', 's');
    clc
    
    %Do the turn
    switch lower(turn)
        
        %Normal attack
        case 'attack'
            if characterEnterStats{5} >= randi(100)
                enemyStats{2} = enemyStats{2} - characterEnterStats{4};
            else
                fprintf('You missed!\n')
            end
            enemyTurn = 1;
            
        %Power attack: 1.5x damage and .67x accuracy    
        case 'power'
            if characterEnterStats{5} >= randi(100) * 2
                enemyStats{2} = enemyStats{2} - characterEnterStats{4} * 1.5;
            else
                fprintf('You missed!\n')
            end
            enemyTurn = 1;
            
        %Aimed attack: .67x damage and 1.5x accuracy    
        case 'aimed'
            if characterEnterStats{5} >= randi(100) / 1.5
                enemyStats{2} = enemyStats{2} - characterEnterStats{4} * (2/3) ;
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
            fprintf('You''ve analyzed your enemy!\n')
            enemyAnalyzed = 1;
            enemyTurn = 1;
            
        %If into potato    
        otherwise
            fprintf('You need to correctly type in your action!\n')
    end
    input('Press Enter to continue.', 's')
    clc
    
    %Run enemy turn if player turn is consumed
    if enemyTurn == 1
        fprintf('%s does its thing.\n', enemyStats{1})
    end
end

%Print out victory
fprintf('You''ve messed the %s up, son!\n', enemyStats{1,1})
end