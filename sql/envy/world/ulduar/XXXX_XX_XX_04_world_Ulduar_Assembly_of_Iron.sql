DELETE FROM `spell_script_names` WHERE `spell_id` IN (61902, 61911, 63495, 61920);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(61902, 'spell_steelbreaker_electrical_charge'),
(61911, 'spell_steelbreaker_static_disruption'),
(63495, 'spell_steelbreaker_static_disruption'),
(61920, 'spell_supercharge');

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10084,10087,10088,10418,10419,10089,10420,10421,10090,10422,10423,10091,10424,10425);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10084, 11, 0, 0, 'achievement_i_choose_you'), -- achievement 2941
(10084, 12, 0, 0, ''),
(10087, 11, 0, 0, 'achievement_i_choose_you_25'), -- achievement 2944
(10087, 12, 1, 0, ''),
(10088, 11, 0, 0, 'achievement_but_i_am_on_your_side'), -- achievement 2945
(10088, 12, 0, 0, ''),
(10418, 11, 0, 0, 'achievement_but_i_am_on_your_side'), -- achievement 2945
(10418, 12, 0, 0, ''),
(10419, 11, 0, 0, 'achievement_but_i_am_on_your_side'), -- achievement 2945
(10419, 12, 0, 0, ''),
(10089, 11, 0, 0, 'achievement_but_i_am_on_your_side_25'), -- achievement 2946
(10089, 12, 1, 0, ''),
(10420, 11, 0, 0, 'achievement_but_i_am_on_your_side_25'), -- achievement 2946
(10420, 12, 1, 0, ''),
(10421, 11, 0, 0, 'achievement_but_i_am_on_your_side_25'), -- achievement 2946
(10421, 12, 1, 0, ''),
(10090, 11, 0, 0, 'achievement_cant_do_that_while_stunned'), -- achievement 2947
(10090, 12, 0, 0, ''),
(10422, 11, 0, 0, 'achievement_cant_do_that_while_stunned'), -- achievement 2947
(10422, 12, 0, 0, ''),
(10423, 11, 0, 0, 'achievement_cant_do_that_while_stunned'), -- achievement 2947
(10423, 12, 0, 0, ''),
(10091, 11, 0, 0, 'achievement_cant_do_that_while_stunned_25'), -- achievement 2948
(10091, 12, 1, 0, ''),
(10424, 11, 0, 0, 'achievement_cant_do_that_while_stunned_25'), -- achievement 2948
(10424, 12, 1, 0, ''),
(10425, 11, 0, 0, 'achievement_cant_do_that_while_stunned_25'), -- achievement 2948
(10425, 12, 1, 0, '');

-- Stormcaller Brundir, immunities to stun and interrupt are gained infight.
UPDATE `creature_template` SET `mechanic_immune_mask`=617296767, `flags_extra`=1 WHERE `entry` IN (32857);

-- Creature_text
DELETE FROM `script_texts` WHERE `npc_entry` IN (32867, 32927, 32857);
DELETE FROM `creature_text` WHERE `entry` IN (32867, 32927, 32857);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(32867, 0, 0, 'You will not defeat the Assembly of Iron so easily, invaders!', 14, 0, 100, 0, 0, 15674, 'Steelbreaker SAY_AGGRO'),
(32867, 1, 0, 'So fragile and weak!', 14, 0, 100, 0, 0, 15675, 'Steelbreaker SAY_SLAY_1'),
(32867, 1, 1, 'Flesh... such a hindrance.', 14, 0, 100, 0, 0, 15676, 'Steelbreaker SAY_SLAY_2'),
(32867, 2, 0, 'You seek the secrets of Ulduar? Then take them!', 14, 0, 100, 0, 0, 15677, 'Steelbreaker SAY_POWER'),
(32867, 3, 0, 'My death only serves to hasten your demise.', 14, 0, 100, 0, 0, 15678, 'Steelbreaker SAY_DEATH_1'),
(32867, 3, 1, 'Impossible!', 14, 0, 100, 0, 0, 15679, 'Steelbreaker SAY_DEATH_2'),
(32867, 4, 0, 'This meeting of the Assembly of Iron is adjourned!', 14, 0, 100, 0, 0, 15680, 'Steelbreaker SAY_BERSERK'),

(32927, 0, 0, 'Nothing short of total decimation will suffice.', 14, 0, 100, 0, 0, 15657, 'Molgeim SAY_AGGRO'),
(32927, 1, 0, 'The world suffers yet another insignificant loss.', 14, 0, 100, 0, 0, 15658, 'Molgeim SAY_SLAY_1'),
(32927, 1, 1, 'Death is the price of your arrogance.', 14, 0, 100, 0, 0, 15659, 'Molgeim SAY_SLAY_2'),
(32927, 2, 0, 'Decipher this!', 14, 0, 100, 0, 0, 15660, 'Molgeim SAY_RUNE_DEATH'),
(32927, 3, 0, 'Face the lightning surge!', 14, 0, 100, 0, 0, 15661, 'Molgeim SAY_SUMMON'),
(32927, 4, 0, 'The legacy of storms shall not be undone.', 14, 0, 100, 0, 0, 15662, 'Molgeim SAY_DEATH_1'),
(32927, 4, 1, 'What have you gained from my defeat? You are no less doomed, mortals!', 14, 0, 100, 0, 0, 15663, 'Molgeim SAY_DEATH_2'),
(32927, 5, 0, 'This meeting of the Assembly of Iron is adjourned!', 14, 0, 100, 0, 0, 15664, 'Molgeim SAY_BERSERK'),

(32857, 0, 0, 'Whether the world''s greatest gnats or the world''s greatest heroes, you''re still only mortal!', 14, 0, 100, 0, 0, 15684, 'Brundir SAY_AGGRO'),
(32857, 1, 0, 'A merciful kill!', 14, 0, 100, 0, 0, 15685, 'Brundir SAY_SLAY_1'),
(32857, 1, 1, 'HAH!', 14, 0, 100, 0, 0, 15686, 'Brundir SAY_SLAY_2'),
(32857, 2, 0, 'Stand still and stare into the light!', 14, 0, 100, 0, 0, 15687, 'Brundir SAY_SPECIAL'),
(32857, 3, 0, 'Let the storm clouds rise and rain down death from above!', 14, 0, 100, 0, 0, 15688, 'Brundir SAY_FLIGHT'),
(32857, 4, 0, 'The power of the storm lives on...', 14, 0, 100, 0, 0, 15689, 'Brundir SAY_DEATH_1'),
(32857, 4, 1, 'You rush headlong into the maw of madness!', 14, 0, 100, 0, 0, 15690, 'Brundir SAY_DEATH_2'),
(32857, 5, 0, 'This meeting of the Assembly of Iron is adjourned!', 14, 0, 100, 0, 0, 15691, 'Brundir SAY_BERSERK'),
(32857, 6, 0, 'Stormcaller Brundir begins to Overload!', 41, 0, 100, 0, 0, 0, 'Brundir EMOTE_OVERLOAD');