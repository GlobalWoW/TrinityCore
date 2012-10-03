-- Listing:
DELETE FROM `creature` WHERE `guid` IN (250765, 250780) and `map`=668; -- Removes unused Uther + LK, TDB42-specific!
UPDATE `creature_template` SET `mechanic_immune_mask`=617299955,`ScriptName`='npc_frostworn_general' WHERE `entry`=36723; -- add immunity + script
UPDATE `creature_template` SET `ScriptName`='npc_jaina_and_sylvana_hor_part2' WHERE `entry` IN (36955, 37554); -- add script
UPDATE `creature_template` SET `ScriptName`='boss_lich_king_hor' WHERE `entry`=36954; -- add script
UPDATE `creature_template` SET `ScriptName`='npc_queldelar' WHERE `entry`=37158; -- add script
UPDATE `creature_template` SET `ScriptName`='npc_spiritual_reflection' WHERE `entry`=37107; -- add script
DELETE FROM `areatrigger_scripts` WHERE `entry`=5697;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5697, 'at_hor_waves_restarter'); -- script for areatrigger-restart
UPDATE `gameobject_template` SET `flags`=1, `faction`=0 WHERE `entry` in (201385, 201885, 202396, 201911); -- update states for the walls
UPDATE `creature_template` SET `unit_flags`=(2|33554432) WHERE `entry` IN (37906); -- update flags for the souls, should not be selectable

-- Add-scripts : evasion
UPDATE `creature_template` SET `ScriptName`='npc_raging_ghoul' WHERE `entry`=36940;
UPDATE `creature_template` SET `ScriptName`='npc_risen_witch_doctor' WHERE `entry`=36941;
UPDATE `creature_template` SET `ScriptName`='npc_abon' WHERE `entry`=37069;

-- Spawns
DELETE FROM `creature` WHERE `id` IN (38112, 38113, 36723) AND `map`=668;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(38112, 668, 3, 5274.27, 2040.25, 709.32, 5.46), -- Falric
(38113, 668, 3, 5347.79, 1970.21, 709.32, 2.40), -- Marwyn
(36723, 668, 3, 5414.16, 2116.62, 707.70, 4.03); -- Frostworn General

-- Update for the frostworn general in hc-mode
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16, `baseattacktime`=2000, `unit_flags`=64, `equipment_id`=2437, `mechanic_immune_mask`=617299955 WHERE `entry`=37720;

-- Equipment updates for the heroic NPCs
UPDATE `creature_template` SET `equipment_id`=2433 WHERE `entry`=38599;
UPDATE `creature_template` SET `equipment_id`=2434 WHERE `entry`=38603;
UPDATE `creature_template` SET `equipment_id`=14 WHERE `entry`=38563;
UPDATE `creature_template` SET `equipment_id`=1218 WHERE `entry`=38564;
UPDATE `creature_template` SET `equipment_id`=107 WHERE `entry`=38525;
UPDATE `creature_template` SET `equipment_id`=2435 WHERE `entry`=38544;

-- Faction-Updates for the mobs of the hunting waves
UPDATE `creature_template` SET `faction_A`=1771, `faction_H`=1771 WHERE `entry` IN (37550, 37551, 37549);

-- Reward-Chests
DELETE FROM `gameobject` where `id` IN (202337, 202212, 201710, 202336) AND `map`=668;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(202337, 668, 2, 1, 5270.98, 1655.69, 784.305, 5.78677, 0, 0, 0.245669, -0.969354, 300, 0, 1), -- HC Horde
(202212, 668, 1, 1, 5272.42, 1658.36, 784.305, 5.78677, 0, 0, 0.245669, -0.969354, 300, 0, 1), -- NH Horde
(201710, 668, 1, 1, 5270.81, 1659.4, 784.304, 5.80798, 0, 0, 0.235376, -0.971904, 300, 0, 1), -- NH Alliance
(202336, 668, 2, 1, 5269.42, 1656.7, 784.304, 5.80798, 0, 0, 0.235376, -0.971904, 300, 0, 1); -- HC Alliance

