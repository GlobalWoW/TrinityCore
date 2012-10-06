-- Creature_text
DELETE FROM `script_texts` WHERE `npc_entry` IN (32906, 32913, 32914, 32915);
DELETE FROM `creature_text` WHERE `entry` IN (32906, 32913, 32914, 32915);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(32906, 0, 0, 'The Conservatory must be protected!', 14, 0, 100, 0, 0, 15526, 'Freya SAY_AGGRO'),
(32906, 1, 0, 'Elders, grant me your strength!', 14, 0, 100, 0, 0, 15527, 'Freya SAY_AGGRO_WITH_ELDER'),
(32906, 2, 0, 'Forgive me.', 14, 0, 100, 0, 0, 15529, 'Freya SAY_SLAY_1'),
(32906, 2, 1, 'From your death springs life anew!', 14, 0, 100, 0, 0, 15530, 'Freya SAY_SLAY_2'),
(32906, 3, 0, 'His hold on me dissipates. I can see clearly once more. Thank you, heroes.', 14, 0, 100, 0, 0, 15531, 'Freya SAY_DEATH'),
(32906, 4, 0, 'You have strayed too far, wasted too much time!', 14, 0, 100, 0, 0, 15532, 'Freya SAY_BERSERK'),
(32906, 5, 0, 'Eonar, your servant requires aid!', 14, 0, 100, 0, 0, 15528, 'Freya SAY_SUMMON_CONSERVATOR'),
(32906, 6, 0, 'Children, assist me!', 14, 0, 100, 0, 0, 15533, 'Freya SAY_SUMMON_TRIO'),
(32906, 7, 0, 'The swarm of the elements shall overtake you!', 14, 0, 100, 0, 0, 15534, 'Freya SAY_SUMMON_LASHERS'),

(32915, 0, 0, 'Matron, the Conservatory has been breached!', 14, 0, 100, 0, 0, 15483, 'Elder Brightleaf SAY_AGGRO'),
(32915, 1, 0, 'Fertilizer.', 14, 0, 100, 0, 0, 15485, 'Elder Brightleaf SAY_SLAY_1'),
(32915, 1, 1, 'Your corpse will nourish the soil!', 14, 0, 100, 0, 0, 15486, 'Elder Brightleaf SAY_SLAY_2'),
(32915, 2, 0, 'Matron, one has fallen!', 14, 0, 100, 0, 0, 15487, 'Elder Brightleaf SAY_DEATH'),

(32913, 0, 0, 'Mortals have no place here!', 14, 0, 100, 0, 0, 15493, 'Elder Ironbranch SAY_AGGRO'),
(32913, 1, 0, 'I return you whence you came!', 14, 0, 100, 0, 0, 15494, 'Elder Ironbranch SAY_SLAY_1'),
(32913, 1, 1, 'BEGONE!', 14, 0, 100, 0, 0, 15495, 'Elder Ironbranch SAY_SLAY_2'),
(32913, 2, 0, 'Freya! They come for you.', 14, 0, 100, 0, 0, 15496, 'Elder Ironbranch SAY_DEATH'),

(32914, 0, 0, 'This place will serve as your graveyard.', 14, 0, 100, 0, 0, 15500, 'Elder Stonebark SAY_AGGRO'),
(32914, 1, 0, '<Angry roar>', 14, 0, 100, 0, 0, 15501, 'Elder Stonebark SAY_SLAY_1'),
(32914, 1, 1, 'Such a waste.', 14, 0, 100, 0, 0, 15502, 'Elder Stonebark SAY_SLAY_2'),
(32914, 2, 0, 'Matron, flee! They are ruthless....', 14, 0, 100, 0, 0, 15503, 'Elder Stonebark SAY_DEATH');