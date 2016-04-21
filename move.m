function [Map, characterStats, newMapLevel] = move(initialMap, direction, initialCharacterStats, mapLevel, enemyData, weaponList, armorList)
    
    armorSelected = 0;
    weaponSelected = 0;
    characterStats = initialCharacterStats;
    newMapLevel = mapLevel;

    %Find character position
    mapSize = size(initialMap);
    for i = 1:mapSize(1)
        for I = 1:mapSize(2)
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
                    characterStats{1} = 100 + 20 * (characterStats{2} - 1);
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY - 1, characterX} = 'C';
                    
                %Normal movement    
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                        input('Press Enter to continue.', 's')
                        characterStats = fightEnemy(characterStats, mapLevel, enemyData);
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY - 1, characterX} = 'C';
                    
                %Open treasure chests    
                case 't'
                    
                    %Select armor loot or weapon loot
                    if randi(3) > 1 && characterStats{7} ~= 10
                        fprintf('You''ve found some new armor!\n')
                        armors = size(armorList);
                        
                        %Select armors of a better level than what is
                        %already had
                        validArmors = {};
                        for armorName = 1:armors(1)
                            if armorList{armorName, 2} > characterStats{7}
                            validArmors = [validArmors; [armorList(armorName, 1) armorList(armorName, 2)]];
                            end
                        end
                        
                        %Select armor with diminishing chance of highest
                        %tier gear
                        totalArmors = size(validArmors);
                        for potentialArmor = 1:totalArmors(1)
                            if randi(2) == 2 && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                                
                            %If all tests fail, give character best armor.
                            elseif potentialArmor == totalArmors(1) && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                            end
                        end
                                
                        
                    elseif characterStats{9} ~= 5
                        fprintf('You''ve found a new weapon!\n')
                        weapons = size(weaponList);
                        
                        %Select weapons of a better level than what is
                        %already had
                        validWeapons = {};
                        for weaponName = 1:weapons(1)
                            if weaponList{weaponName, 2} > characterStats{9}
                            validWeapons = [validWeapons; [weaponList(weaponName, 1) weaponList(weaponName, 2)]];
                            end
                        end
                        
                        %Select weapon with diminishing chance of highest
                        %tier gear
                        totalWeapons = size(validWeapons);
                        for potentialWeapon = 1:totalWeapons(1)
                            if randi(2) == 2 && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                                
                            %If all tests fail, give character best weapon.
                            elseif potentialWeapon == totalWeapons(1) && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                            end
                        end
                        
                    else
                        fprintf('You''ve already got the best you can get here!\n')
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
                    characterStats{1} = 100 + 20 * (characterStats{2} - 1);
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY + 1, characterX} = 'C';
                    
                %Normal movement     
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                        input('Press Enter to continue.', 's')
                        characterStats = fightEnemy(characterStats, mapLevel, enemyData);
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY + 1, characterX} = 'C';
                    
                %Open treasure chests    
                case 't'
                    
                    %Select armor loot or weapon loot
                    if randi(3) > 1 && characterStats{7} ~= 10
                        fprintf('You''ve found some new armor!\n')
                        armors = size(armorList);
                        
                        %Select armors of a better level than what is
                        %already had
                        validArmors = {};
                        for armorName = 1:armors(1)
                            if armorList{armorName, 2} > characterStats{7}
                            validArmors = [validArmors; [armorList(armorName, 1) armorList(armorName, 2)]];
                            end
                        end
                        
                        %Select armor with diminishing chance of highest
                        %tier gear
                        totalArmors = size(validArmors);
                        for potentialArmor = 1:totalArmors(1)
                            if randi(2) == 2 && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                                
                            %If all tests fail, give character best armor.
                            elseif potentialArmor == totalArmors(1) && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                            end
                        end
                                
                        
                    elseif characterStats{9} ~= 5
                        fprintf('You''ve found a new weapon!\n')
                        weapons = size(weaponList);
                        
                        %Select weapons of a better level than what is
                        %already had
                        validWeapons = {};
                        for weaponName = 1:weapons(1)
                            if weaponList{weaponName, 2} > characterStats{9}
                            validWeapons = [validWeapons; [weaponList(weaponName, 1) weaponList(weaponName, 2)]];
                            end
                        end
                        
                        %Select weapon with diminishing chance of highest
                        %tier gear
                        totalWeapons = size(validWeapons);
                        for potentialWeapon = 1:totalWeapons(1)
                            if randi(2) == 2 && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                                
                            %If all tests fail, give character best weapon.
                            elseif potentialWeapon == totalWeapons(1) && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                            end
                        end
                        
                    else
                        fprintf('You''ve already got the best you can get here!\n')
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
                    characterStats{1} = 100 + 20 * (characterStats{2} - 1);
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX - 1} = 'C';
                    
                %Normal movement     
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                        input('Press Enter to continue.', 's')
                        characterStats = fightEnemy(characterStats, mapLevel, enemyData);
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX - 1} = 'C';
                    
                %Open treasure chests    
                case 't'
                    
                    %Select armor loot or weapon loot
                    if randi(3) > 1 && characterStats{7} ~= 10
                        fprintf('You''ve found some new armor!\n')
                        armors = size(armorList);
                        
                        %Select armors of a better level than what is
                        %already had
                        validArmors = {};
                        for armorName = 1:armors(1)
                            if armorList{armorName, 2} > characterStats{7}
                            validArmors = [validArmors; [armorList(armorName, 1) armorList(armorName, 2)]];
                            end
                        end
                        
                        %Select armor with diminishing chance of highest
                        %tier gear
                        totalArmors = size(validArmors);
                        for potentialArmor = 1:totalArmors(1)
                            if randi(2) == 2 && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                                
                            %If all tests fail, give character best armor.
                            elseif potentialArmor == totalArmors(1) && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                            end
                        end
                                
                        
                    elseif characterStats{9} ~= 5
                        fprintf('You''ve found a new weapon!\n')
                        weapons = size(weaponList);
                        
                        %Select weapons of a better level than what is
                        %already had
                        validWeapons = {};
                        for weaponName = 1:weapons(1)
                            if weaponList{weaponName, 2} > characterStats{9}
                            validWeapons = [validWeapons; [weaponList(weaponName, 1) weaponList(weaponName, 2)]];
                            end
                        end
                        
                        %Select weapon with diminishing chance of highest
                        %tier gear
                        totalWeapons = size(validWeapons);
                        for potentialWeapon = 1:totalWeapons(1)
                            if randi(2) == 2 && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                                
                            %If all tests fail, give character best weapon.
                            elseif potentialWeapon == totalWeapons(1) && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                            end
                        end
                        
                    else
                        fprintf('You''ve already got the best you can get here!\n')
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
                    characterStats{1} = 100 + 20 * (characterStats{2} - 1);
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX + 1} = 'C';
                 
                %Enter next level    
                case 'd'
                    
                    %Ask if player REALLY wants to do this
                    changeLevel = input('Once you''ve done this you can''t go back! Are you sure? (y/n): ', 's');
                    
                    if strcmpi(changeLevel, 'y') == 1
                        fprintf('Moving on up, to the east side!\n')
                        input('Press Enter to continue.', 's')
                        newMapLevel = mapLevel + 1;
                        initialMap = generateMap();
                    else
                        fprintf('Good choice.\n')
                    end
                    
                %Normal movement     
                case 'o'
                    if 6 > randi(20)
                        fprintf('You''ve encountered an enemy!\n')
                        input('Press Enter to continue.', 's')
                        characterStats = fightEnemy(characterStats, mapLevel, enemyData);
                    else
                        fprintf('An eerie howl sounds throughout the air.\n')
                    end
                    input('Press Enter to continue.', 's')
                    initialMap{characterY, characterX} = '%';
                    initialMap{characterY, characterX + 1} = 'C';
                    
                %Open treasure chests    
                case 't'
                    
                    %Select armor loot or weapon loot
                    if randi(3) > 1 && characterStats{7} ~= 10
                        fprintf('You''ve found some new armor!\n')
                        armors = size(armorList);
                        
                        %Select armors of a better level than what is
                        %already had
                        validArmors = {};
                        for armorName = 1:armors(1)
                            if armorList{armorName, 2} > characterStats{7}
                            validArmors = [validArmors; [armorList(armorName, 1) armorList(armorName, 2)]];
                            end
                        end
                        
                        %Select armor with diminishing chance of highest
                        %tier gear
                        totalArmors = size(validArmors);
                        for potentialArmor = 1:totalArmors(1)
                            if randi(2) == 2 && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                                
                            %If all tests fail, give character best armor.
                            elseif potentialArmor == totalArmors(1) && armorSelected == 0
                                characterStats{6} = validArmors{potentialArmor, 1};
                                characterStats{7} = validArmors{potentialArmor, 2};
                                armorSelected = 1;
                            end
                        end
                                
                        
                    elseif characterStats{9} ~= 5
                        fprintf('You''ve found a new weapon!\n')
                        weapons = size(weaponList);
                        
                        %Select weapons of a better level than what is
                        %already had
                        validWeapons = {};
                        for weaponName = 1:weapons(1)
                            if weaponList{weaponName, 2} > characterStats{9}
                                validWeapons = [validWeapons; [weaponList(weaponName, 1) weaponList(weaponName, 2)]]; %#ok<*AGROW>
                            end
                        end
                        
                        %Select weapon with diminishing chance of highest
                        %tier gear
                        totalWeapons = size(validWeapons);
                        for potentialWeapon = 1:totalWeapons(1)
                            if randi(2) == 2 && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                                
                            %If all tests fail, give character best weapon.
                            elseif potentialWeapon == totalWeapons(1) && weaponSelected == 0
                                characterStats{8} = validWeapons{potentialWeapon, 1};
                                characterStats{9} = validWeapons{potentialWeapon, 2};
                                weaponSelected = 1;
                            end
                        end
                        
                    else
                        fprintf('You''ve already got the best you can get here!\n')
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