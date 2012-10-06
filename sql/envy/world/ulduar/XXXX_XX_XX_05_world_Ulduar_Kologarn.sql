-- Kologarn
-- Add script to arms.
UPDATE `creature_template` SET `ScriptName`='npc_kologarn_arm' WHERE `entry` IN (32933,32934);

-- Add achievement scripts to corresponding criterias
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10284, 10722, 10285, 10095, 10290, 10133);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10284, 11, 0, 0, 'achievement_disarmed'),
(10284, 12, 0, 0, ''),
(10722, 11, 0, 0, 'achievement_disarmed_25'),
(10722, 12, 1, 0, ''),
(10285, 11, 0, 0, 'achievement_with_open_arms'),
(10285, 12, 0, 0, ''),
(10095, 11, 0, 0, 'achievement_with_open_arms_25'),
(10095, 12, 1, 0, ''),
(10290, 11, 0, 0, 'achievement_rubble_and_roll'),
(10290, 12, 0, 0, ''),
(10133, 11, 0, 0, 'achievement_rubble_and_roll_25'),
(10133, 12, 1, 0, '');

-- Creature_text
DELETE FROM `script_texts` WHERE `npc_entry`=32930;
DELETE FROM `creature_text` WHERE `entry`=32930;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(32930, 0, 0, 'None shall pass!', 14, 0, 100, 0, 0, 15586, 'Kologarn SAY_AGGRO'),
(32930, 1, 0, 'KOL-THARISH!', 14, 0, 100, 0, 0, 15587, 'Kologarn SAY_SLAY_1'),
(32930, 1, 1, 'YOU FAIL!', 14, 0, 100, 0, 0, 15588, 'Kologarn SAY_SLAY_2'),
(32930, 2, 0, 'Just a scratch!', 14, 0, 100, 0, 0, 15589, 'Kologarn SAY_LEFT_ARM_GONE'),
(32930, 3, 0, 'Only a flesh wound!', 14, 0, 100, 0, 0, 15590, 'Kologarn SAY_RIGHT_ARM_GONE'),
(32930, 4, 0, 'OBLIVION!', 14, 0, 100, 0, 0, 15591, 'Kologarn SAY_SHOCKWAVE'),
(32930, 5, 0, 'I will squeeze the life from you!', 14, 0, 100, 0, 0, 15592, 'Kologarn SAY_GRAB_PLAYER'),
(32930, 6, 0, 'Master, they come...', 14, 0, 100, 0, 0, 15593, 'Kologarn SAY_DEATH'),
(32930, 7, 0, 'I am invincible!', 14, 0, 100, 0, 0, 15594, 'Kologarn SAY_BERSERK'),
(32930, 8, 0, 'Kologarn is focussing you!', 42, 0, 100, 0, 0, 0, 'Kologarn WHISPER_EYEBEAM'),
(32930, 9, 0, 'The Left Arm has regrown!', 41, 0, 100, 0, 0, 0, 'Kologarn EMOTE_LEFT'),
(32930, 10, 0, 'The Right Arm has regrown!', 41, 0, 100, 0, 0, 0, 'Kologarn EMOTE_RIGHT'),
(32930, 11, 0, 'Kologarn casts Stone Grip!', 41, 0, 100, 0, 0, 0, 'Kologarn EMOTE_STONE');