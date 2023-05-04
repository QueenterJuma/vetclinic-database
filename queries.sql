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

/*MULTI-TABLE BRANCH*/

-- What animals belong to Melody Pond?
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id where owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id where species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name from owners FULL JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY  species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON owners.id = animals.owner_id 
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id 
where owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name AS name, COUNT(*) AS animal_count 
FROM animals JOIN owners ON animals.owner_id = owners.id
GROUP BY  owners.full_name ORDER BY animal_count DESC LIMIT 1;


-- JOIN TABLE Branch

-- Who was the last animal seen by William Tatcher?
SELECT name FROM
 ((SELECT animal_id, date_of_visit 
 FROM ((SELECT id FROM vets WHERE name = 'William Tatcher') vets 
 JOIN visits ON vets.id = visits.vet_id)) will_vets
 JOIN animals ON will_vets.animal_id = animals.id) as visit
 ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT name FROM
 ((SELECT animal_id, date_of_visit 
 FROM ((SELECT id FROM vets WHERE name = 'Stephanie Mendez') vets 
 JOIN visits ON vets.id = visits.vet_id)) will_vets
 JOIN animals ON will_vets.animal_id = animals.id) as visit;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name as specialties
FROM vets
FULL JOIN specializations ON vets.id = specializations.vet_id
FULL JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT name FROM
 ((SELECT animal_id, date_of_visit 
 FROM ((SELECT id FROM vets WHERE name = 'Stephanie Mendez') vets 
 JOIN visits ON vets.id = visits.vet_id)) will_vets
 JOIN animals ON will_vets.animal_id = animals.id) as visit
 WHERE date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, Count(*) AS total_visits
FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY total_visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT name FROM
 ((SELECT animal_id, date_of_visit 
 FROM ((SELECT id FROM vets WHERE name = 'Maisy Smith') vets 
 JOIN visits ON vets.id = visits.vet_id)) will_vets
 JOIN animals ON will_vets.animal_id = animals.id) as visit
 ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT *
FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits JOIN
(SELECT vets.id
FROM vets
FULL JOIN specializations ON vets.id = specializations.vet_id
FULL JOIN species ON species.id = specializations.species_id
WHERE specializations.species_id IS NULL) vet 
ON vet.id = visits.vet_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT name, COUNT(*) AS total
FROM (SELECT animals.species_id FROM (SELECT id FROM vets WHERE name = 'Maisy Smith') as vet
JOIN visits ON visits.vet_id = vet.id
JOIN animals ON animals.id = visits.animal_id) as all_visits
JOIN species ON all_visits.species_id = species.id
GROUP BY name 
ORDER BY total DESC LIMIT 1;
