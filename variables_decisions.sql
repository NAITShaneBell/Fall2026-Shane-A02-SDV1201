--SQL flow control, variables, exists
--This is code that will be used in Stored Procedures
--SP are named , reusable block sof SQL code that can have parameters

--SQL is not case sensitive(including string comparison)
--UPPER CASE for keywords and datatypes
--camelCase for variables
--PascalCase for column names
--Semicolons after statements

--Variables
--must declare before use with name and datatype.
--start with @
--Assign value with SET or SELECT
--SET
DECLARE @firstName VARCHAR(35);--Declare
SET @firstName = 'Shrek';
PRINT @firstname
GO
--SELECT 
DECLARE @firstName VARCHAR(35);--Declare
SELECT @firstName = 'Shrek';
PRINT @firstname;
GO
--populate variables from the DB
--SET 
DECLARE @firstName VARCHAR(35);
SET @firstName = (Select FirstName FROM DeskHolder WHERE DeskHolderID = 'ANN001');
PRINT @firstname;
GO
--SELECT
DECLARE @firstName VARCHAR(35)
SELECT @firstName = FirstName from DeskHolder WHERE DeskHolderID = 'ANN001'
PRINT @firstname;
GO
--Select firstname,lastname and emailaddress for ANN001 into 3 variables
--SET
DECLARE @firstName VARCHAR(35),@lastName varchar(40),@emailAddress varchar(75);
SET @firstName = (Select FirstName FROM DeskHolder WHERE DeskHolderID = 'ANN001');
SET @lastName = (Select lastName FROM DeskHolder WHERE DeskHolderID = 'ANN001');
SET @emailAddress = (Select EmailAddress FROM DeskHolder WHERE DeskHolderID = 'ANN001');
PRINT @firstName + ' ' + @lastName + ' ' + @emailAddress
--SELECT
GO
DECLARE @firstName VARCHAR(35),@lastName varchar(40),@emailAddress varchar(75);
SELECT @firstName = FirstName, @lastName = LastName, @emailAddress = EmailAddress FROM DeskHolder WHERE DeskHolderID = 'ANN001' 
PRINT @firstName + ' ' + @lastName + ' ' + @emailAddress

--Use SET for single hard coded values
--Use SELECT for data from the database

--Decisions(if/else)
GO
DECLARE @character varchar(35);
SET @character = 'Jack Horner';

IF @character = 'Jack Horner'
BEGIN
	PRINT 'BOOOO! Go away!';
	PRINT 'We do not like you!';
END
ELSE
BEGIN
	PRINT 'Yay!';
	PRINT 'You rock!';
END
PRINT 'Have a groovy day!'








select * from deskholder