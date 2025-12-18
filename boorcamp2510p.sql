-- MySQL Workbench (Client Side)

-- SQL 
use sys; -- login database sys
create database bootcamp_2510p;
use bootcamp_2510p; -- login another database

-- One database has many tables

create table persons (
	id integer, 
    first_name varchar(50),-- database use harddisk->data not release->need to restrict string's length
    last_name varchar(50),
    age integer,
    department varchar(2)
);

-- * -> all columns
select * from persons;

-- 2-3 ways
insert into persons (id, first_name, last_name, age, department) values (1, 'John', 'Lau', 30, 'IT'); 
insert into persons (id, first_name, last_name, age, department) values (2, 'Leo', 'Wong', 48, 'HR');
insert into persons (id, first_name, last_name, age, department) values (3, 'Jenny', 'Lau', 50, 'MK');
insert into persons (id, first_name, last_name, age, department) values (4, 'Oscar', 'Chan', 23, 'IT');   

-- only show some columns
select first_name, age, department from persons;

-- where (select some rows in some conditions)
select * from persons where age > 35;

-- delete
-- delete all
-- delete from persons;
-- delete from persons where last_name = 'Lau';

-- AND OR
select * from persons where last_name = 'Lau' and department = 'IT';
select * from persons where last_name = 'Lau' or department = 'IT';
select * from persons where last_name = 'Lau' and department = 'IT' or age > 47; -- read from left
select * from persons where age > 47 or last_name = 'Lau' and department = 'IT';
select * from persons where (age > 47 or last_name = 'Lau') and department = 'IT';

select * from persons where department <> 'IT'; -- NOT EQUAL
select * from persons where age >= 48;
select * from persons where first_name = 'JENNY'; -- data -> case insensitive

-- static method
select concat(first_name, ' ', last_name) as full_name from persons;
select concat(p.first_name, ' ', p.last_name) as full_name, p.* from persons p;

-- W/o column names, have to places the values in correct sequence.
insert into persons values (5, 'Keith', 'Chan', 37, 'MK');

insert into persons values 
    (6, 'Kelly', 'Lau', 38, 'IT'),
    (7, 'Steve', 'Cheung', 20, 'IT');

select * from persons;

-- Orders
-- id, order_no, amount, tran_date
-- decimal(8,2)-> max = 999999.99
-- date