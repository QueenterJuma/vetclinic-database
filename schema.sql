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
/* Create owners table */
CREATE TABLE owners (id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL, full_name varchar(100), age int);

/* Create species table */
CREATE TABLE species (id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL, name varchar(100));

/* Modify animals table (ID already set to auto_increment while creating the table on line no.5) */
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id int;
ALTER TABLE animals ADD CONSTRAINT fk_name FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);