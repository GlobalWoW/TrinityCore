-- Thanks to Eilo

-- Añadiendo informacion complementaria de cañones
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (69400, 70173, 69402, 70175, 70374, 70383, 72959);
SET @ENTRYA := 37540;
SET @ENTRYH := 37215;
SET @ENTRYA10H := 38128;
SET @ENTRYH10H := 38129;
SET @ENTRYA25 := 38699;
SET @ENTRYH25 := 38701;
SET @ENTRYA25H := 38700;
SET @ENTRYH25H := 38702;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`) VALUES
('13','1','69400','31','0','4',0),
('13','2','69400','31','0','3',@ENTRYA), -- Horde Cannon (Cannon Blast) set to hit only Skybreaker (effect 2)
('13','1','70173','31','0','4',0),
('13','2','70173','31','0','3',@ENTRYH), -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer (effect 2)
('13','1','69402','31','0','4',0),
('13','2','69402','31','0','3',@ENTRYA), -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker (effect 2)
('13','3','69402','31','1','3',@ENTRYA),
('13','1','70175','31','0','4',0),
('13','2','70175','31','0','3',@ENTRYH), -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer (effect 2)
('13','3','70175','31','1','3',@ENTRYH),
('13','1','70374','31','0','3',@ENTRYA), -- Burning Pitch
('13','1','70383','31','0','3',@ENTRYH), -- Burning Pitch
('13','2','69400','31','0','3',@ENTRYA10H), -- Horde Cannon (Cannon Blast) set to hit only Skybreaker - 10H (effect 2)
('13','2','70173','31','0','3',@ENTRYH10H), -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer 10H (effect 2)
('13','2','69402','31','0','3',@ENTRYA10H), -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker 10H(effect 2)
('13','3','69402','31','1','3',@ENTRYA10H),
('13','2','70175','31','0','3',@ENTRYH10H), -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer 10H (effect 2)
('13','3','70175','31','1','3',@ENTRYH10H),
('13','1','70374','31','0','3',@ENTRYA10H), -- Burning Pitch
('13','1','70383','31','0','3',@ENTRYH10H), -- Burning Pitch
('13','2','69400','31','0','3',@ENTRYA25), -- Horde Cannon (Cannon Blast) set to hit only Skybreaker - 25Normal (effect 2)
('13','2','70173','31','0','3',@ENTRYH25), -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer - 25Normal (effect 2)
('13','2','69402','31','0','3',@ENTRYA25), -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker - 25Normal (effect 2)
('13','3','69402','31','1','3',@ENTRYA25),
('13','2','70175','31','0','3',@ENTRYH25), -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer - 25Normal (effect 2)
('13','3','70175','31','1','3',@ENTRYH25),
('13','1','70374','31','0','3',@ENTRYA25),  -- Burning Pitch
('13','1','70383','31','0','3',@ENTRYH25),  -- Burning Pitch
('13','2','69400','31','0','3',@ENTRYA25H), -- Horde Cannon (Cannon Blast) set to hit only Skybreaker -- 25H (effect 2)
('13','2','70173','31','0','3',@ENTRYH25H), -- Alliance Cannon (Cannon Blast) set to hit only Orgrimms Hammer -- 25H (effect 2)
('13','2','69402','31','0','3',@ENTRYA25H), -- Horde Cannon (Incinerating Blast) set to hit only Skybreaker -- 25H (effect 2)
('13','3','69402','31','1','3',@ENTRYA25H),
('13','2','70175','31','0','3',@ENTRYH25H), -- Alliance Cannon (Incinerating Blast) set to hit only Orgrimms Hammer -- 25H (effect 2)
('13','3','70175','31','1','3',@ENTRYH25H),
('13','1','70374','31','0','3',@ENTRYA25H), -- Burning Pitch
('13','1','70383','31','0','3',@ENTRYH25H), -- Burning Pitch
('13','1','72959','31','0','3',0); -- Achievement (Radius: 50000 yards)