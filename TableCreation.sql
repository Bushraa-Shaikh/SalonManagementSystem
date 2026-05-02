create database salonmanagementsystem

use salonmanagementsystem

create table users(
UserID int primary key not null,
UserRole varchar(50),
UserPassword varchar(50) not null)


create table clients(
ClientId int primary key not null,
ClientName varchar(50) not null,
ClientPhone varchar(50) not null)


create table activestatus(
StatusId int primary key not null,
StatusType varchar(50) )


create table staff(
StaffId int primary key not null,
UsId int not null,
StaffName varchar(50) not null,
StaffPhone varchar(50) not null,
StaffEmail varchar(50),
StaffAddress varchar(50),
JoiningDate Date,
StaffSalary decimal(10,2),
StaffSpecialilty varchar(50),
StaffStatus int not null,
foreign key(StaffStatus) references activestatus(StatusId),
FOREIGN KEY (UsId) REFERENCES users(UserId) )


create table appointments(
AppId int primary key not null,
CId int not null,
App_Booked_For int not null,
AppTime time not null,
AppDate date not null,
AppStatus int not null,
App_Booked_By int not null,
foreign key(AppStatus) references activestatus(StatusId),
FOREIGN KEY (CId) REFERENCES clients(ClientId),
foreign key(App_Booked_For) references staff(StaffId),
foreign key(App_Booked_By) references staff(StaffId)   )


create table salonservices(
ServiceId int primary key not null,
ServiceName varchar(50) not null,
ServicePrice decimal(10,2),
ServiceTime Time,
ServiceStatus int not null,
foreign key(ServiceStatus) references activestatus(StatusId)  )


create table paymentmethods(
methodId int primary key not null,
methodType varchar(50)  )


create table bills(
BillId int primary key not null,
AppointId int  null,
ClId int not null,
BillDate Date,
TotalAmount decimal(10,2),
PayId int not null,
foreign key(PayId) references paymentmethods(methodId),
FOREIGN KEY (ClId) REFERENCES clients(ClientId),
FOREIGN KEY (AppointId) REFERENCES appointments(AppId)  )


create table billdetails(
BillDetailId int primary key not null,
BId int not null,
ServId int not null,
BDPrice decimal(10,2),
foreign key(BId) references bills(BillId),
foreign key(ServId) references salonservices(ServiceId)  )

create table brands(
BrandId int primary key not null,
BrandName varchar(50) not null,		
BrandContact varchar(50) not null,
BrandStatus int not null,
foreign key(BrandStatus) references activestatus(StatusId)  )


create table products(
ProductId int primary key not null,
ProductName varchar(50) not null,
BrId int,
ProductQuantity int not null,
CostPrice decimal(10,2),
SellingPrice decimal(10,2),
ProStatus int not null,
foreign key(ProStatus) references activestatus(StatusId),
foreign key(BrId) references brands(BrandId)  )


create table inventorytransactions(
TransactionId int primary key not null,
ProId int not null,
TransactionType varchar(50) not null,
InventoryQuantity int,
InventoryDate date,
foreign key(ProId) references products(ProductId)  )


create table serviceproducts(
SerProId int primary key not null,
SerId int not null,
PId int not null,
SPQuantityUsed int,
foreign key(SerId) references salonservices(ServiceId),
foreign key(PId) references products(ProductId)  )



create table appointmentservices(
AppsId int primary key not null,
ApId int not null,
SeId int not null,
foreign key(SeId) references salonservices(ServiceId),
FOREIGN KEY (ApId) REFERENCES appointments(AppId)  )
