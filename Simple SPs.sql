--SP is a set of SQL code that can be called by name
--Can have parameters
--The code is stored in the Database and can be retrieved
--Must be in their own batch (seperate with GO)

--SP to select all the Desk Holders
CREATE PROCEDURE AllDeskHolders
AS
BEGIN
	SELECT * FROM Deskholder;
END
RETURN
GO
--Run a SP
EXECUTE AllDeskHolders
EXEC AllDeskHolders
AllDeskHolders
GO
--change a SP
ALTER PROCEDURE AllDeskHolders
AS
BEGIN
	SELECT FirstName + ' ' + LastName as FullName FROM Deskholder;
END
RETURN

GO
--retrieve the SP code from the DB
EXEC SP_HELPTEXT AllDeskHolders

--Remove SP from DB
DROP PROCEDURE AllDeskHolders

GO
--Parameters
CREATE PROCEDURE OneDeskHolder(@DeskHolderID char(6) )
AS
BEGIN
	SELECT * FROM DeskHolder WHERE DeskHolderID = @DeskHolderID
END
RETURN

EXEC OneDeskHolder 'ANN001'
EXEC OneDeskHolder 'abc'

--not providing an argument for @DeskHolderID
EXEC OneDeskHolder
GO
--Place a default on the Parameter(s)
--Check for null parameter value in SP
ALTER PROCEDURE OneDeskHolder(@DeskHolderID char(6) = null)
AS
BEGIN
	IF @DeskHolderID IS null
		BEGIN
		--Always use ,16,1 in this course
		--severerity, state
			RAISERROR ('Must provide a Deskholder ID',16,1)
		END
	ELSE
		BEGIN
			SELECT * FROM DeskHolder WHERE DeskHolderID = @DeskHolderID
		END
END
RETURN

--in our course you check for multiple null parameters in once statement
GO
CREATE PROC LookUpDeskholderByName (@FirstName varchar(35) = null, @LastName varchar(40) = null)
AS
BEGIN
	IF @FirstName IS null OR @LastName IS null
	BEGIN
		RAISERROR('Must provide a first and last name',16,1)
	END
	ELSE
	BEGIN
		SELECT * FROM DeskHolder WHERE FirstName = @FirstName and LastName = @LastName
	END
END
RETURN

