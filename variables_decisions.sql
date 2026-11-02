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
SELECT @firstName = FirstName, @lastName = LDeskHolder WHERE DeskHolderID = 'ANN00astName, @emailAddress = EmailAddress FROM 1' 
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

GO
DEClARE @officeNumber DECIMAL(3,0);
DECLARE @monthlyRent DECIMAL(6,2);

SET @officeNumber = 101;

SELECT @monthlyRent = MonthlyRent
FROM Office
WHERE OfficeNumber = @officeNumber;

--place in a variable the monthly rent for that office
IF @monthlyRent IS NULL
BEGIN
	PRINT 'OFFICE NOT FOUND';
END
ELSE
	IF @monthlyRent < 500
	BEGIN
		PRINT'Budget Friendly';
	END
	ELSE
	BEGIN
		IF @monthlyRent <1000
		BEGIN
			PRINT'Decent Price'
		END
		ELSE
		BEGIN
			PRINT 'Fancy Office!'
		END
	END
END
--OR
GO
DEClARE @officeNumber DECIMAL(3,0);
DECLARE @monthlyRent DECIMAL(6,2);

SET @officeNumber = 101;

SELECT @monthlyRent = MonthlyRent
FROM Office
WHERE OfficeNumber = @officeNumber;

--place in a variable the monthly rent for that office
IF @monthlyRent IS NULL
	PRINT 'OFFICE NOT FOUND';
ELSE IF @monthlyRent < 500
	PRINT'Budget Friendly';
ELSE IF @monthlyRent <1000
	PRINT'Decent Price'
ELSE
	PRINT 'Fancy Office!'

--IS SQL SERVER IS THERE A Switch? No
--But there is a Case When Then
GO
DEClARE @officeNumber DECIMAL(3,0);
DECLARE @monthlyRent DECIMAL(6,2);

SET @officeNumber = 101;

SELECT @monthlyRent = MonthlyRent
FROM Office
WHERE OfficeNumber = @officeNumber;

DECLARE @message VARCHAR(50)

SET @message =
CASE
	WHEN @monthlyRent IS NULL THEN 'Office Not Found'
	WHEN @monthlyRent < 500 THEN 'Budget Friendly'
	WHEN @monthlyRent < 1000 THEN 'Decent Price'
	ELSE 'Fancy Office!'
END;

PRINT(@message)

GO
--IF EXISTS
--used to determin if a record exists with certain criteria
--syntax
--IF EXISTS (SELECT * FROM ........)
--if the query returns at least one record, IF is True
--Deskholder with lastname starting with S
IF EXISTS (SELECT * FROM DeskHolder WHERE LastName LIKE 'Q%') 
BEGIN
	PRINT 'There is';
END
ELSE
BEGIN
	PRINT 'There is not';
END

--any deskholders with an email domain of globo.com
--print yes or no
GO
IF EXISTS (SELECT * FROM DeskHolder WHERE EmailAddress LIKE '%globo.com') 
BEGIN
	PRINT 'yes';
END
ELSE
BEGIN
	PRINT 'no';
END

--Select the deskholder full name for lease number 85 into a variable
--Then display
--Deskholder name:  name
--also show the lease cost for that lease on same out put line
GO
DECLARE @deskHolderName varchar(76);
DECLARE @totalLeaseCost DECIMAL(15,2);

SELECT @deskHolderName = FirstName + ' ' + LastName,
@totalLeaseCost = TotalLeaseCost
FROM DeskHolder
INNER JOIN Lease --Same syntax as PostgreSQL
    ON DeskHolder.DeskHolderID = Lease.DeskHolderID
WHERE LeaseNumber = 85;

PRINT 'Deskholder Name: ' +  @deskHolderName + 'Total Lease Cost: ' + @totalLeaseCost
--cannot concatonate strings and other datatypes since + is the string concatonation operator. make everytning a string!
--show lease cost as well

select * from DeskHolder

select * from





select * from office






select * from deskholder