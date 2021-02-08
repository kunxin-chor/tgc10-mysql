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

/** JOINS **/

/* display the customerName of all customers and the first name, last name of their sales rep */
SELECT customerName, customers.salesRepEmployeeNumber, lastName, firstName FROM customers join employees
ON customers.salesRepEmployeeNumber = employees.EmployeeNumber

/* display the customerName, and the contact person's last name and firstname and phone, and the first name, last name  and phone
number of their respective sales rep */
SELECT customerName, contactFirstName, contactLastName, customers.phone as "Customer Phone", firstName, lastName, offices.phone as "Office Phone", extension from customers JOIN employees ON 
	customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices ON
	employees.officeCode = offices.officeCode
	
/* count the number of employees in the employees table */
-- SELECT COUNT(*) FROM employees;

/* count how many sales rep there are in the employees table */
-- SELECT * FROM employees where jobTitle = "Sales Rep"; 
SELECT count(*) FROM employees where jobTitle = "Sales Rep"; 

/* find the average credit limit of all my customers */
SELECT AVG(creditLimit) FROM customers;

/* find the max credit limit of all my customers */
SELECT MAX(creditLimit) FROM customers;

/* find the min credit limit of all my customers */
SELECT MIN(creditLimit) FROM customers;

/* find the sum of all the credit limit of all my customers */
SELECT SUM(creditLimit) FROM customers;

/* count how many employees in each office code */
select officeCode, count(*) from employees
group by officeCode

/* count how many employees there are in each office
and show the address of each office */
select offices.officeCode, addressLine1, addressLine2, count(*) from employees join offices on employees.officeCode = offices.officeCode
group by offices.officeCode, addressLine1, addressLine2

/* count how many emplyoees there are in office code 1, 2 and 3
and display the address of each office */
select offices.officeCode, addressLine1, addressLine2, count(*) from employees join offices on employees.officeCode = offices.officeCode
where offices.officeCode=1 or offices.officeCode=2 or offices.officeCode=3
group by offices.officeCode, addressLine1, addressLine2

/* show all customers and the total amount they have paid,
sorted in ascending order (from low to high) */
SELECT customerNumber, sum(amount) FROM payments
group by customerNumber 
order by sum(amount) 

/* the same as above, but sorted by descending order */
SELECT customerNumber, sum(amount) FROM payments
group by customerNumber 
order by sum(amount) DESC

/* same as above, but only the first 20 results */
SELECT customerNumber, sum(amount) FROM payments
group by customerNumber 
order by sum(amount) DESC
LIMIT 20

/* same as above, but only show groups that have >100K in
total payment made */
SELECT customerNumber, sum(amount) FROM payments
group by customerNumber 
having sum(amount) > 100000
order by sum(amount) DESC
LIMIT 20

/* Full-blown SQL statement */
/* Above, but only for customers from USA */
select customers.customerNumber, sum(amount) from payments JOIN customers
	ON payments.customerNumber = customers.customerNumber 
WHERE country = "USA"
GROUP BY customers.customerNumber
HAVING SUM(amount) > 50000
ORDER BY sum(amount) DESC
limit 5

/*
1. joins
2. where
3. group by
4. having
5. select
6. order by
7. limit

*/

-- create a new database named `it_fair`
create database it_fair;

-- switch database
use it_fair;

create table Laptops (
  laptop_id int unsigned auto_increment primary key,
  model_name varchar(100) not null,
  ram tinyint not null,
  cpu_clock_speed float not null,
  video_card varchar(200) not null,
  price float not null
) engine=innodb;

-- create the database
create database boardgamedb;

use boardgamedb;

create table boardgames (
    boardgame_id int unsigned auto_increment primary key,
    title varchar(200) not null,
    play_time int not null, 
    year_published int not null,
    description text not null,
    retail_price float not null
) engine=innodb;

insert into boardgames (title, play_time, year_published, description, retail_price)
  values ("Saints Petersburg", 90, 2004, "Help Czar Peter builds the grandest city ever", 30);

-- select all rows from the table
select * from boardgames;
select * from boardgames where true;

-- insert 2 or more rows with the same statement
insert into boardgames (title, play_time, year_published, description, retail_price)
  values ("Stone Age", 90, 2008, "Score the most point as the headman of your tribe!", 50 ),
  ("Quadropolis", 60, 2015, "Build the best city ever", 90);

create table Salepersons(
    id int unsigned auto_increment primary key,
    name varchar(50) not null,
    commission_rate float not null
)engine=innodb; 

create table Closed_deals(
    id int unsigned auto_increment primary key,
    deal_size float not null,
    customer_name varchar(100) not null,
    product_name varchar(100) not null,
    salesperson_id int unsigned not null,
    foreign key (salesperson_id) references Salepersons(id)
)engine=innodb;

-- insert the rows to create a relationship between Salesperson
-- and Closed_deals

insert into Salepersons (name, commission_rate) values ('Alan Tay', 0.05);
insert into Closed_deals(deal_size, customer_name, product_name, salesperson_id)
values (300000, "Phua Chua Kang", "Supercomputer", 1);

insert into Closed_deals(deal_size, customer_name, product_name, salesperson_id)
values (250000, "Moses Lim", "Cashless Vending Machine", 1);

insert into Salepersons(name, commission_rate) values
 ('Mandy Wikes', 0.09);

-- see the name and commission rate for  all salesperson and the deals that they have closed
select * from Salepersons join Closed_deals
 ON Salepersons.id=salesperson_id;

-- I want to see all the sales made by Alan Tay
-- and also see the commission rate for Alan Tay
select * from Salepersons join Closed_deals
 ON Salepersons.id=salesperson_id
WHERE Salepersons.id=1;

insert into Closed_deals (deal_size, customer_name, product_name, salesperson_id)
  values (4600000, 'Elon Musk', 'AI System', 2);

update Closed_deals set deal_size = 460000 where id=3 ;