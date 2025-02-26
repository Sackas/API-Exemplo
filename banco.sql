CREATE TABLE `user` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
);
CREATE TABLE `movement` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
);
CREATE TABLE `personal_record` (
`id` int NOT NULL AUTO_INCREMENT,
`user_id` int NOT NULL,
`movement_id` int NOT NULL,
`value` FLOAT NOT NULL,
`date` DATETIME NOT NULL,
PRIMARY KEY (`id`)
);
ALTER TABLE `personal_record` ADD CONSTRAINT `personal_record_fk0` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);

ALTER TABLE `personal_record` ADD CONSTRAINT `personal_record_fk1` FOREIGN KEY (`movement_id`) REFERENCES `movement`(`id`);
INSERT INTO `user` (id,name) VALUES
(1,'Joao'),
(2,'Jose'),
(3,'Paulo');
INSERT INTO movement (id,name) VALUES
(1,'Deadlift'),
(2,'Back Squat'),
(3,'Bench Press');
INSERT INTO personal_record (id,user_id,movement_id,value,`date`) VALUES
(1,1,1,100.0,'2021-01-01 00:00:00.0'),
(2,1,1,180.0,'2021-01-02 00:00:00.0'),
(3,1,1,150.0,'2021-01-03 00:00:00.0'),
(4,1,1,110.0,'2021-01-04 00:00:00.0'),
(5,2,1,110.0,'2021-01-04 00:00:00.0'),
(6,2,1,140.0,'2021-01-05 00:00:00.0'),
(7,2,1,190.0,'2021-01-06 00:00:00.0'),
(8,3,1,170.0,'2021-01-01 00:00:00.0'),
(9,3,1,120.0,'2021-01-02 00:00:00.0'),
(10,3,1,130.0,'2021-01-03 00:00:00.0'),
(11,1,2,130.0,'2021-01-03 00:00:00.0'),
(12,2,2,130.0,'2021-01-03 00:00:00.0'),
(13,3,2,125.0,'2021-01-03 00:00:00.0'),
(14,1,2,110.0,'2021-01-05 00:00:00.0'),
(15,1,2,100.0,'2021-01-01 00:00:00.0'),
(16,2,2,120.0,'2021-01-01 00:00:00.0'),
(17,3,2,120.0,'2021-01-01 00:00:00.0');