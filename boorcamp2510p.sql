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
    
-- -------------------------------------------------------
-- ONE TO MANY
create table departments (
 id int primary key, -- unique, not null
 dep_name varchar(30));
 select * from departments;

create table employees (
 id int primary key,
 emp_name varchar(50),
 join_date date,
 dep_id int not null, -- cannot be null  **Important, most case need**
 foreign key (dep_id) references departments (id) -- link two table + ensure employees dep_id exists in department  (two keys must same type) -> defensive movement
);
select * from employees;

-- drop table departments;
-- drop table employees;

insert into departments values (1,'IT'); -- id must insert first before dept_id insert
-- insert into departments values (1, 'MK'); -- error-> duplicate 
insert into departments values (2, 'MK');

insert into employees values(1,'john','2025-10-01',1);  -- how to ensure dep_id has '1' in table department id-> primary key (see line179) + foreign key (line 188)
-- insert into employees values(2,'leo','2025-10-02', null); -- error -> dep_id int not null
insert into employees values(2,'leo','2025-10-02', 2);

-- ----------------------------
-- MANY TO MANY
-- Students vs Courses

create table students (
id int primary key,
stu_name varchar(30) not null
);
create table courses (
id int primary key,
course_name varchar(30) not null
);
create table student_courses (
id int primary key, -- ~transection num
reg_date date not null,
stu_id int not null,
course_id int not null,
foreign key (stu_id) references students (id),
foreign key (course_id) references courses (id)
);
-- PK, FK
insert into students values (1,'leo');
insert into students values (2,'Jenny');

insert into courses values (1,'MATH');
insert into courses values (2,'ENGLISH');
insert into courses values (3,'CHINESE');

insert into student_courses values (1, '2025-08-25', 1,2); -- Leo takes eng
insert into student_courses values (2, '2025-08-25', 1,3);
insert into student_courses values (3, '2025-08-30', 2,1);
insert into student_courses values (4, '2025-08-30', 2,2);

select * from student_courses;

-- ---------------
-- INNER JOIN (SQL)    table A's data multiply table B's data
select * from departments;
select * from employees; -- 

select d.*, e.* 
from departments d inner join employees e on e.dep_id = d.id; -- **on -> restrict data by conditions** / combine two columns from two tables

select e.id as emp_id,
d.id as dep_id,
e.emp_name,
d.dep_name,
e.join_date
from departments d inner join employees e on e.dep_id = d.id;

-- Student courses
select r.id as reg_id,
r.reg_date,
s.id as stu_id,
s.stu_name,
c.id as courses_id,
c.course_name
from student_courses r
 inner join students s on s.id=r.stu_id
 inner join courses c on c.id=r.course_id;
 
 select * from student_courses;
 select * from students;
 
 -- ----------------------------------------
 -- One to One
 -- Table A 3 columns (frequently queried) (Username, Password)
 -- Table B 4 columns (less frequently queried) (Profile pic)   separate to 2 table-> no need to read all 3 data->save time
 
 -- Table C 7 columns (Username, Password, Profile pic) or just combine all, depends on design
 -- ----------------------------------------
 -- check -> constrin insert column's data, but time consuming
 -- eg. salary decimal(10,2) check salary>0
 
 -- default
 -- deu_date date default '1970-01-01'
 -- -------------------------------------
 -- left join/right join
 -- left join where xxx is null
 -- full outer join
 -- ------------------------------------
 -- string method
 select concat(first_name, ' ', last_name) from persons;
 select substring(first_name, 1, 4) from persons; -- start from 1 (java from 0)
 select length(first_name), length(last_name) from persons;
 select upper(first_name) , lower(last_name) from persons;
 select trim(first_name) from persons;
 select replace(first_name, 'J', 'X')from persons;
 
 insert into persons values (8, '小明', '陳', 26, 'MK', 28000);
 select length(first_name),p.* from persons p; -- !!!!! **Chinese character ~ 3-4 length**
 select char_length(first_name),p.* from persons p; -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
 select instr(first_name,'J'), p.* from persons p; -- instr = indexOf(), if not exist->0 (java =-1)
 