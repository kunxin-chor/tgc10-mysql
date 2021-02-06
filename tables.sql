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

/* CANNOT insert a pet for an non-existent pet owner */
insert into Pets (name, pet_owner_id) values ('Smaug', 100);
/* CANNOT delete a pet owner while they still have pets */
delete from PetOwners where pet_owner_id = 1;

/* Select columns from all rows in a table */
select * from employees;

/* select the lastName, firstName, email and jobTitle */
select lastName, firstName, email, jobTitle from employees;

/* only keep all the employees from officeCode 1 */
select * from employees where officeCode = 1;

/* onlly show all empployees that have job title 'Sales Rep' */
select * from employees where jobTitle = 'Sales Rep'

/* only show the first name, last name and email from all emplyoees that have the job title 'Sales Rep' */
select firstName, lastName, email from employees where jobTitle = "Sales Rep";

/* show all emplyoees who are sales rep in office code 1 */
select * from employees where officeCode = 1 and jobTitle='Sales Rep';

/* select all the employees from office code 1 and office code 2 */
SELECT * FROM employees where officeCode =1 or officeCode=2;

/* select all emplyoees from office code 2 and ONLY sales rep from office code 1 */
SELECT * FROM employees where officeCode =2 or officeCode=1 and jobTitle="Sales Rep";

/* select only sales rep from office code 1 and office code 2 */
select * from employees where (officeCode = 1 or officeCode =2 ) and jobTitle = "Sales Rep";

/* find all the customers from the USA with credit limit > 100000, or any customers from France */
select * from customers where country ="France" or country ="USA" and creditLimit > 100000;

/* find all customers with credit limit > 100000 and who are either France or USA */
select * from customers where (country = "France" or country="USA") and creditLimit > 100000;

/* find employees whose jobTitle begin with 'Sale'
SELECT * FROM employees WHERE jobTitle like 'Sale%'

/* find employees whose job title end with sales */
select * from employees where jobTitle like '%Sales' 

-- see all the employees with 'sales' in their title regardless of at the beginning or the end
select * from employees where jobTitle like "%sales%"

-- find all the orders where FedEx is referred to in the comments
select * from orders where comments like '%fedex%'

-- DATES
-- retrieve the year, month and day of a date column
SELECT orderNumber, YEAR(orderDate), MONTH(orderDate), DAY(orderDate) FROM orders;

-- see all the orders made in the year 2003
SELECT * from orders where YEAR(orderDate) = 2003;

-- see all the orders made in the year 2003 and in the month of Nov
select * from orders where YEAR(orderDate) = 2003 AND MONTH(orderDate) = 11

-- see all the orders place between these two dates
SELECT * from orders where orderDate BETWEEN 2003-01-01 AND 2003-02-28;

-- see all orders that take place 17 years ago
select * from orders where YEAR(CURDATE()) - YEAR(orderDate) = 17;

/* see all the payments that take place on the first day of every month */
SELECT * FROM payments where DAY(paymentDate) = 1;


/* see all the payments that take place in the month of June, 2004 */
select * from payments where year(paymentDate) = 2004 and month(paymentDate) = 6;

/* see all the payments that take place between June 2003 and August 2003 */
select * from payments where MONTH(paymentDate) >=6 and MONTH(paymentDate) <= 8 and YEAR(paymentDate)=2003;

/* display all employees' office code, firstName and lastName whose office is in NYC */
select employees.officeCode, firstName, lastName, city from employees join offices
 ON employees.officeCode = offices.officeCode
where city="NYC"