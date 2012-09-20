-- Ulduar Trash
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_steelforged_defender' WHERE `entry`=33236;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ironwork_cannon' WHERE `entry`=33264;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_corrupted_servitor' WHERE `entry`=33354;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_misguided_nymph' WHERE `entry`=33355;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_guardian_lasher' WHERE `entry`=33430;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_forest_swarmer' WHERE `entry`=33431;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_mangrove_ent' WHERE `entry`=33525;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ironroot_lasher' WHERE `entry`=33526;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_natures_blade' WHERE `entry`=33527;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_guardian_of_life' WHERE `entry`=33528;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_storm_tempered_keeper' WHERE `entry` IN (33699, 33722);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_charged_sphere' WHERE `entry`=33715;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_faceless_horror' WHERE `entry`=33772; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_adherent' WHERE `entry`=33818; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_frost_mage' WHERE `entry`=33819;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_pyromancer' WHERE `entry`=33820;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_enslaved_fire_elemental' WHERE `entry`=33838;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_guardian' WHERE `entry`=33822;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_slayer' WHERE `entry`=33823;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_shadowblade' WHERE `entry`=33824;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_molten_colossus' WHERE `entry`=34069;

DELETE FROM `spell_script_names` WHERE `spell_id`=63059;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63059, 'spell_pollinate');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62317 AND `spell_effect`=57807 AND `type`=1;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(62317, 57807, 1, 'Twilight Guardian - Link Devastate to Sunder Armor');

-- Clockwork mechanic
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~(262144|33554432) WHERE `entry`=34184;

-- Magma Rager
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34086;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34086;
INSERT INTO `smart_scripts` (`entryorguid`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `target_type`, `comment`) VALUES 
(34086, 6, 5000, 10000, 5000, 10000, 11, 5, 'Magma Rager - Cast Fire Blast');

-- Forge Construct
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34085;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34085;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `event_flags`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34085, 4, 6, 11, 64719, 2, 'Forge Construct - Cast Charge');
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34085, 1, 0, 2, 5000, 15000, 5000, 15000, 11, 64720, 2, 'Forge Construct - Cast Flame Emission'),
(34085, 2, 0, 4, 5000, 15000, 5000, 15000, 11, 64721, 2, 'Forge Construct - Cast Flame Emission');

-- XD-175 Compactobot
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34271;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34271;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `target_param1`, `target_param2`, `comment`) VALUES
(34271, 0, 0, 2, 10000, 20000, 10000, 20000, 11, 65073, 17, 10, 40, 'XD-175 Compactobot - Cast Trash Compactor'),
(34271, 1, 0, 4, 10000, 20000, 10000, 20000, 11, 65106, 17, 10, 40, 'XD-175 Compactobot - Cast Trash Compactor');

-- Parts Recovery Technician
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34267;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34267;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34267, 0, 0, 6, 10000, 20000, 10000, 20000, 11, 65071, 2, 'Parts Recovery Technician - Cast Mechano Kick'),
(34267, 1, 0, 6, 5000, 10000, 20000, 25000, 11, 65070, 1, 'Parts Recovery Technician - Cast Defense Matrix');

-- XB-488 Disposalbot
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34273;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34273;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34273, 0, 0, 2, 2000, 5000, 5000, 7000, 11, 65080, 2, 'XB-488 Disposalbot - Cast Cut Scrap Metal'),
(34273, 1, 0, 4, 2000, 5000, 5000, 7000, 11, 65104, 2, 'XB-488 Disposalbot - Cast Cut Scrap Metal'),
(34273, 2, 2, 6, 1, 15, 0, 0, 11, 65084, 1, 'XB-488 Disposalbot - Cast Self Destruct');

-- TODO: XR-949 Salvagebot

-- Lightning Charged Iron Dwarf
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34199;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34199;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34199, 0, 4, 2, 11, 64889, 1, 'Lightning Charged Iron Dwarf - Cast Lightning Charged'),
(34199, 1, 4, 4, 11, 64975, 1, 'Lightning Charged Iron Dwarf - Cast Lightning Charged');

-- Hardened Iron Golem
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34190;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34190;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34190, 0, 0, 2, 5000, 10000, 15000, 20000, 11, 64874, 2, 'Hardened Iron Golem - Cast Rune Punch'),
(34190, 1, 0, 4, 5000, 10000, 15000, 20000, 11, 64967, 2, 'Hardened Iron Golem - Cast Rune Punch'),
(34190, 2, 0, 6, 5000, 10000, 15000, 20000, 11, 64877, 1, 'Hardened Iron Golem - Cast Harden Fists');

-- Iron Mender
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34198;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34198;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34198, 0, 0, 2, 5000, 10000, 10000, 20000, 11, 64918, 2, 'Iron Mender - Cast Electro Shock'),
(34198, 1, 0, 4, 5000, 10000, 10000, 20000, 11, 64971, 2, 'Iron Mender - Cast Electro Shock'),
(34198, 2, 0, 2, 5000, 10000, 20000, 25000, 11, 64903, 5, 'Iron Mender - Cast Fuse Lightning'),
(34198, 3, 0, 4, 5000, 10000, 20000, 25000, 11, 64970, 5, 'Iron Mender - Cast Fuse Lightning'),
(34198, 4, 14, 2, 20000, 40, 15000, 20000, 11, 64897, 7, 'Iron Mender - Cast Fuse Metal'),
(34198, 5, 14, 4, 50000, 40, 15000, 20000, 11, 64968, 7, 'Iron Mender - Cast Fuse Metal');

