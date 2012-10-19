-- ScriptAI for Trashmobs in ICC

UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` IN (37011, 36811, 37007, 36724, 37012, 36725, 36805, 36808, 36807, 3681, 36829, 37098, 37022, 37038, 10404, 37023, 36880, 37664, 37595, 37663, 37901, 37571, 37662, 37666, 37665, 38125, 37127, 37132, 37134);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (37011, 36811, 37007, 36724, 37012, 36725, 36805, 36808, 36807, 3681, 36829, 37098, 37022, 37038, 10404, 37023, 36880, 37664, 37595, 37663, 37901, 37571, 37662, 37666, 37665, 38125, 37127, 37132, 37134, 37133);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
/* Servant of the Throne */
(36724, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 12000, 11, 71029, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Servant of the Throne - Glacial Blast'),
/* Deathbound Ward */
(37007, 0, 0, 0, 0, 0, 100, 0, 12000, 15000, 15000, 15000, 11, 71022, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathbound Ward - Disrupting Shout'),
(37007, 0, 1, 0, 0, 0, 100, 0, 7000, 7000, 7000, 7000, 11, 71021, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'Deathbound Ward - Saber Lash'),
/* Ancient Skeletal Soldier */
(37012, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 70964, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ancient Skeletal Soldier - Shield Bash'),
/* Nerubar Broodkeeper */
(36725, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 8000, 8000, 11, 70965, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Crypt Scarabs'),
(36725, 0, 1, 0, 0, 0, 100, 8, 5000, 5000, 5000, 5000, 11, 71020, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Dark Mending'),
(36725, 0, 2, 0, 0, 0, 100, 16, 8000, 8000, 8000, 8000, 11, 71020, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Dark Mending'),
(36725, 0, 3, 0, 0, 0, 100, 8, 5000, 5000, 5000, 5000, 11, 70980, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Web Wrap'),
(36725, 0, 4, 0, 0, 0, 100, 16, 8000, 8000, 8000, 8000, 11, 70980, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Web Wrap'),
/* Deathspeaker Servant */
(36805, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 15000, 11, 69405, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Consuming Shadows'),
(36805, 0, 1, 0, 0, 0, 100, 8, 2000, 2000, 3000, 4000, 11, 69576, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Chaos Bolt'),
(36805, 0, 2, 0, 0, 0, 100, 16, 2000, 2000, 3000, 4000, 11, 71108, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Chaos Bolt'),
(36805, 0, 3, 0, 0, 0, 100, 8, 3000, 5000, 15000, 20000, 11, 69404, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Curse of Agony'),
(36805, 0, 4, 0, 0, 0, 100, 16, 3000, 5000, 15000, 20000, 11, 71112, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Curse of Agony'),
/* Deathspeaker Zealot */
(36808, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 6000, 6000, 11, 69492, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Zealot - Shadow Cleave'),
/* Deathspeaker Disciple */
(36807, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 15000, 11, 69391, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Dark Blessing'),
(36807, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 3000, 7000, 11, 69387, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Bolt'),
(36807, 0, 2, 0, 0, 0, 100, 8, 5000, 10000, 8000, 10000, 11, 69389, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Mend'),
(36807, 0, 3, 0, 0, 0, 100, 16, 3000, 5000, 5000, 8000, 11, 69389, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Mend'),
/* Deathspeaker Attendant */
(36811, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 3000, 5000, 11, 69387, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Bolt'),
(36811, 0, 1, 0, 0, 0, 100, 8, 5000, 10000, 5000, 10000, 11, 69355, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Nova'),
(36811, 0, 2, 0, 0, 0, 100, 16, 5000, 8000, 5000, 10000, 11, 71106, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Nova'),
/* Deathspeaker High Priest */
(36829, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 12000, 18000, 11, 69491, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Aura of Darkness'),
(36829, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 10000, 12000, 11, 69483, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Dark Reckoning'),
/* Valkyr Herald */
(37098, 0, 0, 0, 0, 0, 100, 8, 1000, 1000, 2000, 8000, 11, 71906, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Valkyr Herald - Shadow Nova'),
(37098, 0, 1, 0, 0, 0, 100, 16, 1000, 1000, 2000, 8000, 11, 71942, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Valkyr Herald - Shadow Nova'),
/* Blighted Abomination */
(37022, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 6000, 6000, 11, 40504, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Cleave'),
(37022, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 71150, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Plague Cloud'),
(37022, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 12000, 20000, 11, 71140, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Scourge Hook'),
/* Vengeful Fleshreaper */
(37038, 0, 0, 0, 0, 0, 100, 0, 3000, 20000, 20000, 40000, 11, 71164, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Fleshreaper - Leaping Face Maul'),
(37038, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 5000, 8000, 11, 71203, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Fleshreaper - Soul Feast'),
/* Pustulating Horror */
(10404, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 5000, 5000, 11, 71088, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Blight Bomb'),
(10404, 0, 1, 0, 0, 0, 100, 8, 2000, 2000, 15000, 20000, 11, 71089, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Bubbling Pus'),
(10404, 0, 2, 0, 0, 0, 100, 16, 2000, 2000, 15000, 20000, 11, 71090, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Bubbling Pus'),
/* Plague Scientist */
(37023, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 8000, 12000, 11, 71103, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Combobulating Spray'),
(37023, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 2000, 3000, 11, 73079, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Plague Blast'),
(37023, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 15000, 20000, 11, 69871, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Plague Stream'),
/* Decaying Colossus */
(36880, 0, 0, 0, 0, 0, 100, 8, 5000, 5000, 15000, 25000, 11, 71114, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Decaying Colossus - Massive Stomp'),
(36880, 0, 1, 0, 0, 0, 100, 16, 5000, 5000, 15000, 25000, 11, 71115, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Decaying Colossus - Massive Stomp'),
/* Darkfallen Archmage */
(37664, 0, 0, 0, 0, 0, 100, 0, 9000, 12000, 15000, 18000, 11, 70410, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Polymorph Spider'),
(37664, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Siphon Essence'),
(37664, 0, 2, 0, 0, 0, 100, 8, 10000, 15000, 15000, 20000, 11, 70408, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Amplify Magic'),
(37664, 0, 3, 0, 0, 0, 100, 8, 8000, 10000, 10000, 20000, 11, 70407, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Blast Wave'),
(37664, 0, 4, 0, 0, 0, 100, 8, 2000, 2000, 3000, 4000, 11, 70409, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Fireball'),
(37664, 0, 5, 0, 0, 0, 100, 16, 10000, 15000, 10000, 15000, 11, 72336, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Amplify Magic'),
(37664, 0, 6, 0, 0, 0, 100, 16, 8000, 10000, 10000, 20000, 11, 71151, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Blast Wave'),
(37664, 0, 7, 0, 0, 0, 100, 16, 2000, 2000, 2000, 3000, 11, 71153, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Fireball'),
/* Darkfallen Blood Knight */
(37595, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 32000, 37000, 11, 70450, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Blood Mirror'),
(37595, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Siphon Essence'),
(37595, 0, 2, 0, 0, 0, 100, 0, 2000, 3000, 3000, 4000, 11, 70437, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Unholy Strike'),
(37595, 0, 3, 0, 0, 0, 100, 0, 12000, 15000, 12000, 15000, 11, 71736, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Vampiric Aura'),
/* Darkfallen Noble */
(37663, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 20000, 25000, 11, 70645, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Chains of Shadow'),
(37663, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Siphon Essence'),
(37663, 0, 2, 0, 0, 0, 100, 8, 3000, 5000, 4000, 5000, 11, 72960, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Shadow Bolt'),
(37663, 0, 3, 0, 0, 0, 100, 16, 3000, 5000, 3000, 4000, 11, 72961, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Shadow Bolt'),
/* Vampiric Fiend */
(37901, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 41290, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Fiend - Disease Cloud'),
(37901, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 70671, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Fiend - Leeching Rot'),
/* Darkfallen Advisor */
(37571, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 15000, 20000, 11, 72065, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Shroud of Protection'),
(37571, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 20000, 11, 72066, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Shroud of Spell Warding'),
(37571, 0, 2, 0, 0, 0, 100, 8, 2000, 5000, 10000, 10000, 11, 72057, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Lich Slap'),
(37571, 0, 3, 0, 0, 0, 100, 16, 2000, 5000, 5000, 8000, 11, 72421, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Lich Slap'),
/* Darkfallen Commander*/
(37662, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 70750, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Battle Shout'),
(37662, 0, 1, 0, 0, 0, 100, 8, 4000, 8000, 10000, 15000, 11, 70449, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Vampire Rush'),
(37662, 0, 2, 0, 0, 0, 100, 16, 4000, 8000, 10000, 15000, 11, 71155, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Vampire Rush'),
/* Darkfallen Tactician */
(37666, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 15000, 25000, 11, 70432, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Blood Sap'),
(37666, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 6000, 6000, 11, 70437, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Unholy Strike'),
(37666, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 15000, 20000, 11, 70431, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Shadowstep'),
/* Darkfallen Lieutenant */
(37665, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 10000, 20000, 11, 70423, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Vampiric Curse'),
(37665, 0, 1, 0, 0, 0, 100, 8, 1000, 2000, 25000, 25000, 11, 70435, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Rend Flesh'),
(37665, 0, 2, 0, 0, 0, 100, 16, 1000, 2000, 25000, 25000, 11, 71154, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Rend Flesh'),
/* Ymirjar Deathbringer */
(38125, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 25000, 11, 71298, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Banish'),
(38125, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 69929, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Spirit Stream'),
(38125, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 71303, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Summon Ymirjar'),
(38125, 0, 3, 0, 0, 0, 100, 8, 10000, 15000, 15000, 25000, 11, 71299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Deaths Embrace'),
(38125, 0, 4, 0, 0, 0, 100, 8, 1000, 2000, 2000, 2000, 11, 71300, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Shadow Bolt'),
(38125, 0, 5, 0, 0, 0, 100, 16, 5000, 10000, 15000, 20000, 11, 71296, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Deaths Embrace'),
(38125, 0, 6, 0, 0, 0, 100, 16, 1000, 2000, 2000, 2000, 11, 71297, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Shadow Bolt'),
/* Ymirjar Frostbinder */
(37127, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3000, 5000, 11, 71274, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Frozen Orb'),
/* Ymirjar Huntress */
(37134, 0, 0, 0, 0, 0, 100, 0, 5000, 30000, 25000, 25000, 11, 71249, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Ice Trap'),
(37134, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 25000, 25000, 11, 71251, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Rapid Shot'),
(37134, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 1000, 1000, 11, 71253, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Shoot'),
(37134, 0, 3, 0, 0, 0, 100, 0, 5000, 10000, 15000, 25000, 11, 71252, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Volley'),
(37134, 0, 4, 0, 0, 16, 100, 0, 1000, 2000, 25000, 25000, 11, 71705, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Summon Warhawk'),
/* The Damned */
(37011, 0, 0, 0, 6, 0, 100, 1, 0, 0, 0, 0, 11, 70961, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Shattered Bones on death'),
(37011, 0, 1, 0, 2, 0, 100, 0, 5, 30, 15000, 20000, 75, 70960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Bone Flurry at 5-30%'),
/* Ymirjar Warlord */
(37133, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 12000, 20000, 11, 41056, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Warlord - Whirlwind');



/* NEED TEST */
/*
-- Here are some modifications to the actual spiders and the backup
UPDATE creature
SET position_z='4'
WHERE ID='36725'
-- UPDATE creature SET position_z='80' WHERE ID='36725'
 
 
-- Here are the trigger implementations in creature and creature_template table
-- Replace XXXXX with what value you want in your creature_template
 
SET @ENTRY := 314365;
SET @SOURCETYPE := 0;
 
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags)
VALUES(@ENTRY*100+1, @ENTRY, 631, 3, 1, 0, 0, -220.382, 2177.07, 37.9852, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0),
(@ENTRY*100+2, @ENTRY, 631, 3, 1, 0, 0, -220.382, 2245.79, 37.9852, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0),
(@ENTRY*100+3, @ENTRY, 631, 3, 1, 0, 0, -250.402 , 2202.06 , 42.5644, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0),
(@ENTRY*100+4, @ENTRY, 631, 3, 1, 0, 0, -250.402 , 2219.13, 42.5644, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0),
(@ENTRY*100+5, @ENTRY, 631, 3, 1, 0, 0, -211.498 , 2219.28 , 35.2236, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0),
(@ENTRY*100+6, @ENTRY, 631, 3, 1, 0, 0, -211.498 , 2202.06, 35.2236, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0),
(@ENTRY*100+7, @ENTRY, 631, 3, 1, 0, 0, -310.327, 2202.06, 42.0143, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0),
(@ENTRY*100+8, @ENTRY, 631, 3, 1, 0, 0, -310.327, 2219.13, 42.0143, 0.855211, 86400, 0, 0, 99999999, 9999999, 0, 0, 0, 0);
-- DELETE FROM creature WHERE `id`=@ENTRY
 
INSERT INTO Creature_template
VALUES (@ENTRY, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'NerubAr Trigger', '', '', 0, 1, 1, 0, 14, 14, 0, 1, 1.14286, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 33554432, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2147483647, 0, '', 0);
-- DELETE FROM creature_template WHERE `entry`=@ENTRY
 
-- Here is the SAI for the trigger, after finishing it's purpose it will kill itself and it will respawn just like other mobs, after 1 hour
 
-- NerubAr Trigger
 
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,@SOURCETYPE,0,0,4,0,100,0,0,0,0,0,12,36725,7,300000,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"nerub aggro"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,2000,3000,0,0,37,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"trigger die");
-- DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
*/