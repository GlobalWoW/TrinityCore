-- Eilo (https://github.com/eilo)
-- TrinityCore (https://github.com/TrinityCore)
-- Script original by Vlad & Castiel
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

-- Update condition by TrinityCore:
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (69400, 70173, 69402, 70175, 70374, 70383, 69705, 72959);
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
-- Alliance
(13, 3, 69400, 0, 0, 31, 0, 3, 37540, 0, 0, 0, '', NULL),
(13, 1, 70374, 0, 0, 31, 0, 3, 37540, 0, 0, 0, '', NULL),
(13, 3, 69402, 0, 0, 31, 0, 3, 37540, 0, 0, 0, '', NULL),
(13, 1, 69705, 0, 0, 31, 0, 3, 36838, 0, 0, 0, '', NULL),
-- Horde
(13, 3, 70175, 0, 1, 31, 0, 3, 37215, 0, 0, 0, '', NULL),
(13, 1, 70383, 0, 1, 31, 0, 3, 37215, 0, 0, 0, '', NULL),
(13, 3, 70173, 0, 1, 31, 0, 3, 37215, 0, 0, 0, '', NULL),
(13, 1, 69705, 0, 1, 31, 0, 3, 36839, 0, 0, 0, '', NULL);



-- Loot templates
-- Fix by TrinityCore

-- Set Variables
SET @Gunship10N := 28057; -- Data1 for 201872 & 202177
SET @Gunship10H := 28045; -- Data1 for 201873 & 202178
SET @Gunship25N := 28072; -- Data1 for 201874 & 202179
SET @Gunship25H := 28090; -- Data1 for 201875 & 202180
SET @emblem := 49426; -- Emblem of Frost
SET @SfShard := 50274; -- Shadowfrost Shard
SET @PriSar := 49908; -- Primordial Saronite
-- Dug up the old references i created for UP34:
SET @Ref10J := 34329;
SET @Ref25J := 34251;
SET @RefJ10H := 34263;
SET @RefJ25H := 34275;

-- Gunship_Armory10N_reference
DELETE FROM `reference_loot_template` WHERE `entry` IN (@Ref10J,@Ref25J,@RefJ10H,@RefJ25H);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Ref10J,50791,0,1,1,1,1), -- Saronite Gargoyle Cloak
(@Ref10J,50795,0,1,1,1,1), -- Cord of Dark Suffering
(@Ref10J,50794,0,1,1,1,1), -- Neverending Winter
(@Ref10J,50787,0,1,1,1,1), -- Frost Giant's Cleaver
(@Ref10J,50793,0,1,1,1,1), -- Midnight Sun
(@Ref10J,50788,0,1,1,1,1), -- Bone Drake's Enameled Boots
(@Ref10J,50792,0,1,1,1,1), -- Pauldrons of Lost Hope
(@Ref10J,50340,0,1,1,1,1), -- Muradin's Spyglass
(@Ref10J,50797,0,1,1,1,1), -- Ice-Reinforced Vrykul Helm
(@Ref10J,50790,0,1,1,1,1), -- Abomination's Bloody Ring
(@Ref10J,50789,0,1,1,1,1), -- Icecrown Rampart Bracers
(@Ref10J,50796,0,1,1,1,1), -- Bracers of Pale Illumination
-- Gunship_Armory25N_reference
(@Ref25J,50011,0,1,1,1,1), -- Gunship Captain's Mittens
(@Ref25J,50002,0,1,1,1,1), -- Polar Bear Claw Bracers
(@Ref25J,50006,0,1,1,1,1), -- Corp'rethar Ceremonial Crown
(@Ref25J,50010,0,1,1,1,1), -- Waistband of Righteous Fury
(@Ref25J,50003,0,1,1,1,1), -- Boneguard Commander's Pauldrons
(@Ref25J,50000,0,1,1,1,1), -- Scourge Hunter's Vambraces
(@Ref25J,50359,0,1,1,1,1), -- Althor's Abacus
(@Ref25J,50352,0,1,1,1,1), -- Corpse Tongue Coin
(@Ref25J,49999,0,1,1,1,1), -- Skeleton Lord's Circle
(@Ref25J,50009,0,1,1,1,1), -- Boots of Unnatural Growth
(@Ref25J,50008,0,1,1,1,1), -- Ring of Rapid Ascent
(@Ref25J,49998,0,1,1,1,1), -- Shadowvault Slayer's Cloak
(@Ref25J,50005,0,1,1,1,1), -- Amulet of the Silent Eulogy
(@Ref25J,50411,0,1,1,1,1), -- Scourgeborne Waraxe
(@Ref25J,50001,0,1,1,1,1), -- Ikfirus's Sack of Wonder
-- Gunship_Armory10H_reference
(@RefJ10H,51912,0,1,1,1,1), -- Saronite Gargoyle Cloak (heroic)
(@RefJ10H,51908,0,1,1,1,1), -- Cord of Dark Suffering (heroic)
(@RefJ10H,51909,0,1,1,1,1), -- Neverending Winter (heroic)
(@RefJ10H,51916,0,1,1,1,1), -- Frost Giant's Cleaver (heroic)
(@RefJ10H,51910,0,1,1,1,1), -- Midnight Sun (heroic)
(@RefJ10H,51915,0,1,1,1,1), -- Bone Drake's Enameled Boots (heroic)
(@RefJ10H,51911,0,1,1,1,1), -- Pauldrons of Lost Hope (heroic)
(@RefJ10H,50345,0,1,1,1,1), -- Muradin's Spyglass (heroic)
(@RefJ10H,51906,0,1,1,1,1), -- Ice-Reinforced Vrykul Helm (heroic)
(@RefJ10H,51913,0,1,1,1,1), -- Abomination's Bloody Ring (heroic)
(@RefJ10H,51914,0,1,1,1,1), -- Icecrown Rampart Bracers (heroic)
(@RefJ10H,51907,0,1,1,1,1), -- Bracers of Pale Illumination (heroic)
-- Gunship_Armory25H_reference
(@RefJ25H,50663,0,1,1,1,1), -- Gunship Captain's Mittens (heroic)
(@RefJ25H,50659,0,1,1,1,1), -- Polar Bear Claw Bracers (heroic)
(@RefJ25H,50661,0,1,1,1,1), -- Corp'rethar Ceremonial Crown (heroic)
(@RefJ25H,50667,0,1,1,1,1), -- Waistband of Righteous Fury (heroic)
(@RefJ25H,50660,0,1,1,1,1), -- Boneguard Commander's Pauldrons (heroic)
(@RefJ25H,50655,0,1,1,1,1), -- Scourge Hunter's Vambraces (heroic)
(@RefJ25H,50366,0,1,1,1,1), -- Althor's Abacus (heroic)
(@RefJ25H,50349,0,1,1,1,1), -- Corpse Tongue Coin (heroic)
(@RefJ25H,50657,0,1,1,1,1), -- Skeleton Lord's Circle (heroic)
(@RefJ25H,50665,0,1,1,1,1), -- Boots of Unnatural Growth (heroic)
(@RefJ25H,50664,0,1,1,1,1), -- Ring of Rapid Ascent (heroic)
(@RefJ25H,50653,0,1,1,1,1), -- Shadowvault Slayer's Cloak (heroic)
(@RefJ25H,50658,0,1,1,1,1), -- Amulet of the Silent Eulogy (heroic)
(@RefJ25H,50654,0,1,1,1,1), -- Scourgeborne Waraxe (heroic)
(@RefJ25H,50656,0,1,1,1,1); -- Ikfirus's Sack of Wonder (heroic)

-- Bind the refs to the objects
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (@Gunship10N,@Gunship10H,@Gunship25N,@Gunship25H);
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Gunship10N
(@Gunship10N,@emblem,100,1,0,2,2), -- Gunship Armory 2xemblems 10N
(@Gunship10N,1,100,1,0,-@Ref10J,2), -- 2 from reference 10Normal
-- Gunship25N
(@Gunship25N,@emblem,100,1,0,2,2), -- Gunship Armory 2xemblems 25N
(@Gunship25N,1,100,1,0,-@Ref25J,2), -- 3 from reference 25Normal
(@Gunship25N,@SfShard,-35,1,0,1,1), -- Shadowfrost Shard @ 38% chance
(@Gunship25N,@PriSar,38,1,0,1,1), -- Primordial Saronite @ 10% chance
-- Gunship10H
(@Gunship10H,@emblem,100,1,0,2,2), -- Gunship Armory 2xemblems 10H
(@Gunship10H,1,100,1,0,-@RefJ10H,2), -- 2 from reference 10Heroic
(@Gunship10H,@PriSar,38,1,0,1,1), -- Primordial Saronite @ 38% chance
-- Gunship25H
(@Gunship25H,@emblem,100,1,0,2,2), -- Gunship Armory 2xemblems 25H
(@Gunship25H,1,100,1,0,-@RefJ25H,2), -- 3 from reference 25Heroic
(@Gunship25H,@SfShard,-75,1,0,1,1), -- Shadowfrost Shard @ 75% chance
(@Gunship25H,@PriSar,50,1,0,1,1); -- Primordial Saronite @ 50% chance