-- Rune Etched Sentry
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34196;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34196;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34196, 0, 0, 2, 5000, 7000, 10000, 20000, 11, 64852, 5, 'Rune Etched Sentry - Cast Flaming Rune'),
(34196, 1, 0, 2, 5000, 10000, 10000, 15000, 11, 64870, 2, 'Rune Etched Sentry - Cast Lava Burst'),
(34196, 2, 0, 4, 5000, 10000, 10000, 15000, 11, 64991, 2, 'Rune Etched Sentry - Cast Lava Burst'),
(34196, 3, 0, 2, 7000, 10000, 10000, 15000, 11, 64847, 2, 'Rune Etched Sentry - Cast Runed Flame Jets'),
(34196, 4, 0, 4, 7000, 10000, 10000, 15000, 11, 64988, 2, 'Rune Etched Sentry - Cast Runed Flame Jets');

-- Chamber Overseer (TODO: Displacement Device)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34197;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34197;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `target_param1`, `target_param2`, `comment`) VALUES
(34197, 0, 0, 2, 10000, 15000, 10000, 20000, 11, 64820, 17, 10, 80, 'Chamber Overseer - Cast Devastating Leap'),
(34197, 1, 0, 4, 10000, 15000, 10000, 15000, 11, 64943, 17, 10, 80, 'Chamber Overseer - Cast Devastating Leap'),
(34197, 2, 0, 2, 5000, 10000, 10000, 15000, 11, 64825, 2, 0, 0, 'Chamber Overseer - Cast Staggering Roar'),
(34197, 3, 0, 4, 5000, 10000, 10000, 15000, 11, 64944, 2, 0, 0, 'Chamber Overseer - Cast Staggering Roar');

-- Dark Rune Ravager
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=33755;
DELETE FROM `smart_scripts` WHERE `entryorguid`=33755;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(33755, 0, 6, 2000, 2000, 2000, 2000, 11, 63615, 2, 'Dark Rune Ravager - Cast Ravage Armor');

-- Dark Rune Thunderer
UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry`=33754;
DELETE FROM `smart_scripts` WHERE `entryorguid`=33754;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(33754, 0, 0, 2, 3000, 3000, 2000, 3000, 11, 63612, 2, 'Dark Rune Thunderer - Cast Lightning Brand'),
(33754, 1, 0, 4, 3000, 3000, 2000, 3000, 11, 63673, 2, 'Dark Rune Thunderer - Cast Lightning Brand');

-- Arachnopod Destroyer
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34183;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34183;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34183, 0, 4, 6, 0, 0, 0, 0, 11, 64779, 2, 'Arachnopod Destroyer - Cast Charged Leap'),
(34183, 1, 0, 6, 5000, 10000, 10000, 15000, 11, 64717, 2, 'Arachnopod Destroyer - Cast Flame Spray'),
(34183, 2, 0, 6, 10000, 20000, 20000, 30000, 11, 64776, 2, 'Arachnopod Destroyer - Cast Machine Gun');

-- Clockwork Mechanic
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34184;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34184;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34184, 2, 6, 0, 50, 20000, 30000, 11, 64966, 1, 'Clockwork Mechanic - Cast Ice Turret');

-- Ice Turret (spawned by Clockwork Mechanics)
UPDATE `creature_template` SET `unit_flags`=`unit_flags` |4, `AIName`='SmartAI' WHERE `entry`=34224;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34224;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34224, 0, 0, 2, 2000, 5000, 15000, 30000, 11, 66346, 1, 'Ice Turret - Cast Ice Nova'),
(34224, 1, 0, 4, 2000, 5000, 15000, 30000, 11, 64919, 1, 'Ice Turret - Cast ce Nova');

-- TODO: Boomer XP-500

-- Champion of Hodir
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34133;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34133;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34133, 0, 0, 2, 10000, 15000, 10000, 15000, 11, 64639, 1, 'Champion of Hodir - Cast Stomp'),
(34133, 1, 0, 4, 10000, 15000, 10000, 15000, 11, 64652, 1, 'Champion of Hodir - Cast Stomp'),
(34133, 2, 0, 6, 15000, 20000, 15000, 20000, 11, 64649, 2, 'Champion of Hodir - Cast Freezing Breath');

-- Winter Jormungar
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34137;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34137;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34137, 0, 6, 5000, 10000, 5000, 10000, 11, 64638, 2, 'Winter Jormungar - Cast Acidic Bite');

-- Winter Revenant
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34134;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34134;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34134, 0, 0, 2, 5000, 15000, 10000, 15000, 11, 64642, 1, 'Winter Revenant - Cast Blizzard'),
(34134, 1, 0, 4, 5000, 15000, 10000, 15000, 11, 64653, 1, 'Winter Revenant - Cast Blizzard'),
(34134, 2, 4, 6, 0, 0, 0, 0, 11, 64644, 1, 'Winter Revenant - Cast Shield of the Winter Revenant'),
(34134, 3, 0, 6, 15000, 20000, 15000, 20000, 11, 64643, 1, 'Winter Revenant - Cast Whirling Strike');

-- Winter Rumbler
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=34135;
DELETE FROM `smart_scripts` WHERE `entryorguid`=34135;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES
(34135, 0, 0, 2, 5000, 10000, 10000, 15000, 11, 64645, 2, 'Winter Rumbler - Cast Cone of Cold'),
(34135, 1, 0, 4, 5000, 10000, 10000, 15000, 11, 64655, 2, 'Winter Rumbler - Cast Cone of Cold'),
(34135, 2, 0, 2, 10000, 20000, 10000, 20000, 11, 64647, 6, 'Winter Rumbler - Cast Snow Blindness'),
(34135, 3, 0, 4, 10000, 20000, 10000, 20000, 11, 64654, 6, 'Winter Rumbler - Cast Snow Blindness');

UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry` IN (34153, 33395);