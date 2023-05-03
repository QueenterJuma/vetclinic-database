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

/* Begin Transaction A */
BEGIN;

update animals set species = 'unspecified';

/* Verify that change was made */
SELECT * from animals;

/* Rollback changes */
ROLLBACK;

/* Verify changes */
SELECT * from animals;

/* Begin Transaction B */
BEGIN;

/* update species col for animals with names ending in mon */
update animals set species = 'digimon' where name like '%mon';

/* update species col for animals with names not ending in mon */
update animals set species = 'pokemon' where species IS null;

/* Confirm changes */
SELECT * from animals;

/* commit changes */
COMMIT;

/* Verify that change was made and persists after commit */
SELECT * from animals;

/* Delete all records in the animals table transaction C */
/* Begin Transaction C */
BEGIN;

/* delete all records */
DELETE from animals;

/* verify all records are deleted */
SELECT * from animals;

/* Rollback changes */
ROLLBACK;

/* verify all records still exist */
SELECT * from animals;

/* Begin Transaction D */
BEGIN;

/* Delete all animals born after Jan 1st, 2022. */
DELETE from animals WHERE date_of_birth > '01-01-2022';

/* create a savepoint */
SAVEPOINT dob;

/* update all animals' weights multiplied by -1 */
UPDATE animals SET weight_kg =weight_kg * -1;

/* roolback to savepoint */
ROLLBACK TO dob;

/* update all animals' weights that are negative multiplied by -1 */
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

/* commit the transaction */
COMMIT;

/* How many animals are there? */
SELECT COUNT(*) from animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) from animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) from animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, count(neutered) as result FROM animals GROUP BY neutered ORDER BY result DESC LIMIT 1;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
