-- thorim berserk
DELETE FROM `spell_script_names` WHERE `spell_id`=62560;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62560, 'spell_thorim_berserk');

-- thorim Charge orb targeting
DELETE FROM `spell_script_names` WHERE `spell_id`=62016;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62016, 'spell_thorim_charge_orb_targeting');

-- Thorim
UPDATE `creature_template` SET `ScriptName`='boss_thorim' WHERE `entry`=32865;
UPDATE `creature_template` SET `equipment_id`=1844 WHERE `entry`=33147;
-- Thunder orbs are spawned via boss script
DELETE FROM `creature` WHERE `id`=33378;

-- Controller
UPDATE `creature_template` SET `ScriptName`='npc_thorim_controller' WHERE `entry`=32879;
DELETE FROM `creature` WHERE `id`=32879;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(32879, 603, 3, 1, 0, 0, 2134.77, -262.307, 420.694, 1.3439, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);

-- Adds
-- Link spell "Stormhammer" to "Deafening Thunder"
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62042;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(62042, 62470, 1, 'Stormhammer => Deafening Thunder');

-- Register spell-script for target-selection.
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_stormhammer_targeting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62042, 'spell_stormhammer_targeting');

-- Charge Orb - implicit targeting only a special npc.
DELETE FROM `conditions` WHERE `SourceEntry`=62016;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `Comment`) VALUES
(13, 1, 62016, 31, 3, 33378, 'Lightning Shock');

-- Pre-phase adds: Register scripts.
UPDATE `creature_template` SET `ScriptName`='npc_thorim_pre_phase_add' WHERE `entry` IN (32885,32883,32908,32907,32882,32886);
UPDATE `creature_template` SET `equipment_id`=1847 WHERE `entry`=33152;
UPDATE `creature_template` SET `equipment_id`=1849 WHERE `entry` IN (32885,33153);
UPDATE `creature_template` SET `equipment_id`=1850 WHERE `entry` IN (32908,33151);
UPDATE `creature_template` SET `equipment_id`=1852 WHERE `entry`=33150;
DELETE FROM `creature` WHERE `id` IN (32882,32908,32885,32886,32907,32883); -- NPCs are spawned by script.

-- Thorim Mini bosses : Runic Colossus, Ancient Rune Giant, Sif
UPDATE `creature_template` SET `mechanic_immune_mask`=1|2|4|8|16|64|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912, `flags_extra`=1, `ScriptName`='npc_runic_colossus' WHERE `entry`=32872;
UPDATE `creature_template` SET `mechanic_immune_mask`= 1|2|4|8|16|64|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912, `flags_extra`=1, `ScriptName`='npc_ancient_rune_giant' WHERE `entry`=32873;
UPDATE `creature_template` SET `mechanic_immune_mask`= 1|2|4|8|16|64|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912, `flags_extra`=1, `ScriptName`='npc_sif' WHERE `entry`=33196;
UPDATE `creature_template` SET `ScriptName`='npc_thorim_arena_phase_add' WHERE `entry` IN (32876, 32904, 32878, 32877, 32874, 32875, 33110);
DELETE FROM `creature_addon` WHERE `guid` IN (136059, 136816);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(136059, 0, 0, 0, 1, 0, '40775'),
(136816, 0, 0, 0, 1, 0, '40775');
DELETE FROM `creature` WHERE `id` IN (33140, 33141); -- Left and right runic smash bunnies are spawned in scripts
UPDATE `creature_template` SET `ScriptName`='npc_runic_smash' WHERE `entry` IN (33140, 33141);

-- adding Thorim Lever ScriptName
-- TODO: find out why entry 194264 doesnt work
UPDATE `gameobject_template` SET `ScriptName`='go_thorim_lever' WHERE `entry`=194264;
UPDATE `gameobject_template` SET `size`=3, `data2`=6000, `flags`=16|32, `ScriptName`='go_thorim_lever' WHERE `entry`=179148;
UPDATE `gameobject` SET `id`=179148 WHERE `guid`=55194;

-- Thorim trap bunny shouldnt be able to move
UPDATE `creature_template` SET `unit_flags`=`unit_flags` |4 WHERE `entry`=33054;

-- Thorim Lightning Destruction
DELETE FROM `spell_script_names` WHERE `spell_id`=62392;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62392, 'spell_thorim_lightning_destruction');

