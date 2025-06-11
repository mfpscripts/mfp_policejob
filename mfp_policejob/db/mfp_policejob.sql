-- if you dont already have it
INSERT INTO `licenses` (`type`, `label`) VALUES 
('weapon', 'Weapon');
------------------------------------------


CREATE TABLE IF NOT EXISTS `mfp_stocks` (
  `typ` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `mfp_stocks` (`typ`, `amount`) VALUES
	('WEAPON_NIGHTSTICK', 10),
	('WEAPON_FLASHLIGHT', 10),
	('WEAPON_STUNGUN', 11),
	('WEAPON_PISTOL50', 18),
	('WEAPON_COMBATPISTOL', 13),
	('WEAPON_PUMPSHOTGUN', 15),
	('WEAPON_COMBATPDW', 7),
	('WEAPON_SNIPERRIFLE', 0),
	('WEAPON_CARBINERIFLE', 4);


CREATE TABLE IF NOT EXISTS `mfp_policecars` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `owner_id` VARCHAR(64) NOT NULL,
    `vehicle_model` TEXT NOT NULL,
    `vehicle` TEXT NOT NULL,
    `plate` VARCHAR(10) NOT NULL,
    `mileage` FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS `mfp_policehelis` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `owner_id` VARCHAR(64) NOT NULL,
    `vehicle_model` TEXT NOT NULL,
    `vehicle` TEXT NOT NULL,
    `plate` VARCHAR(10) NOT NULL,
    `mileage` FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS `mfp_policeboats` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `owner_id` VARCHAR(64) NOT NULL,
    `vehicle_model` TEXT NOT NULL,
    `vehicle` TEXT NOT NULL,
    `plate` VARCHAR(10) NOT NULL,
    `mileage` FLOAT NOT NULL
);