-- Ignis Flame_Jets target filtering
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62680, 63472);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62680, 'spell_ignis_flame_jets'),
(63472, 'spell_ignis_flame_jets');

-- Ignis Activate Construct targeting
DELETE FROM `spell_script_names` WHERE `spell_id`=62488;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62488, 'spell_ignis_activate_construct');

-- Ignis Iron Construct are spawned via scripts
DELETE FROM `creature` WHERE `id`=33121;

-- Creature text
DELETE FROM `script_texts` WHERE `npc_entry`=33118;
DELETE FROM `creature_text` WHERE `entry`=33118;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33118, 0, 0, 'Insolent whelps! Your blood will temper the weapons used to reclaim this world!', 14, 0, 100, 0, 0, 15564, 'Ignis SAY_AGGRO'),
(33118, 1, 0, 'More scraps for the scrapheap!', 14, 0, 100, 0, 0, 15569, 'Ignis SAY_SLAY_1'),
(33118, 1, 1, 'Your bones will serve as kindling!', 14, 0, 100, 0, 0, 15570, 'Ignis SAY_SLAY_2'),
(33118, 2, 0, 'I. Have. Failed.', 14, 0, 100, 0, 0, 15572, 'Ignis SAY_DEATH'),
(33118, 3, 0, 'Arise, soldiers of the Iron Crucible! The Makers'' will be done!', 14, 0, 100, 0, 0, 15565, 'Ignis SAY_SUMMON'),
(33118, 4, 0, 'I will burn away your impurities!', 14, 0, 100, 0, 0, 15566, 'Ignis SAY_SLAG_POT'),
(33118, 5, 0, 'Let the inferno consume you!', 14, 0, 100, 0, 0, 15567, 'Ignis SAY_SCORCH_1'),
(33118, 5, 1, 'BURN! Burn in the makers fire!', 14, 0, 100, 0, 0, 15568, 'Ignis SAY_SCORCH_2'),
(33118, 6, 0, 'Let it be finished!', 14, 0, 100, 0, 0, 15571, 'Ignis SAY_BERSERK'),
(33118, 7, 0, 'Ignis the Furnace Master begins to cast Flame Jets!', 41, 0, 100, 0, 0, 0, 'Ignis EMOTE_JETS');