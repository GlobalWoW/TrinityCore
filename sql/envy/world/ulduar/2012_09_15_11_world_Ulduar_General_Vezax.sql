-- Creature_text
-- General Vezax
DELETE FROM `script_texts` WHERE `npc_entry` IN (33271, 33488);
DELETE FROM `creature_text` WHERE `entry` IN (33271, 33488);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33271, 0, 0, 'Your destruction will herald a new age of suffering!', 14, 0, 100, 0, 0, 15542, 'General Vezax SAY_AGGRO'),
(33271, 1, 0, 'You thought to stand before the legions of death... and survive?', 14, 0, 100, 0, 0, 15543, 'General Vezax SAY_SLAY_1'),
(33271, 1, 1, 'Defiance... a flaw of mortality.', 14, 0, 100, 0, 0, 15544, 'General Vezax SAY_SLAY_2'),
(33271, 2, 0, 'The black blood of Yogg-Saron courses through me! I. AM. UNSTOPPABLE!', 14, 0, 100, 0, 0, 15545, 'General Vezax SAY_SURGE_DARKNESS'),
(33271, 3, 0, 'Oh, what horrors await....', 14, 0, 100, 0, 0, 15546, 'General Vezax SAY_DEATH'),
(33271, 4, 0, 'Your defeat was inevitable!', 14, 0, 100, 0, 0, 15547, 'General Vezax SAY_BERSERK'),
(33271, 5, 0, 'Behold, now! Terror, absolute!', 14, 0, 100, 0, 0, 15548, 'General Vezax SAY_HARDMODE_ON'),
(33488, 6, 0, 'A cloud of saronite vapors coalesces nearby!', 41, 0, 100, 0, 0, 0, 'Saronite Vapor EMOTE_VAPOR'),
(33271, 7, 0, 'The saronite vapors mass and swirl violently, merging into a monstrous form!', 41, 0, 100, 0, 0, 0, 'General Vezax EMOTE_ANIMUS'),
(33271, 8, 0, 'A saronite barrier appears around General Vezax!', 41, 0, 100, 0, 0, 0, 'General Vezax EMOTE_BARRIER'),
(33271, 9, 0, 'General Vezax roars and surges with dark might!', 41, 0, 100, 0, 0, 0, 'General Vezax EMOTE_SURGE_OF_DARKNESS');