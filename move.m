function [Map, HP] = move(initialMap, direction, initialHP)

    HP = initialHP;

    %Find character position
    for i = 1:10
        for I = 1:10
            if strcmp(initialMap{i,I}, 'C') == 1
                characterX = I;
                characterY = i;
            end
        end
    end
    
    %Do the move
    switch direction
        
        %Move up
        case 'up'
            switch initialMap{characterY - 1, characterX}
                
                %Give error for wall
                case 'x'
                    fprintf('That''s a wall you potato!\n')
                    input('Press Enter to continue.', 's')
                    
                %Heal character to full when reaching potion      
                case 'p'
                    fprintf('You''ve discovered a potion!\n')
                    fprintf('You''ve been healed to full!\n')
                    input('Press Enter to continue.', 's')
                    HP = 100;
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY - 1, characterX} = 'C';
                    
                %Enter next level    
                case 'd'
                    fprintf('Moving on up, to the east side!\n')
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY - 1, characterX} = 'C';
                    
                %Normal movement    
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY - 1, characterX} = 'C';
                    
                %Moving to places you've been    
                case '%'
                    fprintf('You''ve been here already.\n')
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY - 1, characterX} = 'C';
            end
        
        %Move down    
        case 'down'
            switch initialMap{characterY + 1, characterX}
                
                %Give error for wall
                case 'x'
                    fprintf('That''s a wall you potato!\n')
                    input('Press Enter to continue.', 's')
                    
                %Heal character to full when reaching potion      
                case 'p'
                    fprintf('You''ve discovered a potion!\n')
                    fprintf('You''ve been healed to full!\n')
                    input('Press Enter to continue.', 's')
                    HP = 100;
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY + 1, characterX} = 'C';
                    
                %Enter next level    
                case 'd'
                    fprintf('Moving on up, to the east side!\n')
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY + 1, characterX} = 'C';
                    
                %Normal movement     
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY + 1, characterX} = 'C';
                       
                %Moving to places you've been    
                case '%'
                    fprintf('You''ve been here already.\n')
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY + 1, characterX} = 'C';
            end
         
        %Move left    
        case 'left'
            switch initialMap{characterY, characterX - 1}
                
                %Give error for wall
                case 'x'
                    fprintf('That''s a wall you potato!\n')
                    input('Press Enter to continue.', 's')
                    
                %Heal character to full when reaching potion      
                case 'p'
                    fprintf('You''ve discovered a potion!\n')
                    fprintf('You''ve been healed to full!\n')
                    input('Press Enter to continue.', 's')
                    HP = 100;
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX - 1} = 'C';
                    
                %Enter next level    
                case 'd'
                    fprintf('Moving on up, to the east side!\n')
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX - 1} = 'C';
                    
                %Normal movement     
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX - 1} = 'C';
                    
                %Moving to places you've been    
                case '%'
                    fprintf('You''ve been here already.\n')
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX - 1} = 'C';
            end
            
        %Move right    
        case 'right'
            switch initialMap{characterY, characterX + 1}
                
                %Give error for wall
                case 'x'
                    fprintf('That''s a wall you potato!\n')
                    input('Press Enter to continue.', 's')
                    
                %Heal character to full when reaching potion    
                case 'p'
                    fprintf('You''ve discovered a potion!\n')
                    fprintf('You''ve been healed to full!\n')
                    input('Press Enter to continue.', 's')
                    HP = 100;
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX + 1} = 'C';
                 
                %Enter next level    
                case 'd'
                    
                    %Ask if player REALLY wants to do this
                    changeLevel = input('Once you''ve done this you can''t go back! Are you sure? (y/n): ', 's');
                    
                    if strcmpi(changeLevel, 'y') == 1
                        fprintf('Moving on up, to the east side!\n')
                        input('Press Enter to continue.', 's')
                        initialMap{characterY, characterX} = '%';
                        initialMap{characterY, characterX + 1} = 'C';
                    else
                        fprintf('Good choice.\n')
                    end
                    
                %Normal movement     
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX + 1} = 'C';
                    
                %Moving to places you've been    
                case '%'
                    fprintf('You''ve been here already.\n')
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX + 1} = 'C'; 
            end
    end
    
    %Set old map equal to new map
    Map = initialMap;
end