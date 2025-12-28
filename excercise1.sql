create database excercise1;
use excercise1;
-- create tables
create table regions(
region_id int primary key,
region_name varchar(25)
);
create table countries(
country_id varchar(2) primary key,
country_name varchar(40),
region_id int,
foreign key (region_id) references regions (region_id)
);
create table locations(
location_id int primary key,
street_address varchar(25),
postal_code varchar(12),
city varchar(30),
state_province varchar(12),
country_id varchar(2),
foreign key (country_id) references countries (country_id)
);
create table departments(
department_id int primary key,
department_name varchar(30),
manager_id int,
location_id int,
foreign key (location_id) references locations (location_id)
);
create table jobs(
job_id varchar(20) primary key,
job_title varchar(35),
min_salary int,
max_salary int
);
create table employees(
employee_id int primary key,
first_name varchar(20),
last_name varchar(25),
email varchar(25),
phone_number varchar(20),
hire_date date,
job_id varchar(10),
salary int,
commission_pct int,
manager_id int,
department_id int,
foreign key (job_id) references jobs (job_id),
foreign key (department_id) references departments (department_id)
);
create table job_history(
employee_id int,
start_date date,
end_date date,
job_id varchar(10),
department_id int,
primary key (employee_id, start_date),
foreign key (job_id) references jobs (job_id),
foreign key (department_id) references departments (department_id)
);
-- testing
select * from regions;
select * from countries;
select * from locations;
select * from departments;
select * from jobs;
select * from employees;
select * from job_history;
-- insert datas
insert into regions (region_id, region_name) values (1, 'Europe');
insert into regions (region_id, region_name) values (2, 'America');
insert into regions (region_id, region_name) values (3, 'Asia');

insert into countries (country_id, country_name, region_id) values ('DE', 'Germany', 1);
insert into countries (country_id, country_name, region_id) values ('IT', 'Italy', 1);
insert into countries (country_id, country_name, region_id) values ('JP', 'Japan', 3);
insert into countries (country_id, country_name, region_id) values ('US', 'United State', 2);

insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (1000, '1297 Via cola fi di rie', 989, 'Roma' , null, 'IT');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (1100, '93091 Calle della Te', 10934, 'Venice' , null, 'IT');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (1200, '2017 Shinjuku-ku', 1689, 'Tokyo' ,'Totyo', 'JP');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (1400, '2014 Jabberwocky Rd ', 26192, 'Southlake' , 'Texas', 'US');

insert into departments (department_id, department_name, manager_id, location_id) values (10, 'Administration', 200, 1100);
insert into departments (department_id, department_name, manager_id, location_id) values (20, 'Marketing', 201, 1200);
insert into departments (department_id, department_name, manager_id, location_id) values (30, 'Purchasing', 202, 1400);

insert into jobs (job_id, job_title, min_salary, max_salary) values ('ST_CLERK', 'Clerk', 20000, 30000);
insert into jobs (job_id, job_title, min_salary, max_salary) values ('MK_REP', 'Reprecentant', 7000, 30000);
insert into jobs (job_id, job_title, min_salary, max_salary) values ('IT_PROG', 'Programmer', 15000, 30000);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) 
values (100, 'Steven', 'King', 'SKING', '515-1234567', '1987-06-17', 'ST_CLERK', 24000.00, 0.00, 109, 10);
insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) 
values (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515-1234568', '1987-06-18', 'MK_REP', 17000.00, 0.00, 103, 20);
insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) 
values (102, 'Lex', 'De Haan', 'LDEHAAN', '515-1234569', '1987-06-19', 'IT_PROG', 17000.00, 0.00, 108, 30);
insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) 
values (103, 'Alexander', 'Hunold', 'AHUNOLD', '590-4234567', '1987-06-20', 'MK_REP', 9000.00, 0.00, 105, 20);

insert into job_history (employee_id, start_date, end_date, job_id, department_id) values (102, '1993-01-13', '1998-07-24', 'IT_PROG',20);
insert into job_history (employee_id, start_date, end_date, job_id, department_id) values (101, '1989-09-21', '1993-10-27', 'MK_REP',10);
insert into job_history (employee_id, start_date, end_date, job_id, department_id) values (101, '1993-10-28', '1997-03-15', 'MK_REP',30);
insert into job_history (employee_id, start_date, end_date, job_id, department_id) values (100, '1996-02-17', '1999-12-19', 'ST_CLERK',30);
insert into job_history (employee_id, start_date, end_date, job_id, department_id) values (103, '1998-03-24', '1999-12-31', 'MK_REP',20);
