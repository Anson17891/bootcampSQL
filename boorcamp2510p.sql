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
insert into persons values (5, 'Keith', 'Chan', 37, 'MK', null);

insert into persons values 
    (6, 'Kelly', 'Lau', 38, 'IT', null),
    (7, 'Steve', 'Cheung', 20, 'IT', null);

select * from persons;

-- Orders
-- id, order_no, amount, tran_date
-- decimal(8,2)-> max = 999999.99
-- date

create table orders(
    id int,
    order_no varchar(20),
    amount decimal(8,2),
    tran_date date
    );
    -- alter table orders modify order_no varchar(20);
    -- drop table orders;
    insert into orders (id, order_no, amount, tran_date) values (1, 'M202512180001',99.99, '2025-01-01');
    insert into orders (id, order_no, amount, tran_date) values (2, 'M202512180002',1999.5, '2025-01-01');
    insert into orders (id, order_no, amount, tran_date) values (3, 'M202512180003',2000, '2025-01-01');
    select * from orders;
    -- Java: boolean, Database: varchar(1)'Y'/'N'
    
-- update
	select * from orders;
    
    update orders set amount = amount * 0.9 where order_no = 'M202512180002'; -- 1.6ms (time consuming, but anyway(ツ))
    
    -- Keith Chan -> IT
    update persons set department = 'IT' where first_name = 'keith' and last_name = 'chan';
    select * from persons;
    
    -- update 2 fields in one statement
    -- Jenny lau -> HR, age->55;
    update persons set department = 'HR', age = 55 where first_name = 'Jenny' and last_name = 'Lau';
    select * from persons;
    -- select * from persons order by id asc;
    
-- alter table
  -- add column (!!null value after adding, )
  -- ~Java Double (wrapper class allow null)(this case safer the primitive)
  alter table persons add salary decimal(8,2);
  select * from persons;
  
update persons set salary = 25000 where first_name = 'Jenny' and last_name = 'Lau';
update persons set salary = 18000 where first_name = 'Oscar' and last_name = 'Chan';
update persons set salary = 37000 where first_name = 'Kelly' and last_name = 'Lau';

-- delete from / drop table
-- delete data / drop->remove table structure
  
-- Group By + Having

-- Aggregation Function
-- min/max/count/average/sum  /SD/median...
-- Many data -> single value (Aggregation)
-- Data (row in excel)
select salary from persons where first_name = 'Oscar' and last_name = 'Chan';
select salary from persons where last_name = 'Lau';
-- !sum
select sum(salary) from persons where last_name = 'Lau';

select * from persons;
-- select -> show columns/ where -> filter rows
-- group by -> groupping (only used for aggregate function)
-- syntax:  group by xxx, select xxx + agg function
-- count(salary) -> not count null
select department, sum(salary), max(salary), min(salary), count(salary), count(*), avg(salary) from persons group by department;

-- non sense but computable
select department, sum(salary) / count(*) from persons group by department;
select department, max(salary) + min(salary) from persons group by department;
select department, max(salary) + min(age) from persons group by department;

-- round(x, decimal places)
select department, round(sum(salary) / count(*), 2) from persons group by department;

-- where + group
select * from persons where age >= 30; -- filter out oscar and steve
select department, sum(salary) from persons group by department; -- all data group by
select department, sum(salary) from persons where age >= 30 group by department; -- filter out age>=30, then group by

-- "Group by" likely followed by agg func.
-- from notes ch.7 : select genre, sum(price)/count(*) from books group by genre;

select id, first_name, salary, department, 'hello' , 1 from persons; -- every row has 'hello' and 1
select department, count(1), count('hello'), count(*) from persons group by department; -- count(1) = count(*) = count('hello')

-- where -> group + having (filter group)
select department, sum(salary) as total_salary
from persons
where age >= 30
group by department
having count(1) > 2;  -- count(dept=IT) >2 , count(dept=HR)=2 so HR filtered out

-- by dept, max(salary) >= 30000 ,select count(1)
select department, max(salary) ,count(1) as staff_number
from persons
group by department
having max(salary) >= 30000; -- boolean.   Filter out HR where no one has >$30000/m

-- step1. where (filter row)
-- step2. group by + having (filter group)
-- step3. select group(s)

select max(total_salary)
from
(select department , sum(salary) as total_salary
from persons
group by department having max(salary) >= 20000) as result;







-- leet code 619
-- select max(num) as num
-- from
-- (select num
-- from MyNumbers
-- group by num
-- having count(*)=1) as result;
    