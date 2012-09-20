-- First gameobject for the tram from inner sanctuary -> Mimiron.
UPDATE `gameobject_template` SET `flags`=32, `data2`=3000, `ScriptName`='go_call_tram' WHERE `entry` IN (194914, 194912, 194437);
DELETE FROM `gameobject` WHERE id = 194437;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(194437,603,1,1,2306.87,274.237,424.288,1.52255,0,0,0.689847,0.723956,300,0,1);

-- Second gameobject for the tram from Mimiron -> inner sanctuary.
DELETE FROM `gameobject_template` WHERE `entry`=194438;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(194438,1,8504,'Activate Tram','' ,'' ,'',0,32,1,0,0,0,0,0,0,0,0,3000,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'go_call_tram',12340);
DELETE FROM `gameobject` WHERE id=194438;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(194438,603,1,1,2306.99,2589.35,424.382,4.71676,0,0,0.705559,-0.708651,300,0,1);

-- Mimiron
UPDATE `creature_template` SET `ScriptName`='boss_mimiron' WHERE `entry`=33350;
-- Leviathan MKII
UPDATE `creature_template` SET `vehicleid`=370, `ScriptName`='boss_leviathan_mk' WHERE `entry`=33432;
UPDATE `creature_template` SET `vehicleid`=370, `flags_extra`=`flags_extra` |1 WHERE `entry`=34106;
-- Leviathan MKII Turret
UPDATE `creature_template` SET `ScriptName`='boss_leviathan_mk_turret' WHERE `entry`=34071;
DELETE FROM `vehicle_template_accessory` WHERE `entry`=33432;
INSERT INTO `vehicle_template_accessory` VALUES
(33432, 34071, 3, 1, 'Leviathan Mk II turret', 8, 0);
-- Leviathan skills and skill-helper
UPDATE `creature_template` SET `ScriptName`='npc_proximity_mine' WHERE `entry`=34362;
UPDATE `creature_model_info` SET `bounding_radius`=0.5, `combat_reach`=7 WHERE `modelid` = 28831;

-- VX-001
UPDATE `creature_template` SET `flags_extra`=`flags_extra` |1, `vehicleid`=371, `ScriptName`='boss_vx_001' WHERE `entry`=33651;
UPDATE `creature_template` SET `minlevel`=83, `maxlevel`=83, `flags_extra`=`flags_extra` |1 WHERE `entry`=34108;
UPDATE `creature_template` SET `faction_A`=35, `faction_H`=35 WHERE `entry`=34050;
UPDATE `creature_template` SET `unit_flags`=4|512|131072|33554432, `flags_extra`=`flags_extra` |2 WHERE `entry`=34211;
UPDATE `creature_template` SET `ScriptName`='npc_rocket_strike' WHERE `entry`=34047;

-- Aerial Command Unit
UPDATE `creature_template` SET `flags_extra`=`flags_extra` |1, `ScriptName`='boss_aerial_unit', `vehicleid`=372 WHERE `entry`=33670;
UPDATE `creature_template` SET `minlevel`=83, `maxlevel`=83, `flags_extra`=1 WHERE `entry`=34109;
UPDATE `creature_template` SET `ScriptName`='npc_magnetic_core' WHERE `entry`=34068;
UPDATE `creature_template` SET `ScriptName`='npc_assault_bot' WHERE `entry`=34057;
UPDATE `creature_template` SET `difficulty_entry_1`=34148, `ScriptName`='npc_emergency_bot' WHERE `entry`=34147;

-- HardMode
UPDATE `gameobject_template` SET `flags`=`flags` &~16, `ScriptName`='go_mimiron_hard_mode_activator' WHERE `entry`=194739;
UPDATE `creature_template` SET `difficulty_entry_1`=34361, `ScriptName`='npc_frost_bomb' WHERE `entry`=34149;
UPDATE `creature_template` SET `speed_walk`=0.15, `speed_run`=0.15, `ScriptName`='npc_mimiron_flame_trigger' WHERE `entry` =34363;
UPDATE `creature_template` SET `ScriptName`='npc_mimiron_flame_spread' WHERE `entry`=34121;
UPDATE `creature_template` SET `ScriptName`='npc_mimiron_bomb_bot' WHERE `entry`=33836;