-- Lightning orb scriptname and waypoints
UPDATE `creature_template` SET `ScriptName`='npc_lightning_orb' WHERE `entry`=33138;
DELETE FROM waypoint_data WHERE id = 33138;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z) VALUES
(33138, 1, 2227.6, -263.7, 412.2),
(33138, 2, 2227.6, -432.6, 412.2),
(33138, 3, 2199.3, -433.7, 420),
(33138, 4, 2167.5 ,-440.2, 438.5),
(33138, 5, 2134.8 ,-440.2, 438.5),
(33138, 6, 2134.8 ,-303.4, 438.5);

-- update faction of Dark Rune Acolyte so hes correctly affected by Berserk
UPDATE `creature_template` SET `faction_A`=1692, `faction_H`=1692 WHERE `entry` IN (32886, 33159);

-- creature text
DELETE FROM `script_texts` WHERE `npc_entry` IN (33413, 32865, 32872);
DELETE FROM `creature_text` WHERE `entry` IN (33413, 32865, 32872);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(32865, 0, 0, 'Interlopers! You mortals who dare to interfere with my sport will pay... Wait--you...', 14, 0, 100, 0, 0, 15733, 'Thorim SAY_AGGRO_1'),
(32865, 1, 0, 'I remember you... In the mountains... But you... what is this? Where am\-\-', 14, 0, 100, 0, 0, 15734, 'Thorim SAY_AGGRO_2'),
(32865, 2, 0, 'Behold the power of the storms and despair!', 14, 0, 100, 0, 0, 15735, 'Thorim SAY_SPECIAL_1'),
(32865, 2, 1, 'Do not hold back! Destroy them!', 14, 0, 100, 0, 0, 15736, 'Thorim SAY_SPECIAL_2'),
(32865, 2, 2, 'Have you begun to regret your intrusion?', 14, 0, 100, 0, 0, 15737, 'Thorim SAY_SPECIAL_3'),
(32865, 3, 0, 'Impertinent whelps! You dare challenge me atop my pedestal! I will crush you myself!', 14, 0, 100, 0, 0, 15738, 'Thorim SAY_JUMPDOWN'),
(32865, 4, 0, 'Can''t you at least put up a fight!?', 14, 0, 100, 0, 0, 15739, 'Thorim SAY_SLAY_1'),
(32865, 4, 1, 'Pathetic!', 14, 0, 100, 0, 0, 15740, 'Thorim SAY_SLAY_2'),
(32865, 5, 0, 'My patience has reached its limit!', 14, 0, 100, 0, 0, 15741, 'Thorim SAY_BERSERK'),
(32865, 6, 0, 'Failures! Weaklings!', 14, 0, 100, 0, 0, 15742, 'Thorim SAY_WIPE'),
(32865, 7, 0, 'Stay your arms! I yield!', 14, 0, 100, 0, 0, 15743, 'Thorim SAY_DEATH'),
(32865, 8, 0, 'I feel as though I am awakening from a nightmare, but the shadows in this place yet linger.', 14, 0, 100, 0, 0, 15744, 'Thorim SAY_END_NORMAL_1'),
(32865, 8, 1, 'Sif... was Sif here? Impossible\-\-she died by my brother''s hand. A dark nightmare indeed....', 14, 0, 100, 0, 0, 15745, 'Thorim SAY_END_NORMAL_2'),
(32865, 8, 2, 'I need time to reflect.... I will aid your cause if you should require it. I owe you at least that much. Farewell.', 14, 0, 100, 0, 0, 15746, 'Thorim SAY_END_NORMAL_3'),
(32865, 9, 0, 'You! Fiend! You are not my beloved! Be gone!', 14, 0, 100, 0, 0, 15747, 'Thorim SAY_END_HARD_1'),
(32865, 9, 1, 'Behold the hand behind all the evil that has befallen Ulduar! Left my kingdom in ruins, corrupted my brother and slain my wife!', 14, 0, 100, 0, 0, 15748, 'Thorim SAY_END_HARD_2'),
(32865, 9, 2, 'And now it falls to you, champions, to avenge us all! The task before you is great, but I will lend you my aid as I am able. You must prevail!', 14, 0, 100, 0, 0, 15749, 'Thorim SAY_END_HARD_3'),
(32872, 0, 0, 'Runic Colossus surrounds itself with a crackling Runic Barrier!', 41, 0, 100, 0, 0, 0, 'Runic Colossus EMOTE_BARRIER');
