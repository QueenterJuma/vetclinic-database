/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int primary key not null,
    name varchar(100) not null,
    date_of_birth date not null,
    escape_attempts int not null,
    neutered bool not null,
    weight_kg decimal not null
);
ALTER TABLE animals ADD COLUMN species varchar(100);

/*MULTI-TABLE BRANCH*/

/* Create owners table */
CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY not null,
  full_name varchar(100),
  age INT,
  PRIMARY KEY(id)
);

/* Create species table */
CREATE TABLE species (
   id INT GENERATED ALWAYS AS IDENTITY not null,
    name varchar(100),
    PRIMARY KEY(id)
);

/* Modify animals table (ID already set to auto_increment while creating the table on line no.5) */
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id int;
ALTER TABLE animals ADD CONSTRAINT fk_name FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

-- JOIN TABLE Branch

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
  species_id INT,
  vet_id INT,
  PRIMARY KEY (species_id, vet_id),
  CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
  CONSTRAINT fk_vet FOREIGN KEY(vet_id) REFERENCES vets(id)
);

CREATE TABLE visits (
  animal_id INT,
  vet_id INT,
  date_of_visit DATE,
  PRIMARY KEY (animal_id, vet_id, date_of_visit),
  CONSTRAINT fk_animal FOREIGN KEY(animal_id) REFERENCES animals(id),
  CONSTRAINT fk_vet FOREIGN KEY(vet_id) REFERENCES vets(id)
);
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';