-- Gameobjects: Walls
DELETE FROM `gameobject` WHERE `id` in (201385, 201885, 202396, 201911) AND `map`=668;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(201385, 668, 3, 1, 5569.35, 2131.58, 731, 4.25428, 0, 0, 0.849191, -0.528086, 300, 0, 1),
(201885, 668, 3, 1, 5523.03, 2024.82, 732.238, 4.49612, 0, 0, 0.77929, -0.626664, 300, 0, 1),
(202396, 668, 3, 1, 5451.86, 1902.04, 747.268, 4.13171, 0, 0, 0.879941, -0.475084, 300, 0, 1),
(201911, 668, 3, 1, 5347.53, 1773.17, 766.504, 3.92515, 0, 0, 0.924232, -0.381833, 300, 0, 1);

-- Waypoints Sylvanas
DELETE FROM `script_waypoint` WHERE `entry`=37554;
INSERT INTO `script_waypoint` (`entry`,`pointid`,`location_x`,`location_y`,`location_z`,`waittime`) VALUES
(37554, 1 ,5598.72, 2214.62, 731.92, 100),
(37554, 2 ,5609.16, 2197.27, 731.72, 100),
(37554, 3 ,5603.20, 2178.98, 730.99, 1000),
(37554, 4 ,5585.38, 2145.15, 731.11, 0), -- zero: paused by script
(37554, 5 ,5557.17, 2115.52, 730.88, 100),
(37554, 6 ,5537.85, 2080.59, 730.96, 1000),
(37554, 7 ,5523.64, 2045.21, 731.25, 0), -- zero: paused by script
(37554, 8 ,5516.47, 2012.94, 733.36, 100), 
(37554, 9 ,5503.78, 1990.06, 735.78, 1000),
(37554, 10 ,5479.76, 1962.01, 738.34, 100),
(37554, 11 ,5466.09, 1923.71, 743.88, 0), -- zero: paused by script
(37554, 12 ,5446.50, 1895.15, 748.77, 100), 	
(37554, 13 ,5426.25, 1867.75, 753.44, 1000),
(37554, 14 ,5407.28, 1834.82, 757.53, 100),
(37554, 15 ,5378.29, 1810.52, 760.13, 1000), 
(37554, 16 ,5358.85, 1787.17, 763.27, 0), -- zero: paused by script
(37554, 17 ,5325.15, 1757.24, 769.96, 100),
(37554, 18 ,5304.65, 1735.27, 775.66, 100),
(37554, 19 ,5285.97, 1707.51, 782.07, 3000),
(37554, 20 ,5258.56, 1672.01, 784.30, 0),
(37554, 21 ,5257.56, 1671.01, 784.30, 0); -- end Sylvanas

-- Waypoints Jayna
DELETE FROM `script_waypoint` WHERE `entry`=36955;
INSERT INTO `script_waypoint` (`entry`,`pointid`,`location_x`,`location_y`,`location_z`,`waittime`) VALUES
(36955, 1 ,5598.72, 2214.62, 731.92, 100),
(36955, 2 ,5609.16, 2197.27, 731.72, 100),
(36955, 3 ,5603.20, 2178.98, 730.99, 1000),
(36955, 4 ,5585.38, 2145.15, 731.11, 0), -- zero: paused by script
(36955, 5 ,5557.17, 2115.52, 730.88, 100),
(36955, 6 ,5537.85, 2080.59, 730.96, 1000),
(36955, 7 ,5523.64, 2045.21, 731.25, 0), -- zero: paused by script
(36955, 8 ,5516.47, 2012.94, 733.36, 100), 
(36955, 9 ,5503.78, 1990.06, 735.78, 1000),
(36955, 10 ,5479.76, 1962.01, 738.34, 100),
(36955, 11 ,5466.09, 1923.71, 743.88, 0), -- zero: paused by script
(36955, 12 ,5446.50, 1895.15, 748.77, 100), 
(36955, 13 ,5426.25, 1867.75, 753.44, 1000),
(36955, 14 ,5407.28, 1834.82, 757.53, 100),
(36955, 15 ,5378.29, 1810.52, 760.13, 1000), 
(36955, 16 ,5358.85, 1787.17, 763.27, 0), -- zero: paused by script
(36955, 17 ,5325.15, 1757.24, 769.96, 100),
(36955, 18 ,5304.65, 1735.27, 775.66, 100),
(36955, 19 ,5285.97, 1707.51, 782.07, 3000),
(36955, 20 ,5258.56, 1672.01, 784.30, 0),
(36955, 21 ,5257.56, 1671.01, 784.30, 0); -- end Jayna

