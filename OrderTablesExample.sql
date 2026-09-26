--Must create your tables parent first
--Must drop your tables child first
--Drop your tables in the opposite order you created
--The parent object must exist before the child object
drop table if exists ItemOnOrder;
drop table if exists Item;
drop table if exists CustomerOrder;
drop table if exists Customer;

Create Table Customer 
(
CustomerNumber integer Generated Always as Identity(Start with 1000 Increment By 10) constraint pk_Customer primary key,
LastName varchar (50),
FirstName varchar (50),
Phone char (13) 
constraint ck_valid_phone check (Phone ~'^\([1-9][0-9][0-9]\)[1-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'),
Age smallint constraint ck_age_over_0 check (Age > 0),
PostalCode char(7)
constraint ck_valid_PostalCode check (PostalCode ~*'^[A-Z][0-9][A-Z] [0-9][A-Z][0-9]$')
);

insert into Customer (LastName, FirstName,Phone, Age,PostalCode)
values ('Smith','Bob','(555)111-2222',80,'T8G 1H3');


Create Table CustomerOrder
(
OrderNumber integer Generated Always as Identity constraint pk_CustomerOrder primary key,
OrderDate date,
CustomerNumber integer constraint fk_CustomerOrder_To_Customer references Customer(CustomerNumber),
Subtotal decimal (7,2),
GST decimal (5,2),
Total decimal (9,2),
constraint ck_Total_Subtotal check (Total >= SubTotal)
);
insert into CustomerOrder(OrderDate, CustomerNumber, Subtotal, GST, Total)
values ('2026-01-01', 1000, 10,.50,10.50);

Create Table Item
(
ItemNumber integer constraint pk_Item primary key,
Description varchar (100),
CurrentPrice decimal (6,2)
constraint ck_valid_current_price check (CurrentPrice between 1 and 5)
);
insert into Item(ItemNumber, Description, CurrentPrice)
values (1,'good stuff',4);


Create Table ItemOnOrder
(
OrderNumber integer constraint fk_ItemOnOrder_To_Order references CustomerOrder(OrderNumber),
ItemNumber integer constraint fk_ItemOnOrder_To_Item references Item(ItemNumber),
Quantity integer constraint ck_qty_over_0 check (Quantity > 0),
Price decimal (6,2),
Amount decimal (7,2),
constraint pk_ItemOnOrder primary key (OrderNumber, ItemNumber)
);

--Indexes
--Speed up searches
--Slow down data modification
--indexes are place on columns that are used for searches frequently
--PK constraint has an index applied automatically
--FK often have indexes
--Syntax
--Create index IX_tablename_columname on table(column)
Create index IX_CustomerOrder_CustomerNumber on CustomerOrder(CustomerNumber);
Create index IX_ItemOnOrder_OrderNumber on ItemOnOrder(OrderNumber);
Create index IX_ItemOnOrder_ItemNumber on ItemOnOrder(ItemNumber);

-- constraints enforce rules
--2 levels
--column level constraint
	--involves a single column
	--Code on the column definition
--Table level constraint
	--involve more than one column
	--code on a new line, often at end of table
--Check constraints -- enforce rules
--values and patterns



Select * from Customer



