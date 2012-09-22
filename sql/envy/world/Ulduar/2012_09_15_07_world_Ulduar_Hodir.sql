-- achievement script
-- 10 man handling.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10223, 10240, 10241);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10223, 11, 0, 0, 'achievement_staying_buffed_all_winter'), 
(10223, 12, 0, 0, ''), 
(10240, 11, 0, 0, 'achievement_staying_buffed_all_winter'), 
(10240, 12, 0, 0, ''), 
(10241, 11, 0, 0, 'achievement_staying_buffed_all_winter'), 
(10241, 12, 0, 0, '');

-- 25 man handling.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10229, 10238, 10239);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10229, 12, 1, 0, ''), 
(10229, 11, 0, 0, 'achievement_staying_buffed_all_winter_25'), 
(10238, 12, 1, 0, ''), 
(10238, 11, 0, 0, 'achievement_staying_buffed_all_winter_25'), 
(10239, 12, 1, 0, ''), 
(10239, 11, 0, 0, 'achievement_staying_buffed_all_winter_25');

-- Creature text
DELETE FROM `script_texts` WHERE `npc_entry`=32845;
DELETE FROM `creature_text` WHERE `entry`=32845;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(32845, 0, 0, 'You will suffer for this trespass!', 14, 0, 100, 0, 0, 15552, 'Hodir SAY_AGGRO'),
(32845, 1, 0, 'Tragic. To come so far, only to fail.', 14, 0, 100, 0, 0, 15553, 'Hodir SAY_SLAY_1'),
(32845, 1, 1, 'Welcome to the endless winter.', 14, 0, 100, 0, 0, 15554, 'Hodir SAY_SLAY_2'),
(32845, 2, 0, 'Winds of the north consume you!', 14, 0, 100, 0, 0, 15555, 'Hodir SAY_FLASH_FREEZE'),
(32845, 3, 0, 'Hodir roars furious.', 41, 0, 100, 0, 0, 15556, 'Hodir SAY_STALACTITE'),
(32845, 4, 0, 'I... I am released from his grasp... at last.', 14, 0, 100, 0, 0, 15557, 'Hodir SAY_DEATH'),
(32845, 5, 0, 'Enough! This ends now!', 14, 0, 100, 0, 0, 15558, 'Hodir SAY_BERSERK'),
(32845, 6, 0, 'Hodir shatters the Rare Cache of Hodir!', 41, 0, 100, 0, 0, 0, 'Hodir SAY_HARD_MODE_FAILED'),
(32845, 7, 0, 'Hodir begins to cast Flash Freeze!', 41, 0, 100, 0, 0, 0, 'Hodir - EMOTE_FREEZE'),
(32845, 8, 0, 'Hodir gains Frozen Blows!', 41, 0, 100, 0, 0, 0, 'Hodir - EMOTE_BLOW');