-- Employees : 사원테이블
create table Employees (
	employee_id int unsigned primary key,	-- 사원번호
    
    first_name varchar(20),				-- 성
    last_name varchar(30) not null,		-- 이름
    email varchar(25) not null,			-- 이메일
    phone_number varchar(20),			-- 핸드폰 번호
    hire_date date not null,			-- 입사날짜
    job_id varchar(20) not null,		-- 직무번호
    salary decimal(8, 2) not null,		-- 봉급액
    commisstion_pct	decimal(2, 2),		-- 성과금
    manager_id int unsigned,
    department_id int unsigned			-- 부서명
);

-- Regions
create table Regions (
	region_id int unsigned not null,
	region_name varchar(25),
	primary key (region_id)
);

-- Countries
create table Countries(
	country_id CHAR(2) not null,
    country_name varchar(40),
    region_id int unsigned not null,
    primary key(country_id)
);

-- Locations
create table Locations (
	location_id int unsigned not null auto_increment,
	street_address varchar(40),
	postal_code varchar(12),
	city varchar(30) not null,
	state_province varchar(30),
    country_id char(2) not null,
    primary key (location_id)
);

-- Departments
create table Departments (
	department_id int unsigned not null,
	department_name varchar(30) not null,
	manager_id int unsigned,
    location_id int unsigned,
    primary key (department_id)
);

-- Jobs
create table Jobs (
	job_id varchar(20) not null,
    job_title varchar(40) not null,
    min_salary decimal(8, 0) unsigned,
    max_salary decimal(8, 0) unsigned,
    primary key(job_id)
);

-- Job_history
create table Job_history (
	start_date date not null,
	job_id varchar(20) not null,
	employee_id int unsigned not null,
	end_date date not null,
	department_id int unsigned not null
);

alter table Job_history add unique index (
	employee_id, start_date
); -- 사원의 이력 관리


-- fk 추가 작업 alter 명령어

Alter table Countries add foreign key (region_id) references Regions(region_id);

Alter table Locations add foreign key (country_id) references Countries(country_id);

Alter table Departments add foreign key (location_id) references Locations(location_id);
Alter table Departments add foreign key (manager_id) references Employees(employee_id); -- 매니저는 사원 중 한명

Alter table Job_history add foreign key (job_id) references Jobs(job_id);
Alter table Job_history add foreign key (employee_id) references Employees(employee_id);
Alter table Job_history add foreign key (department_id) references Departments(department_id);

Alter table employees add foreign key (department_id) references Departments(department_id);
Alter table employees add foreign key (job_id) references Jobs(job_id);
Alter table employees add foreign key(manager_id) references Employees(employee_id) -- 사원은 매니저 데이터도 가질 수 있다
-- Alter table employees add foreign key (employee_id) references employees(employee_id);