-- Waypoints LK
DELETE FROM `script_waypoint` WHERE `entry`=36954;
INSERT INTO `script_waypoint` (`entry`,`pointid`,`location_x`,`location_y`,`location_z`,`waittime`) VALUES
(36954, 1 ,5589.85, 2224.90, 733.01, 1000), -- casting sequence, still close to Jayna/Sylvanas anyhow
(36954, 2 ,5598.72, 2214.62, 731.92, 1),
(36954, 3 ,5609.16, 2197.27, 731.72, 1),
(36954, 4 ,5603.20, 2178.98, 730.99, 1),
(36954, 5 ,5585.38, 2145.15, 731.11, 1), 
(36954, 6 ,5557.17, 2115.52, 730.88, 1),
(36954, 7 ,5537.85, 2080.59, 730.96, 1),
(36954, 8 ,5523.64, 2045.21, 731.25, 1),
(36954, 9 ,5516.47, 2012.94, 733.36, 1), 
(36954, 10 ,5503.78, 1990.06, 735.78, 1),
(36954, 11 ,5479.76, 1962.01, 738.34, 1),
(36954, 12 ,5466.09, 1923.71, 743.88, 1),
(36954, 13 ,5446.50, 1895.15, 748.77, 1), 
(36954, 14 ,5426.25, 1867.75, 753.44, 1),
(36954, 15 ,5407.28, 1834.82, 757.53, 1),
(36954, 16 ,5378.29, 1810.52, 760.13, 1), 
(36954, 17 ,5355.38, 1781.95, 764.33, 1), 
(36954, 18 ,5325.15, 1757.24, 769.96, 1),
(36954, 19 ,5304.65, 1735.27, 775.66, 1),
(36954, 20 ,5285.97, 1707.51, 782.07, 1);

-- make gameobjects unusable via database, not in script
UPDATE `gameobject_template` SET `flags` = 36 WHERE `entry` IN (202302, 202236, 201976, 197341);

-- set default phasemask for some gameobjects
UPDATE `gameobject` SET `phaseMask` = 2 WHERE `id` IN (202212, 202337, 201710, 202336, 201598, 201599, 202079);

-- Set some adds attackable and selectable
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` IN (38177, 38173, 38176, 38175, 38172, 38524, 38525, 38563, 38544, 38564);

-- Set some flags for other npcs
UPDATE `creature_template` SET `unit_flags` = 33554434 WHERE `entry` IN (38112, 38599, 38113, 38603);

-- Set some flags for other npcs
UPDATE `creature_template` SET `unit_flags` = 2 WHERE `entry` IN (36723, 37720);

-- Delete default DB spawns of Uther and Lich King
DELETE FROM `creature` WHERE `id` IN (37225, 37226);

-- Set gameobject respawn time default to 1 day
UPDATE `gameobject` SET `spawntimesecs` = 86400 WHERE `map` = 668;

-- Set creature respawn time default to 1 day
UPDATE `creature` SET `spawntimesecs` = 86400 WHERE `map` = 668;

-- Set default mechanic immune mask to boss npcs
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (36723, 37720, 38112, 38599, 38113, 38603, 37226, 36954);

-- Close door Frostworn -> Lich King by default
UPDATE `gameobject` SET `state` = 1 WHERE `id` = 197342;

-- Open up the ice walls by default
UPDATE `gameobject` SET `state` = 0 WHERE `id` IN (201385, 201885, 202396, 201911) AND `map` = 668;

-- Some faction stuff
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` IN (37225, 37221, 36955, 37223, 37554, 37582, 37779, 37182, 37833, 37628, 37797);
UPDATE `creature_template` SET `faction_A` = 113, `faction_H` = 113 WHERE `entry` IN (37221, 36955, 37223, 37554);

