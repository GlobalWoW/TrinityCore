-- YoggSaron
-- Updates for the various NPCs in Yogg-Saron encounter.
UPDATE `creature_template` SET `ScriptName`='npc_yogg_saron_encounter_controller' WHERE `entry`=29224;
DELETE FROM `creature` WHERE `id`=29224;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(29224, 603, 3, 1, 0, 0, 1980.28, -25.5868, 329.397, 2.91365, 300, 0, 0, 7841, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=33134;
UPDATE `creature_template` SET `ScriptName`='npc_ominous_cloud' WHERE `entry`=33292;
UPDATE `creature_template` SET `ScriptName`='npc_guardian_of_yogg_saron' WHERE `entry`=33136;
UPDATE `creature_template` SET `ScriptName`='npc_yogg_saron_tentacle' WHERE `entry` IN (33966,33985,33983);
UPDATE `creature_template` SET `ScriptName`='npc_descend_into_madness' WHERE `entry`=34072;
UPDATE `creature_template` SET `ScriptName`='boss_brain_of_yogg_saron' WHERE `entry`=33890;
UPDATE `creature_template` SET `ScriptName`='boss_yogg_saron' WHERE `entry`=33288;
UPDATE `creature_template` SET `ScriptName`='npc_influence_tentacle' WHERE `entry` IN (33716,33720,33719,33717,33433,33567);
UPDATE `creature_template` SET `ScriptName`='boss_sara' WHERE `entry`=33134;
UPDATE `creature_template` SET `ScriptName`='npc_immortal_guardian' WHERE `entry`=33988;
UPDATE `creature_template` SET `ScriptName`='npc_support_keeper' WHERE `entry` IN (33410,33411,33412,33413);
UPDATE `creature_template` SET `ScriptName`='npc_sanity_well' WHERE `entry`=33991;
UPDATE `creature_template` SET `ScriptName`='npc_death_orb' WHERE `entry`=33882;
UPDATE `creature_template` SET `ScriptName`='npc_death_ray' WHERE `entry`=33881;
UPDATE `creature_template` SET `ScriptName`='npc_laughting_skull' WHERE entry=33990;

-- Keeper helpers
UPDATE `creature_template` SET `npcflag`=`npcflag`|1, `ScriptName`='npc_keeper_help' WHERE `entry` IN (33241,33244,33242,33213);
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `difficulty_entry_1` = 33959 WHERE `entry`=33943;
UPDATE `gameobject_template` SET `ScriptName`='go_flee_to_surface' WHERE `entry`=194625;
UPDATE `item_template` SET `ScriptName`='item_unbound_fragments_of_valanyr' WHERE `entry`=45896;
UPDATE `creature_template` SET `RegenHealth`=1 WHERE `entry` IN (33134, 34332, 33890, 33954); -- No health regeneration for Sara and Brain of Yogg-saron

DELETE FROM `gameobject` WHERE `id`=194625;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(194625, 603, 3, 1, 2001.4, -59.66, 245.07, 60, 100, 1),
(194625, 603, 3, 1, 1941.61, -25.88, 244.98, 60, 100, 1),
(194625, 603, 3, 1, 2001.18, 9.409, 245.24, 60, 100, 1);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (64466,64139,64143,64133,63120,64174,64172,63802,64164,64168,62670,62671,62702,62650,65301);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(64466,'spell_empowering_shadows'),    -- Heal Trigger for Empowering Shadows
(64139,'spell_summon_tentacle_position'),  -- Correct Summon Position of Tentacle
(64143,'spell_summon_tentacle_position'),
(64133,'spell_summon_tentacle_position'),
(63120,'spell_insane_death_effekt'),   -- Insane Death trigger on Remove
(64174,'spell_hodir_protective_gaze'),   -- Hodir Secound Aura Script
(64172,'spell_titanic_storm_targeting'),  -- Needed for Titanic Storm, Script for Target have Weakened Aura
(63802,'spell_brain_link_periodic_dummy'),  -- Trigger Effekt on Near Player with Brain Link
(64164,'spell_lunatic_gaze_targeting'),
(64168,'spell_lunatic_gaze_targeting'),   -- Script for Target Faces Caster
(62670,'spell_keeper_support_aura_targeting'), -- Auras shouldn't hit other friendly NPCs
(62671,'spell_keeper_support_aura_targeting'),
(62702,'spell_keeper_support_aura_targeting'),
(62650,'spell_keeper_support_aura_targeting'),
(65301,'spell_sara_psychosis'); -- Sara Psychosis

DELETE FROM `conditions` WHERE SourceEntry IN (64184, 63882, 63886, 64172, 64465, 65209);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 64184, 0, 0, 18, 0, 1, 33288, 0, 0, 0, '', 'Effect on YoggSaron'), -- Create Val'anyr on Yogg-Saron
(13, 1, 63882, 0, 0, 18, 0, 1, 33882, 0, 0, 0, '', 'Effect on Death Orb'), -- Deathray Effekt on Death Orb
(13, 1, 63886, 0, 0, 18, 0, 1, 33882, 0, 0, 0, '', 'Effect on Death Orb'),
(13, 1, 64172, 0, 0, 18, 0, 1, 33988, 0, 0, 0, '', 'Effect only for Immortal Guardians'), -- Condition because NPCs need this else no hit
(13, 1, 64465, 0, 0, 18, 0, 1, 33988, 0, 0, 0, '', 'Effect only for Immortal Guardians'),
(13, 1, 65209, 0, 0, 18, 0, 1, 33136, 0, 0, 0, '', 'Effect only for Guardian of YoggSaron'), -- Second Damage Effekt of ShadowNova only on other Guardians or Sara
(13, 1, 65209, 0, 0, 18, 0, 1, 33134, 0, 0, 0, '', 'Effect only for Sara');

