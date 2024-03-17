create database Project2

USE Project2

--Tasks To Be Performed:

--● Define relations/attributes

create table Role(Role_id int,Role_name varchar(100))

create table user_has_role(id int,Role_start_time timestamp,Role_end_time DATETIME,user_account_id int,role_id int)

create table user_account(user_account_id int,user_name varchar(100),email varchar(254),password nvarchar(200),
                            password_salt nvarchar(50),password_hash_algorithm nvarchar(50) )

create table user_has_status(id int,status_start_time timestamp,status_end_time DATETIME,user_account_id int,status_id int)

create table status(status_id int,status_name varchar(100),is_user_working BIT)

--● Define primary keys

Alter table role
alter column role_id int not null

Alter table ROLE Add constraint pk_1 primary key(role_ID) 

Alter table user_has_role
alter column id int not null

Alter table user_has_role ADD CONSTRAINT PK_2 PRIMARY KEY(ID)

Alter table user_Account
alter column user_Account_id int not null

Alter table user_Account ADD CONSTRAINT PK_3 PRIMARY KEY(user_Account_id)


Alter table user_has_status
alter column id int not null

Alter table user_has_status ADD CONSTRAINT PK_4 PRIMARY KEY(ID)

Alter table status
alter column status_id int not null

Alter table status ADD CONSTRAINT PK_5 PRIMARY KEY(status_id)

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'status' AND CONSTRAINT_NAME LIKE 'PK_%';

--● Create foreign keys


Alter table user_has_role ADD CONSTRAINT FK_1 FOREIGN KEY(role_ID)  references role(role_ID)
Alter table user_has_role ADD CONSTRAINT FK_2 FOREIGN KEY(user_Account_id)  references user_Account(user_Account_id)

Alter table user_has_status ADD CONSTRAINT FK_3 FOREIGN KEY(user_Account_id)  references user_Account(user_Account_id)
Alter table user_has_status ADD CONSTRAINT FK_4 FOREIGN KEY(status_id)  references status(status_id)



--1. Insert data into each of the above tables. With at least two rows in each of
----the tables. Make sure that you have created respective foreign keys.

insert into role values 
     (1, 'Administrator'),
     (2, 'Moderator'),
     (3, 'User')

insert into user_has_role(id,  Role_end_time, user_account_id, role_id) values
    (1,  NULL, 1, 1), 
    (2,  NULL, 2, 2), 
    (3, NULL, 3, 3)


insert into user_account values
    (1, 'admin', 'admin@gmail.com', 'Admin@1234', 'salt123', 'SHA256'),
    (2, 'moderator1', 'moderator1@yahoo.com', 'Moderator@343', 'salt456', 'SHA256'),
    (3, 'user1', 'user1@outlook.com', 'User#321', 'salt789', 'SHA256')


insert into user_has_status(ID,status_end_time,user_account_id,status_id) values 
    (1, NULL, 1, 1),
    (2, NULL, 2, 1),
    (3, NULL, 3, 1)


insert into status values
     (1, 'Active', 1),
     (2, 'Inactive', 0),
     (3, 'Away', 0)




--2. Delete all the data from each of the tables.select * from Roleselect * from user_has_roleselect * from user_accountselect * from user_has_statusselect * from statusBegin transactionalter table user_has_roledrop constraint FK_1 delete RolerollbackBegin transactiondelete user_has_rolerollbackBegin transactionalter table user_has_roledrop constraint FK_2 alter table user_has_statusdrop constraint FK_3 delete user_accountrollbackBegin transactiondelete user_has_statusrollbackBegin transactionalter table user_has_statusdrop constraint FK_4 delete statusrollback