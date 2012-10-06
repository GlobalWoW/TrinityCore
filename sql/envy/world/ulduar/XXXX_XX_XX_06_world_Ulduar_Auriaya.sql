-- Yes, I know this is hack-like, but as long as it works.... :D
DELETE FROM `spell_group` WHERE `id`=64381;
DELETE FROM `spell_group_stack_rules` WHERE `group_id`=64381;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES (64381, 64381);
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (64381, 1);

-- Auriaya should be interruptible, due to Sentinel Blast
UPDATE `creature_template` SET `mechanic_immune_mask`=617298815 WHERE `entry` IN (33515);

-- Creature_text
DELETE FROM `script_texts` WHERE `npc_entry`=33515;
DELETE FROM `creature_text` WHERE `entry`=33515;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33515, 0, 0, 'Some things are better left alone!', 14, 0, 100, 0, 0, 15473, 'Auriaya SAY_AGGRO'),
(33515, 1, 0, 'The secret dies with you!', 14, 0, 100, 0, 0, 15474, 'Auriaya SAY_SLAY_1'),
(33515, 1, 1, 'There is no escape!', 14, 0, 100, 0, 0, 15475, 'Auriaya SAY_SLAY_2'),
(33515, 2, 0, 'Auriaya screams in agony.', 41, 0, 100, 0, 0, 15476, 'Auriaya SAY_DEATH'),
(33515, 3, 0, 'You waste my time!', 14, 0, 100, 0, 0, 15477, 'Auriaya SAY_BERSERK'),
(33515, 4, 0, 'Auriaya begins to cast Terrifying Screech.', 41, 0, 100, 0, 0, 0, 'Auriaya - EMOTE_FEAR'),
(33515, 5, 0, 'Auriaya begins to activate the Feral Defender!', 41, 0, 100, 0, 0, 0, 'Auriaya - EMOTE_DEFENDER');