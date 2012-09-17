-- Model of Razorscale
UPDATE `creature_model_info` SET `bounding_radius`=1.0 WHERE `modelid`=28787;

-- adding weapons to Expedition Trappers and Expedition Engineers
UPDATE `creature_template` SET `equipment_id`=1762 WHERE `entry`=34257;
UPDATE `creature_template` SET `equipment_id`=361 WHERE `entry`=34256;