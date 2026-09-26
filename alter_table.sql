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

Create Table Item
(
ItemNumber integer constraint pk_Item primary key,
Description varchar (100),
CurrentPrice decimal (6,2)
constraint ck_valid_current_price check (CurrentPrice between 1 and 5)
);

Create Table ItemOnOrder
(
OrderNumber integer constraint fk_ItemOnOrder_To_Order references CustomerOrder(OrderNumber),
ItemNumber integer constraint fk_ItemOnOrder_To_Item references Item(ItemNumber),
Quantity integer constraint ck_qty_over_0 check (Quantity > 0),
Price decimal (6,2),
Amount decimal (7,2),
constraint pk_ItemOnOrder primary key (OrderNumber, ItemNumber)
);

--Alter Table
--allows us to make changes to table with data
--Add another column
 
alter table Customer
Add
FavoriteColourSmartie varchar(20) 
constraint df_SmartieBlue default 'Blue';







