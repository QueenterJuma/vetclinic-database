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
VALUES 
('Sam Smith', 34), 
('Jennifer Orwell', 19), 
('Bob', 45), 
('Melody Pond', 77), 
('Dean Winchester', 14), 
('Jodie Whittaker', 38);

/* INSERT data into species table */
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

/* Update animals Table. */
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';


/* Update animals table to include owners infomation */
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';