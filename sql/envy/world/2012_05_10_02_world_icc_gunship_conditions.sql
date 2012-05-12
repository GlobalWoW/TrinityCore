-- Eilo (https://github.com/eilo)
-- script original by Vlad & Castiel
-- Añadidos por Eilo, Hispano, Muzashi y Strolx

-- Video: http://www.youtube.com/watch?v=h36xHUdXm84
-- Gunship Battle
-- CONDITIONS AND LOOT SQL

-- Additionnal Conditions (by 2010phenix - https://github.com/2010phenix)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (69400, 70173, 69402, 70175, 70374, 70383, 72959, 69705);
SET @ENTRYA := 37540;
SET @ENTRYH := 37215;
SET @ENTRYA10H := 38128;
SET @ENTRYH10H := 38129;
SET @ENTRYA25 := 38699;
SET @ENTRYH25 := 38701;
SET @ENTRYA25H := 38700;
SET @ENTRYH25H := 38702;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES
('13', '69400', '18', '1', @ENTRYA),    -- Horde Cannon (Cannon Blast) set to hit only Skybreaker (effect 2)
('13', '69400', '18', '1', @ENTRYA10H), -- Horde Cannon (Cannon Blast) set to hit only Skybreaker - 10H (effect 2)
('13', '69400', '18', '1', @ENTRYA25),  -- Horde Cannon (Cannon Blast) set to hit only Skybreaker - 25Normal (effect 2)
('13', '69400', '18', '1', @ENTRYA25H), -- Horde Cannon (Cannon Blast) set to hit only Skybreaker -- 25H (effect 2)
('13', '70173', '18', '1', @ENTRYH),    -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer (effect 2)
('13', '70173', '18', '1', @ENTRYH10H), -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer 10H (effect 2)
('13', '70173', '18', '1', @ENTRYH25),  -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer - 25Normal (effect 2)
('13', '70173', '18', '1', @ENTRYH25H), -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer -- 25H (effect 2)
('13', '69402', '18', '1', @ENTRYA),    -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker (effect 2)
('13', '69402', '18', '1', @ENTRYA10H), -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker 10H(effect 2)
('13', '69402', '18', '1', @ENTRYA25),  -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker - 25Normal (effect 2)
('13', '69402', '18', '1', @ENTRYA25H), -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker -- 25H (effect 2)
('13', '70175', '18', '1', @ENTRYH),    -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer (effect 2)
('13', '70175', '18', '1', @ENTRYH10H), -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer 10H (effect 2)
('13', '70175', '18', '1', @ENTRYH25),  -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer - 25Normal (effect 2)
('13', '70175', '18', '1', @ENTRYH25H), -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer -- 25H (effect 2)
('13', '70374', '18', '1', @ENTRYA),    -- Burning Pitch
('13', '70374', '18', '1', @ENTRYA10H), -- Burning Pitch
('13', '70374', '18', '1', @ENTRYA25),  -- Burning Pitch
('13', '70374', '18', '1', @ENTRYA25H), -- Burning Pitch
('13', '70383', '18', '1', @ENTRYH),    -- Burning Pitch
('13', '70383', '18', '1', @ENTRYH10H), -- Burning Pitch
('13', '70383', '18', '1', @ENTRYH25),  -- Burning Pitch
('13', '70383', '18', '1', @ENTRYH25H), -- Burning Pitch
('13', '72959', '18', '1', 0),          -- Achievement (Radius: 50000 yards)
('13', '69705' ,'18', '1', 36838),      -- Gunship Battle - Spell 69705 (Below Zero) target creature 36838
('13', '69705' ,'18', '1', 36839);      -- Gunship Battle - Spell 69705 (Below Zero) target creature 36839


-- ==> Need more Fix for DB errors conditions:
DELETE FROM `conditions` WHERE `SourceEntry` IN (69705, 69400, 69402, 70175, 70374, 70383, 72959, 70173);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 69705, 0, 0, 31, 0, 3, 36838, 0, 0, 0, '', NULL),
(13, 1, 69705, 0, 1, 31, 0, 3, 36839, 0, 0, 0, '', NULL),
(13, 3, 69400, 0, 0, 31, 0, 3, 37540, 0, 0, 0, '', NULL),
(13, 3, 69402, 0, 0, 31, 0, 3, 37540, 0, 0, 0, '', NULL),
(13, 3, 69402, 0, 1, 31, 0, 3, 37215, 0, 0, 0, '', NULL),
(13, 3, 70175, 0, 0, 31, 0, 3, 37540, 0, 0, 0, '', NULL),
(13, 3, 70175, 0, 1, 31, 0, 3, 37215, 0, 0, 0, '', NULL),
(13, 1, 70374, 0, 0, 31, 0, 3, 37540, 0, 0, 0, '', NULL),
(13, 1, 70383, 0, 0, 31, 0, 3, 37215, 0, 0, 0, '', NULL),
(13, 1, 72959, 0, 0, 31, 0, 3, 0, 0, 0, 0, '', NULL),
(13, 3, 70173, 0, 0, 31, 0, 3, 37215, 0, 0, 0, '', NULL),
(13, 3, 70173, 0, 0, 31, 0, 3, 38701, 0, 0, 0, '', NULL),
(13, 3, 70173, 0, 0, 31, 0, 3, 38702, 0, 0, 0, '', NULL),
(13, 3, 70173, 0, 0, 31, 0, 3, 38129, 0, 0, 0, '', NULL);


-- Loot templates
-- UPDATE `gameobject_template` SET `data1` = 201872 WHERE `entry` = 202177;
-- UPDATE `gameobject_template` SET `data1` = 201873 WHERE `entry` = 202178;
-- UPDATE `gameobject_template` SET `data1` = 201874 WHERE `entry` = 202179;
-- UPDATE `gameobject_template` SET `data1` = 201875 WHERE `entry` = 202180;

UPDATE `gameobject_template` SET `data1` = 201872 WHERE `entry` = 201872;
UPDATE `gameobject_template` SET `data1` = 201873 WHERE `entry` = 201873;
UPDATE `gameobject_template` SET `data1` = 201874 WHERE `entry` = 201874;
UPDATE `gameobject_template` SET `data1` = 201875 WHERE `entry` = 201875;

DELETE FROM `gameobject_loot_template` WHERE `entry` IN (201872, 201873, 201874, 201875);
INSERT INTO `gameobject_loot_template`
(`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`)
VALUES

(201872, 49426, 100,  1, 0, 2, 2),
(201872, 50340, 0,    1, 1, 1, 1),
(201872, 50787, 0,    1, 1, 1, 1),
(201872, 50788, 0,    1, 1, 1, 1),
(201872, 50789, 0,    1, 2, 1, 1),
(201872, 50790, 0,    1, 2, 1, 1),
(201872, 50791, 0,    1, 1, 1, 1),
(201872, 50792, 0,    1, 2, 1, 1),
(201872, 50793, 0,    1, 1, 1, 1),
(201872, 50794, 0,    1, 1, 1, 1),
(201872, 50795, 0,    1, 2, 1, 1),
(201872, 50796, 0,    1, 2, 1, 1),
(201872, 50797, 0,    1, 2, 1, 1),

(201873, 49426, 100,  1, 0, 2, 2),
(201873, 49908, 10,   1, 0, 1, 1),
(201873, 49998, 0,    1, 1, 1, 1),
(201873, 49999, 0,    1, 2, 1, 1),
(201873, 50000, 0,    1, 2, 1, 1),
(201873, 50001, 0,    1, 3, 1, 1),
(201873, 50002, 0,    1, 2, 1, 1),
(201873, 50003, 0,    1, 3, 1, 1),
(201873, 50005, 0,    1, 1, 1, 1),
(201873, 50006, 0,    1, 3, 1, 1),
(201873, 50008, 0,    1, 1, 1, 1),
(201873, 50009, 0,    1, 3, 1, 1),
(201873, 50010, 0,    1, 2, 1, 1),
(201873, 50011, 0,    1, 1, 1, 1),
(201873, 50274, 37.5, 1, 0, 1, 1),
(201873, 50352, 0,    1, 1, 1, 1),
(201873, 50359, 0,    1, 2, 1, 1),
(201873, 50411, 0,    1, 3, 1, 1),

(201874, 49426, 100,  1, 0, 2, 2),
(201874, 49908, 10,   1, 0, 1, 1),
(201874, 50345, 0,    1, 2, 1, 1),
(201874, 51906, 0,    1, 1, 1, 1),
(201874, 51907, 0,    1, 1, 1, 1),
(201874, 51908, 0,    1, 1, 1, 1),
(201874, 51909, 0,    1, 2, 1, 1),
(201874, 51910, 0,    1, 2, 1, 1),
(201874, 51911, 0,    1, 2, 1, 1),
(201874, 51912, 0,    1, 2, 1, 1),
(201874, 51913, 0,    1, 1, 1, 1),
(201874, 51914, 0,    1, 2, 1, 1),
(201874, 51915, 0,    1, 1, 1, 1),
(201874, 51916, 0,    1, 1, 1, 1),

(201875, 49426, 100,  1, 0, 2, 2),
(201875, 49908, 10,   1, 0, 1, 1),
(201875, 50274, 75,   1, 0, 1, 1),
(201875, 50349, 0,    1, 2, 1, 1),
(201875, 50366, 0,    1, 1, 1, 1),
(201875, 50653, 0,    1, 3, 1, 1),
(201875, 50654, 0,    1, 3, 1, 1),
(201875, 50655, 0,    1, 3, 1, 1),
(201875, 50656, 0,    1, 2, 1, 1),
(201875, 50657, 0,    1, 3, 1, 1),
(201875, 50658, 0,    1, 1, 1, 1),
(201875, 50659, 0,    1, 2, 1, 1),
(201875, 50660, 0,    1, 1, 1, 1),
(201875, 50661, 0,    1, 1, 1, 1),
(201875, 50663, 0,    1, 2, 1, 1),
(201875, 50664, 0,    1, 2, 1, 1),
(201875, 50665, 0,    1, 1, 1, 1),
(201875, 50667, 0,    1, 3, 1, 1);