-- Default health values
UPDATE `creature` SET `curhealth` = 377468 WHERE `id` = 38112;
UPDATE `creature` SET `curhealth` = 539240 WHERE `id` = 38113;
UPDATE `creature` SET `curhealth` = 315000 WHERE `id` = 36723;

-- Insert reputation values for trash waves Falric / Marwyn
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (38177, 38564, 38173, 38525, 38176, 38544, 38175, 38563, 38172, 38524);
INSERT INTO `creature_onkill_reputation` (creature_id, RewOnKillRepFaction1, RewOnKillRepFaction2, MaxStanding1, IsTeamAward1, RewOnKillRepValue1, MaxStanding2, IsTeamAward2, RewOnKillRepValue2, TeamDependent) VALUES
(38177, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38564, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38173, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38525, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38176, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38544, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38175, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38563, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38172, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(38524, 1037, 1052, 7, 0, 15, 7, 0, 15, 1);

-- Default values for several doors
UPDATE `gameobject_template` SET `faction` = 114, `flags` = `flags` | 4 WHERE `entry` IN (197343, 197342, 201596, 201385, 201885, 202396, 201911, 202211, 201709);

-- Quests should be given and accepted by both side npcs
DELETE FROM `creature_questrelation` WHERE `quest` IN (24802, 24500);
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (24802, 24500);
INSERT INTO `creature_questrelation` (id, quest) VALUES
(37779, 24802),
(37779, 24500),
(37582, 24802),
(37582, 24500);
INSERT INTO `creature_involvedrelation` (id, quest) VALUES
(37554, 24802),
(37554, 24500),
(36955, 24802),
(36955, 24500);
DELETE FROM `creature_questrelation` WHERE `quest` IN (24713, 24711);
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (24713, 24711);
INSERT INTO `creature_questrelation` (id, quest) VALUES
(38188, 24713),
(38189, 24713),
(38188, 24711),
(38189, 24711);
INSERT INTO `creature_involvedrelation` (id, quest) VALUES
(37221, 24713),
(37223, 24713),
(37221, 24711),
(37223, 24711);

-- Fix several loot templates - ONLY 1 item should drop off each non final boss in Frozen Halls
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `mincountOrRef` IN (-35058, -35057, -35060, -35061, -35053, -35054, -35055, -35056) AND `entry` IN (38112, 38599, 38113, 38603, 36476, 37627, 36494, 37613) AND `maxcount` = 2;

-- Set unattackable flag instead of ooc flag for Lich King, so AOE Effect will work
UPDATE `creature_template` SET `unit_flags` = 2 WHERE `entry` = 36954;

-- Fix Marwyn, Falric and Frostsworn General, they should bind to instance on heroic
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` IN (38603, 38599, 37720);

-- Spawn portal to dalaran at the end of instance
DELETE FROM `gameobject` WHERE `id` = 202079 AND `map` = 668;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(202079, 668, 3, 2, 5242.23, 1656.34, 784.302, 0.811564, 0, 0, 0.394737, 0.918794, 300, 0, 1);

-- Jaina and Sylvanas part 2 should move at same speed
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1.14286 WHERE `entry` IN (36955, 37554);

-- Add Reference Loots
SET @RefNormal := 35091;
SET @RefHeroic := 35092;
DELETE FROM `reference_loot_template` WHERE `entry` IN (@RefNormal,@RefHeroic);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Normal Loot
(@RefNormal,49839,0,1,1,1,1), -- Mourning Malice
(@RefNormal,49840,0,1,1,1,1), -- Hate-Forged Cleaver
(@RefNormal,49841,0,1,1,1,1), -- Blackened Geist Ribs
(@RefNormal,49842,0,1,1,1,1), -- Tapestry of the Frozen Throne
(@RefNormal,49843,0,1,1,1,1), -- Crystalline Citadel Gauntlets
(@RefNormal,49844,0,1,1,1,1), -- Crypt Fiend Slayer
(@RefNormal,49845,0,1,1,1,1), -- Bone Golem Scapula
(@RefNormal,49846,0,1,1,1,1), -- Chilled Heart of the Glacier
(@RefNormal,49847,0,1,1,1,1), -- Legguards of Untimely Demise
(@RefNormal,49848,0,1,1,1,1), -- Grim Lasher Shoulderguards
(@RefNormal,49849,0,1,1,1,1), -- Tattered Glacial-Woven Hood
(@RefNormal,49851,0,1,1,1,1), -- Greathelm of the Silver Hand
-- Heroic Loot
(@RefHeroic,50303,0,1,1,1,1), -- Black Icicle
(@RefHeroic,50302,0,1,1,1,1), -- Liar's Tongue
(@RefHeroic,50311,0,1,1,1,1), -- Second Helm of the Executioner
(@RefHeroic,50312,0,1,1,1,1), -- Chestguard of Broken Branches
(@RefHeroic,50310,0,1,1,1,1), -- Fossilized Ammonite Choker
(@RefHeroic,50313,0,1,1,1,1), -- Oath of Empress Zoe
(@RefHeroic,50309,0,1,1,1,1), -- Shriveled Heart
(@RefHeroic,50314,0,1,1,1,1), -- Strip of Remorse
(@RefHeroic,50308,0,1,1,1,1), -- Blighted Leather Footpads
(@RefHeroic,50305,0,1,1,1,1), -- Grinning Skull Boots
(@RefHeroic,50306,0,1,1,1,1), -- The Lady's Promise
(@RefHeroic,50304,0,1,1,1,1); -- Hoarfrost Gauntlets
-- Assign to the chest
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (27985,27993);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27985,1,100,1,0,-@RefNormal,2), -- Two from Normal Reference Loot 
(27993,1,100,1,0,-@RefHeroic,2), -- Two from Heroic Reference Loot
(27993,43102,85,1,0,1,1); -- Frozen Orb

-- Queldelar (37158)
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES (37158, 0, 0, 0, 0, 0, 30547, 30547, 0, 0, 'Quel''Delar', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 0, 0, 1, 0, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 37158, 0, 0, 0, 0, 0, 0, 0, 0, 67541, 29426, 16856, 67716, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 17, 5, 1, 0, 50254, 0, 0, 0, 0, 0, 0, 1, 3002, 0, 0, 'npc_queldelar_schwert', 12340);

-- Loot
DELETE FROM `creature_loot_template` WHERE (`entry`=37158);
INSERT INTO `creature_loot_template` VALUES 
(37158, 50254, -100, 1, 0, 1, 1);

-- Equipment (Bildet später das sichtbare Schwert)
DELETE FROM `creature_equip_template` WHERE (`entry`=3002);
INSERT INTO `creature_equip_template` VALUES ('3002', '50048', '0', '0');

-- Queldelar Trigger
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES (37704, 0, 0, 0, 0, 0, 20570, 17612, 0, 0, 'Frostmourne Altar Bunny (Quel''Delar)', '', '', 0, 80, 80, 2, 114, 114, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33555200, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_queldelar', 12340);

DELETE FROM `creature` WHERE `id`=37704;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(303475, 37704, 668, 3, 1, 17612, 0, 5309.14, 2006.21, 715.783, 3.9619, 86400, 0, 0, 12600, 0, 0, 0, 0, 0);

UPDATE `creature_template` SET `unit_flags`= 0 WHERE `entry` IN (
38177,
38173,
38176,
38175,
38172,
37906);

-- script_text
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1594540 AND -1594430;
INSERT INTO `script_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES

(-1594473,'Have reached your allies, Jaina, as promised. All will be powerful agents of the Scourge.',17229,1,0,0,'SAY_LK_JAINA_INTRO_END'),
(-1594474,'Do not make the same mistake, Sylvanas. This time there will be no escape. I will serve in death!',17228,1,0,0,'SAY_LK_SYLVANAS_INTRO_END'),

-- Frostworn General
(-1594519,'You are not worthy to face the Lich King!',16921,1,0,0,'FrostWorn General - SAY_AGGRO'),
(-1594520,'Master, I have failed...',16922,1,0,0,'FrostWorn General - SAY_DEATH'),

-- INTRO - Pre Escape
(-1594477,'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge.',17212,1,0,0,'SAY_LICH_KING_AGGRO_A'),
(-1594478,'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!',17213,1,0,0,'SAY_LICH_KING_AGGRO_H'),
(-1594479,'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!',16644,0,0,1,'SAY_JAINA_AGGRO'),
(-1594480,'He''s too powerful! Heroes, quickly, come to me! We must leave this place immediately! I will do what I can do hold him in place while we flee.',17058,0,0,1,'SAY_SYLVANA_AGGRO'),

-- ESCAPE
(-1594487,'I will destroy this barrier. You must hold the undead back!',16607,1,0,0,'SAY_JAINA_WALL_01'),
(-1594488,'No wall can hold the Banshee Queen! Keep the undead at bay, heroes! I will tear this barrier down!',17029,1,0,0,'SAY_SYLVANA_WALL_01'),
(-1594489,'Another ice wall! Keep the undead from interrupting my incantation so that I may bring this wall down!',16608,1,0,0,'SAY_JAINA_WALL_02'),
(-1594490,'Another barrier? Stand strong, champions! I will bring the wall down!',17030,1,0,0,'SAY_SYLVANA_WALL_02'),
(-1594491,'Succumb to the chill of the grave.',17218,1,0,0,'SAY_LICH_KING_WALL_02'),
(-1594492,'Another dead end.',17219,1,0,0,'SAY_LICH_KING_WALL_03'),
(-1594493,'How long can you fight it?',17220,1,0,0,'SAY_LICH_KING_WALL_04'),
(-1594494,'This playing with us. I''ll Show what happens to ice when meeting with fire!',16609,0,0,0,'SAY_JAINA_WALL_03'),
(-1594495,'Your barriers can''t hold us back much longer, monster. I will shatter them all!',16610,1,0,0,'SAY_JAINA_WALL_04'),
(-1594496,'I grow tired of these games, Arthas! Your walls can''t stop me!',17031,1,0,0,'SAY_SYLVANA_WALL_03'),
(-1594497,'You won''t impede our escape, fiend. Keep the undead off me while I bring this barrier down!',17032,1,0,0,'SAY_SYLVANA_WALL_04'),
(-1594498,'There''s an opening up ahead. GO NOW!',16645,1,0,0,'SAY_JAINA_ESCAPE_01'),
(-1594499,'We''re almost there... Don''t give up!',16646,1,0,0,'SAY_JAINA_ESCAPE_02'),
(-1594500,'There''s an opening up ahead. GO NOW!',17059,1,0,0, 'SAY_SYLVANA_ESCAPE_01'),
(-1594501,'We''re almost there! Don''t give up!',17060,1,0,0,'SAY_SYLVANA_ESCAPE_02'),
(-1594502,'It... It''s a dead end. We have no choice but to fight. Steel yourself heroes, for this is our last stand!',16647,1,0,0,'SAY_JAINA_TRAP'),
(-1594503,'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!',17061,1,0,0,'SAY_SYLVANA_TRAP'),

-- LICH KING - Hunting Sequence
(-1594486,'There is no escape!',17217,1,0,0,'SAY_LICH_KING_WALL_01'),
(-1594482,'Rise minions, do not left them us!',17216,1,0,0,'SAY_LICH_KING_GHOUL'),
(-1594483,'Minions sees them. Bring their corpses back to me!',17222,1,0,0,'SAY_LICH_KING_ABON'),
(-1594481,'Death''s cold embrace awaits.',17221,1,0,0,'SAY_LICH_KING_WINTER'),
(-1594504,'Nowhere to run! You''re mine now...',17223,1,0,0,'SAY_LICH_KING_END_DUN'),
(-1594485,'All is lost!',17215,1,0,0,'SAY_LICH_KING_WIN');
