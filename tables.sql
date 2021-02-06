# to go into MySQL
mysql -u root

# see all the existing databases
show databases;

# create a new database
create database hrm;

# switch the current active database
use hrm;

# see all the tables in the database
show tables;

create table Departments (
  department_id int unsigned auto_increment primary key,
  department_name varchar(200) not null,
  email varchar(200) not null
) engine=innodb;

create table PetOwners (
  pet_id int unsigned auto_increment primary key,
  fname varchar(30) not null,
  lname varchar(30) not null,
  email varchar(50) not null
) engine=innodb;

create table Medicines (
    medicine_id int unsigned auto_increment primary key,
    name varchar(50) not null,
    description text not null 
) engine = innodb;

create table Vets (
    vet_id int unsigned auto_increment primary key,
    fname varchar(30) not null,
    lname varchar(30) not null
) engine = innodb;

/* add a new column `office_number` to the Vets table */
alter table Vets add office_number varchar(20) not null;

/* see all the columns inside a table */
describe Vets;

/* to add new rows to a table */
insert into Vets (fname, lname, office_number)
 values ("Xavier", "Tan", "+65121212");

 /* select all the rows from a table */
 select * from Vets;

insert into PetOwners (fname, lname, email) values ("jamie", "kam", "jamie@kam.com");

/* insert many rows at one go */
insert into PetOwners (fname, lname, email) values 
    ("Harry", "Potter", "harry@somewhere.com"),
    ("Charile", "Brown", "charilebrown@goodgrief.com"),
    ("Mary", "Chan", "marychan@somewhere.com");

/* update rows in a table */
update PetOwners set fname='Jamie' where pet_id = 1;
update PetOwners set lname="Kam" where pet_id = 1;
/* set multiple columns at the same time *?
update PetOwners set fname="Jamie", lname="Kam" where pet_id = 1;

/* modify existing column */
alter table PetOwners rename column pet_id to pet_owner_id;

/* delete */
/* ALWAYS MAKE SURE YOU HAVE THE CRITERA PART FOR THE DELETE FROM!!! */
delete from PetOwners where pet_owner_id = 4;

/* delete an entire table */
drop table dummy;

create table Pets (
    pet_id int unsigned auto_increment primary key,
    name varchar(50) not null,
    pet_owner_id int unsigned not null,
    foreign key (pet_owner_id) references PetOwners(pet_owner_id)
) engine = innodb;

/* insert in one pet named Muffin and the pet_owner_id is 1
this means, the row with pet_onwer_id owns Muffin */
insert into Pets (name, pet_owner_id) values ('Muffin', 1);
insert into Pets (name, pet_owner_id) values ('Biscuit', 1);