-- CleanUp
DELETE FROM `creature` WHERE `id`=34071;
UPDATE `creature_template` SET `unit_flags`=`unit_flags` |2|33554432 WHERE `entry`=34143;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (33432,33651);
-INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`) VALUES
-(33432,46598,1), -- Leviatan MKII - Ride Vehicle Hardcoded
-(33651,46598,1); -- VX 001 - Ride Vehicle Hardcoded

-- Achievement "Firefighter" (3180 / 3189)
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10450, 10463);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10450, 12, 0, 0, ''), 
(10450, 11, 0, 0, 'achievement_firefighter'), 
(10463, 12, 1, 0, ''), 
(10463, 11, 0, 0, 'achievement_firefighter_25');

-- Spell stuff
DELETE FROM `spell_script_names` WHERE `spell_id` IN (63382, 63016, 63027);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63382, 'spell_rapid_burst');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63027, 'spell_proximity_mines');

-- correcting Junk bot template
UPDATE `creature_template` SET `difficulty_entry_1`=34114 WHERE `entry`=33855;
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=34114;

-- creature text
DELETE FROM `script_texts` WHERE `npc_entry`=33350;
DELETE FROM `creature_text` WHERE `entry`=33350;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33350, 0, 0, 'Oh, my! I wasn''t expecting company! The workshop is such a mess! How embarrassing!', 14, 0, 100, 0, 0, 15611, 'Mimiron SAY_AGGRO'),
(33350, 1, 0, 'Now why would you go and do something like that? Didn''t you see the sign that said ''DO NOT PUSH THIS BUTTON!''? How will we finish testing with the self-destruct mechanism active?', 14, 0, 100, 0, 0, 15629, 'Mimiron SAY_HARDMODE_ON'),
(33350, 2, 0, 'We haven''t much time, friends! You''re going to help me test out my latest and greatest creation. Now, before you change your minds, remember, that you kind of owe it to me after the mess you made with the XT-002.', 14, 0, 100, 0, 0, 15612, 'Mimiron SAY_MKII_ACTIVATE'),
(33350, 3, 0, 'MEDIC!', 14, 0, 100, 0, 0, 15613, 'Mimiron SAY_MKII_SLAY_1'),
(33350, 3, 1, 'I can fix that... or, maybe not! Sheesh, what a mess...', 14, 0, 100, 0, 0, 15614, 'Mimiron SAY_MKII_SLAY_2'),
(33350, 4, 0, 'WONDERFUL! Positively marvelous results! Hull integrity at 98.9 percent! Barely a dent! Moving right along.', 14, 0, 100, 0, 0, 15615, 'Mimiron SAY_MKII_DEATH'),
(33350, 5, 0, 'Behold the VX-001 Anti-personnel Assault Cannon! You might want to take cover.', 14, 0, 100, 0, 0, 15616, 'Mimiron SAY_VX001_ACTIVATE'),
(33350, 6, 0, 'Fascinating. I think they call that a "clean kill".', 14, 0, 100, 0, 0, 15617, 'Mimiron SAY_VX001_SLAY_1'),
(33350, 6, 1, 'Note to self: Cannon highly effective against flesh.', 14, 0, 100, 0, 0, 15618, 'Mimiron SAY_VX001_SLAY_2'),
(33350, 7, 0, 'Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put- oh, there it is!', 14, 0, 100, 0, 0, 15619, 'Mimiron SAY_VX001_DEATH'),
(33350, 8, 0, 'Isn''t it beautiful? I call it the magnificent aerial command unit!', 14, 0, 100, 0, 0, 15620, 'Mimiron SAY_AERIAL_ACTIVATE'),
(33350, 9, 0, 'Outplayed!', 14, 0, 100, 0, 0, 15621, 'Mimiron SAY_AERIAL_SLAY_1'),
(33350, 9, 1, 'You can do better than that!', 14, 0, 100, 0, 0, 15622, 'Mimiron SAY_AERIAL_SLAY_2'),
(33350, 10, 0, 'Preliminary testing phase complete. Now comes the true test!!', 14, 0, 100, 0, 0, 15623, 'Mimiron SAY_AERIAL_DEATH'),
(33350, 11, 0, 'Gaze upon its magnificence! Bask in its glorious, um, glory! I present you... V-07-TR-0N!', 14, 0, 100, 0, 0, 15624, 'Mimiron SAY_V07TRON_ACTIVATE'),
(33350, 12, 0, 'Prognosis: Negative!', 14, 0, 100, 0, 0, 15625, 'Mimiron SAY_V07TRON_SLAY_1'),
(33350, 12, 1, 'You''re not going to get up from that one, friend.', 14, 0, 100, 0, 0, 15626, 'Mimiron SAY_V07TRON_SLAY_2'),
(33350, 13, 0, 'It would appear that I''ve made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear.', 14, 0, 100, 0, 0, 15627, 'Mimiron SAY_V07TRON_DEATH'),
(33350, 14, 0, 'Oh, my! It would seem that we are out of time, my friends!', 14, 0, 100, 0, 0, 15628, 'Mimiron SAY_BERSERK');
