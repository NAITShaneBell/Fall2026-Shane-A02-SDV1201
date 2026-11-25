DROP TABLE IF EXISTS CharacterWageChanges;
DROP TABLE IF EXISTS Character;
DROP TABLE IF EXISTS Movie;
GO

CREATE TABLE Movie
(
    MovieID INT IDENTITY(1, 1) CONSTRAINT PK_Movie PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    Budget MONEY NOT NULL
);

CREATE TABLE Character
(
    CharacterID INT IDENTITY(1, 1) CONSTRAINT PK_Actor PRIMARY KEY,
    Name VARCHAR(80) NOT NULL,
    Wage MONEY NOT NULL,
    Rating CHAR(1) NOT NULL CONSTRAINT DF_Rating DEFAULT '3',
    MovieID INT NOT NULL CONSTRAINT FK_CharacterToMovie REFERENCES Movie (MovieID)
);

INSERT INTO Movie (Title, Budget)
VALUES ('Star Wars', 100000000),
       ('Transformers', 90000000),
       ('Smurfs', 70000000),
       ('Shrek', 110000000),
       ('Finding Nemo', 75000000);

INSERT INTO Character (Name, Wage, Rating, MovieID)
VALUES ('Luke Skywalker', 500000, '5', 1),
       ('R2D2', 500, '4', 1),
       ('Darth Vader', 10000, '2', 1),
       ('Optimus Prime', 1000, '2', 2),
       ('Bumblebee', 2000, '2', 2),
       ('Megatron', 3000, '2', 2),
       ('Papa Smurf', 200, '2', 3),
       ('Smurfette', 300, '2', 3),
       ('Handy Smurf', 400, '2', 3),
       ('Shrek', 8000, '2', 4),
       ('Donkey', 9000, '2', 4),
       ('Dragon', 1000, '2', 4),
       ('Dory', 50, '2', 5),
       ('Nemo', 60, '2', 5),
       ('Bruce', 70, '2', 5);
GO

--Triggers execute in response to a particular DML statement on a particular table
--No parameters, not called explitly
--Audit/logging and validation triggers are common
--Triggers Must work if 0,1 or many records are affected

--SYNTAX
--Create or Alter Trigger Name
--ON TableName
--FOR DML statment(s)
--AS
--Trigger Code

--Simple Trigger
CREATE or ALTER TRIGGER TR_Movie_Insert_Update
ON Movie
FOR INSERT, UPDATE --AFTER INSERT, UPDATE
AS
BEGIN
  ;THROW 50000, 'The Movie Insert or Update Trigger fired',1;
END;
GO

--Test
INSERT INTO MOvie (Title, Budget)
VALUES ('MineCraft',500)

UPDATE Movie
SET Budget = 10000
WHERE MovieID = 1

--NOTE: When you throw in a trigger it rollsback the transaction

--DROP TRIGGER
DROP TRIGGER TR_Movie_Insert_Update
GO
--Instead of THROW use RAISERROR and ROLLBACK
--This is more legacy code
CREATE or ALTER TRIGGER TR_Movie_Insert_Update_RaisError
ON Movie
FOR INSERT, UPDATE --AFTER INSERT, UPDATE
AS
BEGIN
  ROLLBACK TRANSACTION
  RAISERROR('Rolling back',16,1)
END;

--RAISERROR does not Rollback so you must code it
--THROW is much simpler to work with so use that

--INSERTED and DELETED tables
--Created and populated by SQL for use in our trigger
--INSERTED contains the After image of the affected rows
--DELETED contains the Before image of the affected rows

--INSERT: Inserted contains the new rows, Deleted is empty
--DELETE: Inserted is empty, Deleted contains the records that were deleted
--UPDATE: Inserted contains the new values, Deleted contains the old values


GO
--Simple Validation Trigger (Wage > 0)
CREATE OR ALTER TRIGGER TR_Character_Insert_Update
ON Character
FOR Insert,Update
AS
BEGIN

IF EXISTS(SELECT * FROM INSERTED WHERE Wage <= 0)
  BEGIN
  ;THROW 50000,'Wages must be positive',1;
  END;
END;


GO
--Test 1 record
Update Character 
SET wage -= 500000
WHERE CharacterID = 1

select * from Character
--OLD 500 000 ->DELETED
--NEW 499 995 ->INSERTED

--Test multiple
Update Character 
SET wage -= 5
WHERE CharacterID in (3,6)
--INSERTED -->3	Darth Vader	99995.00	2	1
--            6	Megatron	2995.00	2	2
--DELTED --> Origional rows
Update Character 
SET wage -= 3000
WHERE CharacterID in (3,6)

