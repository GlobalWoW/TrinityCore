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

-- "Lever" should open "Dark Iron Portcullis".
DELETE FROM `gameobject_scripts` WHERE `id`=55194;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(55194, 0, 11, 34155, 15, 0, 0, 0, 0, 0);

-- thorim berserk
DELETE FROM `spell_script_names` WHERE `spell_id`=62560;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62560, 'spell_thorim_berserk');

-- thorim Charge orb targeting
DELETE FROM `spell_script_names` WHERE `spell_id`=62016;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62016, 'spell_thorim_charge_orb_targeting');
