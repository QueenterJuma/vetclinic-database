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

/*MULTI-TABLE BRANCH*/

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

-- JOIN TABLE Branch

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');


INSERT INTO specializations (species_id, vet_id)
SELECT species.id AS species_id, vets.id AS vet_id
FROM species, vets
WHERE (vets.name = 'William Tatcher' AND species.name = 'Pokemon')
   OR (vets.name = 'Stephanie Mendez' AND species.name IN ('Digimon','Pokemon'))
   OR (vets.name = 'Jack Harkness' AND species.name = 'Digimon');



INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES 
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24'),
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
    ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
    ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
    ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
    ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');