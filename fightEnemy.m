function  characterEndStats = fightEnemy(characterEnterStats, mapLevel)
characterEndStats = characterEnterStats;

%Enemy spawns based on map level
[~, ~, enemyData] = xlsread('Enemies.xls');

%Get possible enemy spawns
enemies = size(enemyData);
for enemyRow = 1:enemies(1)
    for enemyColumn = 1:enemies(2)
if enemyData