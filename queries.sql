/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon'; 
SELECT *  FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT * FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 and 17.3;

/* update the animals table by setting the species column to unspecified */
-- Transaction 2
BEGIN;
update animals set species = 'unspecified';
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

-- Transaction 2 
BEGIN;
update animals set species = 'digimon' where name like '%mon';
update animals set species = 'pokemon' where species IS null;
SELECT * from animals;
COMMIT;
SELECT * from animals;

/* Delete all records in the animals table transaction 5 */
-- Transaction 3
BEGIN;
DELETE from animals;
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

-- Transaction 4
BEGIN;
DELETE from animals WHERE date_of_birth > '01-01-2022';
SAVEPOINT dob;
UPDATE animals SET weight_kg =weight_kg * -1;
ROLLBACK TO dob;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * from animals;

/* How many animals are there? */
SELECT COUNT(*) from animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) from animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) from animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, AVG(escape_attempts) AS avg_escape_attempts FROM animals GROUP BY neutered;


/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* What animals belong to Melody Pond? */
SELECT name, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

/* List animals that are pokemon. */
SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

/* List of owners and their animals, remember to include those that don't own any animal. */
SELECT name, full_name FROM animals FULL JOIN owners ON animals.owner_id = owners.id;

/* How many animals are there per species? */
SELECT COUNT(animals.name), species.name FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT owners.full_name, animals.name AS animal_name, species.name AS species_name FROM animals JOIN owners ON owners.id = animals.owner_id JOIN species ON species.id = animals.species_id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT name, escape_attempts, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0 AND full_name = 'Dean Winchester';

/* Who owns the most animals? */
SELECT full_name, COUNT(animals.owner_id) as total_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.id ORDER BY total_animals DESC LIMIT 1;