create database hospital;
use hospital;

-- 의사
create table Doctor (
	doctor_id varchar(20),
    --
    doctor_treat_sub varchar(20) not null,
    doctor_name varchar(20) not null,
    doctor_gender char(1) not null,
    doctor_phone varchar(20) not null,
    doctor_email varchar(20),
    doctor_grade varchar(20) not null,
    primary key(doctor_id)
);

-- 간호사
create table Nurse (
	nurse_id varchar(20),
    --
    nurse_treat_sub varchar(20) not null,
    nurse_name varchar(20) not null,
    nurse_gender char(1) not null,
    nurse_phone varchar(20) not null,
    nurse_email varchar(20),
    nurse_grade varchar(20) not null,
    primary key(nurse_id)
);

-- 환자
create table Patient (
	patient_id varchar(20),
    --
	nurse_id varchar(20) not null,
    doctor_id varchar(20) not null,
    patient_name varchar(20) not null,
    patient_gender char(1) not null,
    patient_citizen varchar(20) not null,
    patient_address varchar(20) not null,
    patient_phone varchar(20) not null,
    patient_email varchar(20),
    patient_job varchar(20),
    primary key(patient_id)
);

-- 진료
create table Treat (
	treat_id varchar(20) not null,
    patient_id varchar(20) not null,
    doctor_id varchar(20) not null,
    --
    treat_content varchar(200),
    treat_date date not null
);

-- 차트
create table Chart (
	chart_num int unsigned not null,
    treat_id varchar(20) not null,
    doctor_id varchar(20) not null,
    patient_id varchar(20) not null,
    --
    nurse_id varchar(20) not null,
    chart_content varchar(200) not null
);

-- alter table treat add unique index
alter table treat add unique index (
	treat_id, patient_id, doctor_id
);

-- alter table chart add unique index
alter table chart add unique index (
	chart_num, treat_id, doctor_id, patient_id
);

-- foriegn key
alter table Patient add foreign key (nurse_id) references Nurse(nurse_id);
alter table Patient add foreign key (doctor_id) references Doctor(doctor_id);

alter table Treat add foreign key (doctor_id) references Doctor(doctor_id);
alter table Treat add foreign key (patient_id) references Patient(patient_id);

alter table Chart add foreign key (treat_id) references Treat(treat_id);
alter table Chart add foreign key (doctor_id) references Treat(doctor_id);
alter table Chart add foreign key (patient_id) references Treat(patient_id);
alter table Chart add foreign key (nurse_id) references Nurse(nurse_id);

commit;


