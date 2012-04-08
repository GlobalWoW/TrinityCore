-- 2012-04-08 12:06:01 Script named 'spell_xt002_searing_light' does not have a script name assigned in database.
-- 2012-04-08 12:06:01 Script named 'spell_xt002_gravity_bomb' does not have a script name assigned in database.
UPDATE `spell_script_names` SET `ScriptName`='spell_xt002_searing_light' WHERE `spell_id` IN (63018,65121);
UPDATE `spell_script_names` SET `ScriptName`='spell_xt002_gravity_bomb' WHERE `spell_id` IN (63024,64234);


-- 2012-04-08 12:06:01 Script named 'spell_steelbreaker_static_disruption' does not have a script name assigned in database.
-- 2012-04-08 12:06:01 Script named 'spell_steelbreaker_electrical_charge' does not have a script name assigned in database.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (61911,63495);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(61911, 'spell_steelbreaker_static_disruption'),
(63495, 'spell_steelbreaker_static_disruption');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (61902);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(61902, 'spell_steelbreaker_electrical_charge');


-- 2012-04-08 12:06:01 Script named 'achievement_i_choose_you' does not have a script name assigned in database.
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` BETWEEN 10082 AND 10087;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` BETWEEN 10082 AND 10087 AND `type` IN (11,12);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10082,11,0,0,'achievement_i_choose_you'),
(10083,11,0,0,'achievement_i_choose_you'),
(10084,11,0,0,'achievement_i_choose_you'),
(10085,11,0,0,'achievement_i_choose_you'),
(10086,11,0,0,'achievement_i_choose_you'),
(10087,11,0,0,'achievement_i_choose_you'),
(10082,12,0,0,''),
(10083,12,0,0,''),
(10084,12,0,0,''),
(10085,12,1,0,''),
(10086,12,1,0,''),
(10087,12,1,0,'');


-- 2012-04-08 12:06:01 Script named 'achievement_but_i_am_on_your_side' does not have a script name assigned in database.
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (10088,10418,10419,10089,10420,10421);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10088,10418,10419,10089,10420,10421) AND `type` IN (11,12);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10088,11,0,0,'achievement_but_i_am_on_your_side'),
(10418,11,0,0,'achievement_but_i_am_on_your_side'),
(10419,11,0,0,'achievement_but_i_am_on_your_side'),
(10088,12,0,0,''),
(10418,12,0,0,''),
(10419,12,0,0,''),
(10089,11,0,0,'achievement_but_i_am_on_your_side'),
(10420,11,0,0,'achievement_but_i_am_on_your_side'),
(10421,11,0,0,'achievement_but_i_am_on_your_side'),
(10089,12,1,0,''),
(10420,12,1,0,''),
(10421,12,1,0,'');


-- 2012-04-08 12:06:01 Script named 'mob_saronit_vapor' does not have a script name assigned in database.
-- 2012-04-08 12:06:01 Script named 'mob_saronit_animus' does not have a script name assigned in database.
-- 2012-04-08 12:06:01 Script named 'spell_general_vezax_aura_of_despair_aura' does not have a script name assigned in database.
-- 2012-04-08 12:06:01 Script named 'spell_general_vezax_mark_of_the_faceless_aura' does not have a script name assigned in database.
-- 2012-04-08 12:06:01 Script named 'spell_general_vezax_mark_of_the_faceless_drain' does not have a script name assigned in database.
UPDATE creature_template SET scriptname = 'mob_saronit_vapor' WHERE entry = 33488;
UPDATE creature_template SET scriptname = 'mob_saronit_animus' WHERE entry = 33524;
DELETE FROM spell_script_names WHERE spell_id = 62692;
INSERT INTO spell_script_names VALUE (62692,'spell_general_vezax_aura_of_despair_aura');
DELETE FROM spell_script_names WHERE spell_id = 63276;
INSERT INTO spell_script_names VALUE (63276,'spell_general_vezax_mark_of_the_faceless_aura');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63322;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,63322,18,1,0);
DELETE FROM `spell_script_names` WHERE `spell_id`=63278;
INSERT INTO `spell_script_names` VALUE (63278, 'spell_general_vezax_mark_of_the_faceless_drain');
UPDATE `creature_template` SET `speed_run`=1.42857, `baseattacktime`=1500 WHERE `entry` IN (33271,33449);


-- 2012-04-08 12:06:01 Script named 'achievement_i_love_the_smell_of_saronite_in_the_morning' does not have a script name assigned in database.
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (10451,10462);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10451,10462) AND `type` IN (11,12);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10451,11,0,0, 'achievement_i_love_the_smell_of_saronite_in_the_morning'),
(10462,11,0,0, 'achievement_i_love_the_smell_of_saronite_in_the_morning'),
(10451,12,0,0, ''),
(10462,12,1,0, '');

-- Fix conditions (NEED HELP)
DELETE FROM conditions WHERE SourceEntry = 62016;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,ErrorTextId,ScriptName,COMMENT) VALUES
('13','1','62016','0','18','1','33378','0','0','',NULL);

UPDATE `conditions` SET `SourceGroup`=1 WHERE `SourceEntry` IN (64570,65192,64626,65333,64619,63414,63041,65040,65346,62942,64098,62976,62304,64597,64996,62168,65209,64172,64465,63882,63886,64184,65387,63322);
-- UPDATE `conditions` SET `SourceGroup`=3 WHERE `SourceEntry` IN (62466);