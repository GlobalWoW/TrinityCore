UPDATE `creature_template` SET `modelid1`=169, `modelid2`=16946 WHERE `entry`=34854;
UPDATE `creature_template` SET `modelid1`=1126 WHERE `entry` IN (34606, 34649);
UPDATE `creature_template` SET `modelid1`=19725 WHERE `entry`=34854;
UPDATE `creature_template` SET `modelid2`=1126 WHERE `entry`=34660;
UPDATE `creature_template` SET `unit_flags`=`unit_flags` |32768, `dynamicflags`= `dynamicflags` |8,`type_flags`=`type_flags` |524288 WHERE `entry` IN (33329, 33995);
UPDATE `creature_template` SET `unit_flags`= 33554432 WHERE `entry`=33661;
UPDATE `creature_template` SET `speed_walk`= 1 WHERE `entry` IN (32865, 33147);
UPDATE `creature_template` SET `baseattacktime`= 2000 WHERE `entry`=33147;
UPDATE `creature_template` SET `modelid2`=16925 WHERE `entry`=32879;
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=32879;
UPDATE `creature_template` SET `unit_flags`=32768, `dynamicflags`=8 WHERE `entry` IN (32885,32883,32908,32907,32882,32886);
UPDATE `creature_template` SET `modelid1`=169, `modelid2`=16925 WHERE `entry` IN (33378, 32892);
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry` IN (33725, 33054);
UPDATE `creature_template` SET `unit_flags`=256 WHERE `entry` IN (32872, 32873, 32874);
UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry`=32879;
UPDATE `creature_template` SET `flags_extra`=0 WHERE `entry`=34143;
UPDATE `creature_template` SET `modelid1`= 1126 WHERE `entry` IN (33990,33991);
UPDATE `creature_template` SET `modelid2`= 1126 WHERE `entry` IN (33881,33882);
UPDATE `creature_template` SET `minlevel`=1, `maxlevel`=1 WHERE `entry`=33990;
UPDATE `creature_template` SET `modelid1`= 169 WHERE `entry` IN (34188,34189, 33233, 34129, 34153);
UPDATE `creature_template` SET `unit_flags`=16384 WHERE `entry`=33264;
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=33233;
UPDATE `creature_template` SET `modelid1`= 169, `modelid2`=23258 WHERE `entry` IN (33050, 33395, 33170, 33402);
UPDATE `creature_template` SET `modelid1`= 19725, `modelid2`=28549 WHERE `entry`=33292;
UPDATE `creature_template` SET `modelid1`= 1126, `modelid2`=28549 WHERE `entry`=34194;
UPDATE `creature_template` SET `mindmg`= 356, `maxdmg`=503, `minlevel`=76, `maxlevel`=76 WHERE `entry`=32879;
UPDATE `creature_template` SET `minlevel`=1, `maxlevel`=1, `faction_A`=35, `faction_H`=35, `mindmg`=2, `maxdmg`=2, `attackpower`=24, `dmg_multiplier`=1, `unit_flags`=0, `InhabitType`=3, `ScriptName`='npc_yogg_saron_encounter_controller' WHERE `entry`=29224;
UPDATE `creature` SET `spawndist`=0 WHERE `id`=32865;
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE `id`=32865;
UPDATE `gameobject_template` SET `flags`=16 WHERE `entry`=194312;
UPDATE `gameobject_template` SET `type`=0, `faction`=0, `data1`=1845, `data4`=33914 WHERE `entry`=194264;
UPDATE `gameobject_template` SET `flags`=48 WHERE `entry` IN (194912, 194914);
UPDATE `gameobject` SET `rotation2`=0, `spawntimesecs`=180, `animprogress`=255 WHERE `id`=194264;
DELETE FROM `gameobject_template` WHERE `entry`=194438;
DELETE FROM `gameobject` WHERE `id`=194438;
DELETE FROM `waypoint_data` WHERE `id` IN (34496, 34497);
DELETE FROM `creature` WHERE `id`=33856;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `position_x`, `position_y`, `position_z`, `spawntimesecs`, `curhealth`) VALUES 
(137621,33856,603,3,1,16925,2703.93,2569.32,364.397,180,4120),
(137622,33856,603,3,1,16925,2715.33,2569.23,364.397,180,4120),
(137623,33856,603,3,1,16925,2726.85,2569.28,364.397,180,4120),
(137624,33856,603,3,1,16925,2765.24,2534.38,364.397,180,4120),
(137625,33856,603,3,1,16925,2759.54,2544.3,364.397,180,4120),
(137626,33856,603,3,1,16925,2753.82,2554.22,364.397,180,4120),
(137627,33856,603,3,1,16925,2764.95,2604.11,364.397,180,4120),
(137628,33856,603,3,1,16925,2759.19,2594.26,364.397,180,4120),
(137629,33856,603,3,1,16925,2753.56,2584.3,364.397,180,4120);

UPDATE `gameobject_template` SET `type`=0, `faction`=0, `data1`=1845, `data4`=33914 WHERE `entry`=194264;
DELETE FROM `gameobject_scripts` WHERE `id`=55194;
UPDATE `gameobject` SET `rotation2`=0, `spawntimesecs`=180, `animprogress`=255 WHERE `id`=194264;