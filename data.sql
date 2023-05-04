/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '02-03-20', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '01-01-18', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '01-17-21', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '05-12-17', 5, true, 11);
INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
(5,'Charmander', '02-08-2020', 0, false, -11), 
(6,'Plantmon', '11-15-2021', 2, true, -5.7), 
(7,'Squirtle', '04-02-1993', 3, false, -12.13), 
(8,'Angemon', '06-12-2005', 1, true, -45), 
(9,'Boarmon', '06-07-2005', 7, true, 20.4), 
(10,'Blossom', '10-13-1998', 3, true, 17), 
(11,'Ditto', '05-14-2022', 4, true, 22);

/* INSERT data into owners table */
INSERT INTO owners (full_name, age) 
VALUES ('Sam Smith', 34), 
('Jennifer Orwell', 19), 
('Bob', 45), 
('Melody Pond', 77), 
('Dean Winchester', 14), 
('Jodie Whittaker', 38);

/* INSERT data into species table */
INSERT INTO species (name) 
VALUES ('Pokemon'), 
('Digimon');

/* Update animals Table. */
UPDATE animals
SET species_id = CASE
WHEN name LIKE '%mon' THEN (select id from species where name = 'Digimon')
ELSE (select id from species where name = 'Pokemon')
END;


/* Update animals table to include owners infomation */

UPDATE animals
SET owner_id = CASE
WHEN name = 'Agumon' THEN (select id from owners where full_name = 'Sam Smith')
WHEN name IN ('Gabumon', 'Pikachu') THEN (select id from owners where full_name = 'Jennifer Orwell')
WHEN name IN ('Devimon', 'Plantmon') THEN (select id from owners where full_name = 'Bob')
WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (select id from owners where full_name = 'Melody Pond')
WHEN name IN ('Angemon', 'Boarmon') THEN (select id from owners where full_name = 'Dean Winchester')
ELSE NULL
END;