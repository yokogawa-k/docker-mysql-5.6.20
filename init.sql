GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' with grant option;

CREATE DATABASE sample;
USE sample;
CREATE TABLE `new_table` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(45) DEFAULT NULL,
`age` tinyint(4) NOT NULL,
PRIMARY KEY (`id`),
KEY `name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

