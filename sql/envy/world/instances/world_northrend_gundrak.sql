-- CREATURE_TEXT (correct sound_id)
DELETE FROM `creature_text` WHERE `entry`=29304;
DELETE FROM `creature_text` WHERE `entry`=29305;
DELETE FROM `creature_text` WHERE `entry`=29306;

INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`sound`,`emote`,`comment`) VALUES
(29304,0,0,'Drakkari gonna kill anybody who trespass on these lands!',14,14443,0,'Slad''ran - SAY_AGGRO'),
(29304,1,0,'Ye not breathin''! Good.',14,14446,0,'Slad''ran - SAY_SLAY_01'),
(29304,1,1,'You scared now?',14,14447,0,'Slad''ran - SAY_SLAY_02'),
(29304,1,2,'I''ll eat you next, mon!',14,14448,0,'Slad''ran - SAY_SLAY_03'),
(29304,2,0,'I sssee now... Ssscourge wasss not... our greatessst enemy...',14,14449,0,'Slad''ran - SAY_DEATH'),
(29304,3,0,'Minions of the scale, heed my call!',14,14444,0,'Slad''ran - SAY_SUMMON_SNAKES'),
(29304,4,0,'Our thousand fangs gonna rend your flesh!',14,14445,0,'Slad''ran - SAY_SUMMON_CONSTRICTORS'),
(29304,5,0,'%s begins to cast Poison Nova!',41,0,0,'Slad''ran - EMOTE_NOVA'),

(29305,0,0,'We fought back da Scourge. What chance joo be thinkin'' JOO got?',14,14721,0,'Moorabi - SAY_AGGRO'),
(29305,1,0,'I crush you, cockroaches!',14,14725,0,'Moorabi - SAY_SLAY_01'),
(29305,1,1,'Who gonna stop me; you?',14,14726,0,'Moorabi - SAY_SLAY_02'),
(29305,1,2,'Not so tough now.',14,14727,0,'Moorabi - SAY_SLAY_03'),
(29305,2,0,'If our gods can die... den so can we...',14,14728,0,'Moorabi - SAY_DEATH'),
(29305,3,0,'Get ready for somethin''... much... BIGGAH!',14,14722,0,'Moorabi - SAY_TRANSFORM'),
(29305,4,0,'%s begins to transform!',41,0,0,'Moorabi - EMOTE_TRANSFORM'),
(29305,5,0,'Da ground gonna swallow you up!',14,14723,0,'Moorabi - SAY_QUAKE'),

(29306,0,0,'I''m gonna spill your guts, mon!',14,14430,0,'GalDarah - SAY_AGGRO'),
(29306,1,0,'What a rush!',14,14436,0,'GalDarah - SAY_SLAY_01'),
(29306,1,1,'Who needs gods, when WE ARE GODS!',14,14437,0,'GalDarah - SAY_SLAY_02'),
(29306,1,2,'I told ya so!',14,14438,0,'GalDarah - SAY_SLAY_03'),
(29306,2,0,'Even the mighty... can fall.',14,14439,0,'GalDarah - SAY_DEATH'),
(29306,3,0,'Gut them! Impale them!',14,14433,0,'GalDarah - SAY_SUMMON_RHINO_1'),
(29306,3,1,'KILL THEM ALL!',14,14434,0,'GalDarah - SAY_SUMMON_RHINO_2'),
(29306,3,2,'Say hello to my BIG friend!',14,14435,0,'GalDarah - SAY_SUMMON_RHINO_3'),
(29306,4,0,'Ain''t gonna be nottin'' left after this!',14,14431,0,'GalDarah - SAY_TRANSFORM_1'),
(29306,5,0,'You wanna see power? I''m gonna show you power!',14,14432,0,'GalDarah - SAY_TRANSFORM_2');