DELETE FROM `conditions` WHERE `SourceEntry` IN (65719, 62714);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `Comment`) VALUES
(13, 1, 65719, 31, 3, 33134, 'Spell should hit only Sara'),	-- Shadow Nova
(13, 1, 62714, 31, 3, 33136, 'Effect should hit only Guardians'),
(13, 2, 62714, 31, 4, 0, 'Effect should hit only Players');

-- assigning 25m version of Brain of Yogg-Saron to the normal version
UPDATE `creature_template` SET `difficulty_entry_1`=33954 WHERE `entry`=33890;

-- spawning Keeper images
DELETE FROM `creature` WHERE `id` IN (33241, 33242, 33244, 33213);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `curhealth`) VALUES
(33241, 603, 3, 1939.06, 42.3925, 411.356, 5.25215, 14433075),
(33213, 603, 3, 1939.64, -90.9194, 411.356, 0.940322, 14433075),
(33244, 603, 3, 2037.32, 25.9017, 411.358, 3.81488, 14433075),
(33242, 603, 3, 2037.03, -73.8742, 411.355, 2.35011, 14433075);

-- creature text
-- Yogg-Saron
DELETE FROM `script_texts` WHERE `npc_entry` IN (33288, 33241, 33213, 33244, 33242, 33436, 33437, 33523, 33495, 33535, 33441, 33442, 33134);
DELETE FROM `creature_text` WHERE `entry` IN (33288, 33241, 33213, 33244, 33242, 33436, 33437, 33523, 33495, 33535, 33441, 33442, 33134);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33288, 0, 0, 'BOW DOWN BEFORE THE GOD OF DEATH!', 14, 0, 100, 0, 0, 0, 'YoggSaron SAY_PHASE2'),
(33288, 1, 0, 'Look upon the true face of death and know that your end comes soon!', 14, 0, 100, 0, 0, 15755, 'YoggSaron SAY_PHASE3'),
(33288, 2, 0, 'MADNESS WILL CONSUME YOU!', 14, 0, 100, 0, 0, 15756, 'YoggSaron SAY_PORTAL'),
(33288, 3, 0, 'Hoohehehahahaha... AHAHAHAHAHAHA!', 14, 0, 100, 0, 0, 15757, 'YoggSaron SAY_SLAY_1'),
(33288, 4, 0, 'Eternal suffering awaits!', 14, 0, 100, 0, 0, 15758, 'YoggSaron SAY_DEAFENING_ROAR'),
(33288, 5, 0, 'Your will is no longer you own...', 42, 0, 100, 0, 0, 15759, 'YoggSaron WHISP_INSANITY_1'),
(33288, 5, 1, 'Destroy them minion, your master commands it!', 42, 0, 100, 0, 0, 15760, 'YoggSaron WHISP_INSANITY_2'),
(33288, 6, 0, 'Your fate is sealed. The end of days is finally upon you and ALL who inhabit this miserable little seedling. Uulwi ifis halahs gag erh''ongg w''ssh.', 14, 0, 100, 0, 0, 15761, 'YoggSaron SAY_DEATH'),

-- 3 Vision at brain phase
-- tibbi: These should not be yells (shouldnt be visible in chat), but with normal SAY players cant hear sound effects (low Say range?) so Ive set all to Yell
(33288, 7, 0, 'A thousand deaths...', 14, 0, 100, 0, 0, 15762, 'YoggSaron v1 1'),
(33288, 8, 0, 'or one murder.', 14, 0, 100, 0, 0, 15763, 'YoggSaron v1 2'),
(33288, 9, 0, 'Your petty quarrels only make me stronger!', 14, 0, 100, 0, 0, 15764, 'YoggSaron v1 3'),
(33436, 0, 0, 'Bad news sire.', 14, 0, 100, 0, 0, 15538, 'Garona v1 4'),
(33436, 1, 0, 'The clans are united under Blackhand in this assault. They will stand together until Stormwind has fallen.', 14, 0, 100, 0, 0, 15539, 'Garona v1 5'),
(33436, 2, 0, 'Gul''dan is bringing up his warlocks by nightfall. Until then, the Blackrock clan will be trying to take the Eastern Wall.', 14, 0, 100, 0, 0, 15540, 'Garona v1 6'),
(33437, 0, 0, 'We will hold until the reinforcements come. As long as men with stout hearts are manning the walls and throne Stormwind will hold.', 14, 0, 100, 0, 0, 15585, 'King Llane v1 7'),
(33436, 3, 0, 'The orc leaders agree with your assessment.', 14, 0, 100, 0, 0, 15541, 'Garona v1 8'),

