--Try/catch
--Create a stored procedure named PR_AddOfficeType that accepts OfficeTypeCode and OfficeTypeDescription
select * from OfficeType
GO
CREATE PROCEDURE PR_AddOfficeType (@OfficeTypeCode DECIMAL(2,0), @OfficeTypeDescription VARCHAR(35))
AS
BEGIN 
	INSERT INTO OfficeType (OfficeTypeCode, OfficeTypeDescription)
	VALUES (@OfficeTypeCode, @OfficeTypeDescription);
END
RETURN

EXEC PR_AddOfficeType --not null fields
EXEC PR_AddOfficeType 5,'cool' -- pk error
EXEC PR_AddOfficeType 7,'cool' -- success
GO
--handle the errors
ALTER PROCEDURE PR_AddOfficeType (@OfficeTypeCode DECIMAL(2,0) = null, @OfficeTypeDescription VARCHAR(35) = null)
AS
BEGIN 
	if @OfficeTypeCode IS null OR @OfficeTypeDescription IS null
		BEGIN
			RAISERROR('Must provide office type code and description',16,1);
		END
	ELSE
	BEGIN
		INSERT INTO OfficeType (OfficeTypeCode, OfficeTypeDescription)
		VALUES (@OfficeTypeCode, @OfficeTypeDescription);
	END
END
RETURN

EXEC PR_AddOfficeType --handled
EXEC PR_AddOfficeType 5,'cool' --crashes
GO
ALTER PROCEDURE PR_AddOfficeType (@OfficeTypeCode DECIMAL(2,0) = null, @OfficeTypeDescription VARCHAR(35) = null)
AS
BEGIN 
	if @OfficeTypeCode IS null OR @OfficeTypeDescription IS null
		BEGIN
			RAISERROR('Must provide office type code and description',16,1);
		END
	ELSE
	BEGIN
		BEGIN TRY
			INSERT INTO OfficeType (OfficeTypeCode, OfficeTypeDescription)
			VALUES (@OfficeTypeCode, @OfficeTypeDescription);
		END TRY
		BEGIN CATCH
		--Throw a new exception
		-- 50000 is the exception number. must be at least 50000
		--1 is the state
		--Throw ends the SP
			THROW 50000,'The office type could not be added',1;
		END CATCH
	END
END
RETURN

EXEC PR_AddOfficeType 5,'cool'
GO
--Add in throw for missing parameter values 
--GOOD CHOICE
ALTER PROCEDURE PR_AddOfficeType (@OfficeTypeCode DECIMAL(2,0) = null, @OfficeTypeDescription VARCHAR(35) = null)
AS
BEGIN 
	IF @OfficeTypeCode IS null OR @OfficeTypeDescription IS null
	BEGIN -- if you get a red squiggle under the THROW it is a known bug in the editor
		THROW 50000, 'Must provide office type code and description',1;		
	END	
	
	BEGIN TRY
		INSERT INTO OfficeType (OfficeTypeCode, OfficeTypeDescription)
			VALUES (@OfficeTypeCode, @OfficeTypeDescription);
	END TRY
	BEGIN CATCH
	--Throw a new exception
	-- 50000 is the exception number. must be at least 50000
	--1 is the state
	--Throw ends the SP
		THROW 50000,'The office type could not be added',1;
	END CATCH	
END
RETURN
GO

EXEC PR_AddOfficeType  
EXEC PR_AddOfficeType 5,'cool'  
--ALL IN TRY
GO
ALTER PROCEDURE PR_AddOfficeType (@OfficeTypeCode DECIMAL(2,0) = null, @OfficeTypeDescription VARCHAR(35) = null)
AS
BEGIN
	BEGIN TRY
	IF @OfficeTypeCode IS null OR @OfficeTypeDescription IS null
	--begin and end omited to prevent squiggles due to bug
		THROW 50000, 'Must provide office type code and description',1;		
	
	INSERT INTO OfficeType (OfficeTypeCode, OfficeTypeDescription)
	VALUES (@OfficeTypeCode, @OfficeTypeDescription);
	END TRY

	BEGIN CATCH
		IF ERROR_NUMBER() = 50000
			THROW; -- rethrow the origional exception message
		IF ERROR_NUMBER() = 2627
		THROW 50001,'The office type could not be added',1
	END CATCH
	
END
RETURN

EXEC PR_AddOfficeType  
EXEC PR_AddOfficeType 5,'cool'  

--Raiserror vs throw
--Throw or more modern. a throw uses severity level 16
--Use raiseror when you need to control severity level (rare)
--use throw in catch to rethrow the origional error
