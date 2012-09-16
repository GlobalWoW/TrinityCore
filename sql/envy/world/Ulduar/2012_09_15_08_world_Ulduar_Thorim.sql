-- Thorim
UPDATE `creature_template` SET `speed_walk` = 1.66667, `mechanic_immune_mask` = 650854239, `ScriptName` = 'boss_thorim' WHERE `entry` = 32865;
UPDATE `creature_template` SET `speed_walk` = 1.66667, `baseattacktime` = 1500, `equipment_id` = 1844, `mechanic_immune_mask` = 650854239 WHERE `entry` = 33147;
UPDATE `creature` SET `spawndist`=5 WHERE `id`=32865;
-- Controller
UPDATE `creature_template` SET `modelid2`=11686, `unit_flags`=33554432|4|2, `flags_extra`=0, `ScriptName`='npc_thorim_controller' WHERE `entry`=32879;
DELETE FROM `creature` WHERE `id`=32879;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (32879, 603, 3, 1, 0, 0, 2134.77, -262.307, 428.694, 1.3439, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);

-- Adds
UPDATE `creature` SET `MovementType`=1 WHERE `id`=32865;

-- Link spell "Stormhammer" to "Deafening Thunder"
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62042;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(62042, 62470, 1, 'Stormhammer => Deafening Thunder');

-- Register spell-script for target-selection.
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_stormhammer_targeting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (62042, 'spell_stormhammer_targeting');

-- Charge Orb - implicit targeting only a special npc.
DELETE FROM `conditions` WHERE SourceEntry = 62016;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (13, 0, 62016, 0, 0, 18, 0, 33378, 0, 0, 0, 0, '', NULL);
UPDATE `creature_template` SET `unit_flags`=33685508 WHERE `entry`=33378;

-- Pre-phase adds: Register scripts.
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~32768,`dynamicflags`=0,`ScriptName`='npc_thorim_pre_phase_add' WHERE `entry` IN (32885,32883,32908,32907,32882,32886);
UPDATE `creature_template` SET `equipment_id`=1847 WHERE `entry`=33152;
UPDATE `creature_template` SET `equipment_id`=1849 WHERE `entry` IN (32885,33153);
UPDATE `creature_template` SET `equipment_id`=1850 WHERE `entry` IN (32908,33151);
UPDATE `creature_template` SET `equipment_id`=1852 WHERE `entry`=33150;
UPDATE `creature_template` SET `modelid1`=16925, `modelid2`=0 WHERE `entry` IN (33378, 32892);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|131072 WHERE `entry` IN (33054,33725);
DELETE FROM `creature` WHERE `id` IN (32882,32908,32885,32886,32907,32883); -- NPCs are spawned by script.

-- Thorim Mini bosses : Runic Colossus, Ancient Rune Giant, Sif
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256, `mechanic_immune_mask`= 650854239, `flags_extra`=1, `ScriptName`='npc_runic_colossus' WHERE `entry`=32872;
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256, `mechanic_immune_mask`= 650854239, `flags_extra`=1, `ScriptName`='npc_ancient_rune_giant' WHERE `entry`=32873;
UPDATE `creature_template` SET `mechanic_immune_mask`= 650854239, `flags_extra`=1, `ScriptName`='npc_sif' WHERE `entry`=33196;
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256, `ScriptName`='npc_thorim_arena_phase_add' WHERE `entry` IN (32876, 32904, 32878, 32877, 32874, 32875, 33110);
DELETE FROM `creature_addon` WHERE `guid` IN (136059, 136816);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(136059, 0, 0, 0, 1, 0, '40775'),
(136816, 0, 0, 0, 1, 0, '40775');
DELETE FROM `creature` WHERE `id` IN (33140,33141); -- Left- and right-hands are used in RunicSmash().
UPDATE `creature_template` SET `ScriptName`='npc_runic_smash' WHERE `entry` IN (33140, 33141);

-- Caches.
UPDATE `gameobject_template` SET `flags`=`flags`&~16 WHERE `entry` IN (194312,194313,194314,194315);

-- "Lever" should open "Dark Iron Portcullis".
UPDATE `gameobject_template` SET `type`=1, `faction`=35, `data1`=0, `data4`=0 WHERE `entry`=194264;
DELETE FROM `gameobject_scripts` WHERE `id`=55194;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(55194, 0, 11, 34155, 15, 0, 0, 0, 0, 0);
UPDATE `gameobject` SET `rotation2`=1, `spawntimesecs`=7200, `animprogress`=100 WHERE `id`=194264;