(33523, 0, 0, 'It is done... All have been given that which must be given. I now seal the Dragon Soul forever...', 14, 0, 100, 0, 0, 15631, 'Neltharion v3 1'),
(33495, 0, 0, 'That terrible glow... should that be?', 14, 0, 100, 0, 0, 15784, 'Ysera v3 2'),
(33523, 1, 0, 'For it to be as it must, yes.', 14, 0, 100, 0, 0, 15632, 'Neltharion v3 3'),
(33535, 0, 0, 'It is a weapon like no other. It must be like no other.', 14, 0, 100, 0, 0, 15610, 'Malygos v3 4'),
(33288, 10, 0, 'His brood learned their lesson before too long, you shall soon learn yours!', 14, 0, 100, 0, 0, 15765, 'YoggSaron v3 5'),

(33442, 0, 0, 'Arrrrrrgh!', 14, 0, 100, 0, 0, 15470, 'Immolated Champion v2 1'),
(33441, 0, 0, 'Your resilience is admirable.', 14, 0, 100, 0, 0, 15598, 'Lich King v2 2'),
(33442, 1, 0, 'I''m not afraid of you!', 14, 0, 100, 0, 0, 15471, 'Immolated Champion v2 3'),
(33441, 1, 0, 'I will break you as I broke him.', 14, 0, 100, 0, 0, 15599, 'Lich King v2 4'),
(33288, 11, 0, 'Yrr n''lyeth... shuul anagg!', 14, 0, 100, 0, 0, 15766, 'YoggSaron v2 5'),
(33288, 12, 0, 'He will learn... no king rules forever; only death is eternal!', 14, 0, 100, 0, 0, 15767, 'YoggSaron v2 6'),

(33134, 0, 0, 'Help me! Please get them off me!', 14, 0, 100, 0, 0, 15771, 'Sara SAY_PREFIGHT_1'),
(33134, 0, 1, 'What do you want from me? Leave me alone!', 14, 0, 100, 0, 0, 15772, 'Sara SAY_PREFIGHT_2'),
(33134, 1, 0, 'The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!', 14, 0, 100, 457, 0, 15775, 'Sara SAY_AGGRO'),
(33134, 2, 0, 'Yes! YES! Show them no mercy! Give no pause to your attacks!', 14, 0, 100, 0, 0, 15773, 'Sara SAY_PHASE1_1'),
(33134, 2, 1, 'Let hatred and rage guide your blows!', 14, 0, 100, 0, 0, 15774, 'Sara SAY_PHASE1_2'),
(33134, 3, 0, 'Suffocate upon your own hate!', 14, 0, 100, 0, 0, 15776, 'Sara SAY_PHASE2_1'),
(33134, 3, 1, 'Tremble, mortals, before the coming of the end!', 14, 0, 100, 0, 0, 15777, 'Sara SAY_PHASE2_2'),
(33134, 4, 0, 'Powerless to act...', 14, 0, 100, 0, 0, 15778, 'Sara SAY_SLAY_1'),
(33134, 4, 1, 'Could they have been saved?', 14, 0, 100, 0, 0, 15779, 'Sara SAY_SLAY_2'),
(33134, 5, 0, 'I am the lucid dream.', 14, 0, 100, 0, 0, 15754, 'Sara SAY_PHASE2_1'),
(33134, 6, 0, 'The monster in your nightmares.', 14, 0, 100, 0, 0, 0, 'Sara SAY_PHASE2_2'),
(33134, 7, 0, 'The fiend of a thousand faces.', 14, 0, 100, 0, 0, 0, 'Sara SAY_PHASE2_3'),
(33134, 8, 0, 'Cower before my true form.', 14, 0, 100, 0, 0, 0, 'Sara SAY_PHASE2_4'),

-- chosing helping keepers
(33241, 0, 0, 'Eonar, your servant calls for your blessing!', 14, 0, 100, 0, 0, 15535, 'Freya SAY_YS_HELP'),
(33213, 0, 0, 'The veil of winter will protect you, champions!', 14, 0, 100, 0, 0, 15559, 'Hodir SAY_YS_HELP'),
(33244, 0, 0, 'Combat matrix enhanced. Behold wonderous rapidity!', 14, 0, 100, 0, 0, 15630, 'Mimiron SAY_YS_HELP'),
(33242, 0, 0, 'Golganneth, lend me your strengh! Grant my mortal allies the power of thunder!', 14, 0, 100, 0, 0, 15750, 'Thorim SAY_YS_HELP');
