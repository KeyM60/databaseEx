create database carrent;
use carrent;

-- 캠핑카 대여 회사
create table camp_car_rent_com (
	camp_car_rent_com_id varchar(20) comment '캠핑카대여회사ID',
    --
    camp_car_rent_com varchar(10) not null comment '회사명',
    camp_car_rent_com_address varchar(20) not null comment '주소',
    camp_car_rent_com_phone varchar(20) not null comment '전화번호',
    camp_car_rent_com_manager varchar(10) not null comment '담당자 이름',
    camp_car_rent_com_manager_email varchar(20) unique comment '담당자 이메일'
);
-- 캠핑카 대여 회사 primary key 설정
alter table camp_car_rent_com
	add constraint camp_car_rent_com_id_pk primary key(camp_car_rent_com_id);


-- 캠핑카 정비소
create table camp_car_repair_shop (
	camp_car_repair_shop_id varchar(20) comment '캠핑카정비소ID',
    --
    camp_car_repair_shop_name varchar(10) not null comment '정비소명',
    camp_car_repair_shop_address varchar(20) not null comment '정비소 주소',
    camp_car_repair_shop_phone varchar(20) not null comment '정비소 전화번호',
    camp_car_repair_shop_manager varchar(10) not null comment '담당자 이름',
    camp_car_repair_shop_email varchar(20) unique comment '담당자 이메일'
);
-- 캠핑카 정비소 primary key 설정
alter table camp_car_repair_shop
	add constraint camp_car_repair_shop_id_pk primary key(camp_car_repair_shop_id);


-- 고객
create table customer (
	customer_license varchar(20) comment '운전면허증',
    --
    customer_name varchar(10) not null comment '고객명',
    customer_address varchar(20) not null comment '고객 주소',
    customer_phone varchar(20) not null comment '고객 전화번호',
    customer_email varchar(20) unique comment '고객 이메일',
    customer_used_car_date date comment '이전 캠핑카 사용날짜',
    customer_used_car_sort varchar(20) comment '이전 캠핑카 종류'
);
-- 고객 primary key 설정
alter table customer
	add constraint customer_license_pk primary key(customer_license);


-- 캠핑카
create table camp_car (
	camp_car_regist_id int unsigned comment '캠핑카등록id',
    camp_car_rent_com_id varchar(20) not null comment '캠핑카대여회사ID',
    --
    camp_car_name varchar(20) not null comment '캠핑카 이름',
    camp_car_number varchar(20) not null comment '캠핑카 차량번호',
    camp_car_person_num int unsigned not null comment '캠핑카 승차인원',
    camp_car_image varchar(50) comment '캠핑카 이미지',
    camp_car_detail varchar(200) comment '캠핑카 상세정보',
    camp_car_rent_cost int unsigned not null comment '캠핑카 대여비용',
    camp_car_regist_date date not null comment '캠핑카 등록일자'
);
-- 캠핑카 primary key 설정, foriegn key (캥핑카대여회사ID) 설정
alter table camp_car
	add constraint camp_car_regist_id_pk primary key(camp_car_regist_id, camp_car_rent_com_id);
alter table camp_car
	add constraint camp_car_rent_com_id_fk foreign key (camp_car_rent_com_id)
    references camp_car_rent_com(camp_car_rent_com_id);


-- 캠핑카 대여
create table camp_car_rent (
	rent_num int unsigned comment '대여번호',
    camp_car_regist_id int unsigned comment '캠핑카등록id',
    customer_license varchar(20) comment '운전면허증',
    camp_car_rent_com_id varchar(20) not null comment '캠핑카대여회사ID',
    --
    rent_start_date date not null comment '대여 시작일',
    rent_end_date date not null comment '대여 기간',
    rent_cost int unsigned not null comment '청구요금',
    rent_cost_deadline date not null comment '납입기한',
    rent_etc_cost_context varchar(200) comment '기타청구내역',
    rent_etc_cost int unsigned comment '기타청구요금'
);
-- 캠핑카 대여 primary key 설정, foriegn key(캠핑카등록id, 운전면허증번호, 캠핑카대여회사) 설정
alter table camp_car_rent
	add constraint rent_num_pk primary key (rent_num);
alter table camp_car_rent
	add constraint camp_car_regist_id_fk foreign key (camp_car_regist_id)
    references camp_car(camp_car_regist_id);
alter table camp_car_rent
	add constraint customer_license_fk foreign key (customer_license)
    references customer(customer_license);
alter table camp_car_rent
	add constraint camp_car_rent_com_id_fk_2 foreign key (camp_car_rent_com_id)
    references camp_car(camp_car_rent_com_id);


--  캠핑카 정비정보
create table camp_car_repair_info (
	repair_num int unsigned comment '정비번호',
    camp_car_regist_id int unsigned not null comment '캠핑카등록id',
    camp_car_repair_shop_id varchar(20) not null comment '캠핑카 정비소id',
    camp_car_rent_com_id varchar(20) not null comment '캠핑카 대여회사',
    customer_license varchar(20) not null comment '고객 운전면허증 번호',
    --
    repair_context varchar(200) not null comment '정비내역',
    repair_date date not null comment '수리날짜',
    repair_cost int unsigned not null comment '수리비용',
    repair_deadline date not null comment '납입기한',
    repair_etc_cost_context varchar(200) comment '기타 청구내역'
);
-- 캠핑카 정비정보 primary key 설정, foriegn key(캠핑카등록id, 캠핑카 정비소id, 캠핑카 대여회사, 고객 운전면허증 번호) 설정
alter table camp_car_repair_info
	add constraint repair_num_pk primary key (repair_num);
alter table camp_car_repair_info
	add constraint camp_car_regist_id_fk_2 foreign key (camp_car_regist_id)
    references camp_car(camp_car_regist_id);
alter table camp_car_repair_info
	add constraint camp_car_repair_shop_id_fk foreign key (camp_car_repair_shop_id)
    references camp_car_repair_shop(camp_car_repair_shop_id);
alter table camp_car_repair_info
	add constraint camp_car_rent_com_id_fk_3 foreign key (camp_car_rent_com_id)
    references camp_car(camp_car_rent_com_id);
alter table camp_car_repair_info
	add constraint customer_license_fk_2 foreign key (customer_license)
    references customer(customer_license);

commit;