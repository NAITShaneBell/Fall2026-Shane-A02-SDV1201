--Run this first to create the DB and then you must switch into this DB(refresh the Databases list to see it). Click the DB above and choose board_game_rentals. Then run the rest of the script
-- CREATE DATABASE board_game_rentals;

DROP TABLE IF EXISTS RentalGame;
DROP TABLE IF EXISTS Rental;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer
(
    CustomerID INT GENERATED ALWAYS AS IDENTITY
        CONSTRAINT PK_Customer_CustomerID PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL
);

CREATE TABLE Game
(
    GameID INT GENERATED ALWAYS AS IDENTITY
        CONSTRAINT PK_Game_GameID PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Category VARCHAR(30) NOT NULL,
    DailyRate NUMERIC(5,2) NOT NULL
        CONSTRAINT CK_Game_DailyRate_NonNegative
        CHECK (DailyRate >= 0)
);

CREATE TABLE Rental
(
    RentalID INT GENERATED ALWAYS AS IDENTITY
        CONSTRAINT PK_Rental_RentalID PRIMARY KEY,
    CustomerID INT NOT NULL
        CONSTRAINT FK_Rental_CustomerID_To_Customer_CustomerID
        REFERENCES Customer(CustomerID),
    RentalDate DATE NOT NULL,
    DaysRented INT NOT NULL
        CONSTRAINT CK_Rental_DaysRented_Positive
        CHECK (DaysRented > 0)
);

CREATE TABLE RentalGame
(
    RentalID INT NOT NULL
        CONSTRAINT FK_RentalGame_RentalID_To_Rental_RentalID
        REFERENCES Rental(RentalID),
    GameID INT NOT NULL
        CONSTRAINT FK_RentalGame_GameID_To_Game_GameID
        REFERENCES Game(GameID),
    DailyRateCharged NUMERIC(5,2) NOT NULL
        CONSTRAINT CK_RentalGame_DailyRateCharged_NonNegative
        CHECK (DailyRateCharged >= 0),

    CONSTRAINT PK_RentalGame_RentalID_GameID
        PRIMARY KEY (RentalID, GameID)
);

--Customers receive IDs 1 through 4.
INSERT INTO Customer (FirstName, LastName, Phone)
VALUES
    ('Alex', 'Morgan', '780-555-0101'),
    ('Jordan', 'Lee', '780-555-0102'),
    ('Taylor', 'Singh', '780-555-0103'),
    ('Casey', 'Brown', '780-555-0104');

--Games receive IDs 1 through 4.
INSERT INTO Game (Title, Category, DailyRate)
VALUES
    ('Catan', 'Strategy', 5.00),
    ('Ticket to Ride', 'Family', 4.00),
    ('Uno', 'Card', 2.00),
    ('Chess', 'Strategy', 3.00);

--Rental 1: Alex rents games for two days.
--Rental 2: Jordan rents games for three days.
INSERT INTO Rental (CustomerID, RentalDate, DaysRented)
VALUES
    (1, '2026-10-20', 2),
    (2, '2026-10-25', 3);

--Alex's rental includes Uno and Chess.
--Jordan's rental includes Catan and Ticket to Ride.
INSERT INTO RentalGame (RentalID, GameID, DailyRateCharged)
VALUES
    (1, 3, 2.00),
    (1, 4, 3.00),
    (2, 1, 5.00),
    (2, 2, 4.00);

SELECT * FROM Customer ORDER BY CustomerID;
SELECT * FROM Game ORDER BY GameID;
SELECT * FROM Rental ORDER BY RentalID;
SELECT * FROM RentalGame ORDER BY RentalID, GameID;

--============================================================
-- BOARD GAME RENTAL EXERCISE
-- Complete the questions in order.
-- Do not manually supply values for identity columns.
--============================================================


--============================================================
-- INSERT QUESTIONS
--============================================================

--1. Add a customer with the following information:
--   FirstName: Sam
--   LastName: Chen
--   Phone: 780-555-0105
--   Allow PostgreSQL to generate the CustomerID.
INSERT INTO Customer (FirstName, LastName, Phone)
VALUES ('Sam', 'Chen', '780-555-0105');


--2. Use ONE INSERT statement to add these three games:
--
--   Title                 Category     DailyRate
--   Azul                  Strategy     4.50
--   Exploding Kittens     Card         2.50
--   Monopoly              Family       3.50
--
--   Allow PostgreSQL to generate the GameIDs.
INSERT INTO Game (Title, Category, DailyRate)
VALUES
    ('Azul', 'Strategy', 4.50),
    ('Exploding Kittens', 'Card', 2.50),
    ('Monopoly', 'Family', 3.50);


--3. Create a rental for CustomerID 5. NOTE: A customer can only have one rental per day.
--   This is the customer added in Question 1.
--
--   RentalDate: October 27, 2026
--   DaysRented: 2
--
--   Allow PostgreSQL to generate the RentalID.
INSERT INTO Rental (CustomerID, RentalDate, DaysRented)
VALUES (5, '2026-10-27', 2);

--4. Add Ticket to Ride and Uno to the rental created in
--   Question 3.
--
--   Use ONE INSERT statement to add both RentalGame records.
--   DailyRateCharged for Ticket to Ride: 4.00
--   DailyRateCharged for Uno: 2.00
--
--   Use SELECT statements to find the required IDs first.
SELECT RentalID
FROM Rental
WHERE CustomerID = 5 AND RentalDate = '2026-10-27';

SELECT GameID, Title
FROM Game
WHERE Title IN ('Ticket to Ride', 'Uno');

INSERT INTO RentalGame (RentalID, GameID, DailyRateCharged)
VALUES
    (3, 2, 4.00),
    (3, 3, 2.00);

--AS ONE INSERT without extra selects before
INSERT INTO RentalGame (RentalID, GameID, DailyRateCharged)
VALUES
    (
        (SELECT RentalID
        FROM Rental
        WHERE CustomerID = 5 AND RentalDate = '2026-10-27'),
        (SELECT GameID
        FROM Game
        WHERE Title = ('Ticket to Ride')),
         4.00),
        (
        (SELECT RentalID
        FROM Rental
        WHERE CustomerID = 5 AND RentalDate = '2026-10-27'),
         (SELECT GameID
        FROM Game
        WHERE Title = ('Uno')),
         2.00);


--5. Sam wants to try every strategy game!
--   Use INSERT ... SELECT to add every game currently in the
--   Strategy category to Sam's rental from Question 3.
--
--   Use each game's current DailyRate as DailyRateCharged.
--   Do not manually list the GameIDs.

INSERT INTO RentalGame (RentalID, GameID, DailyRateCharged)
SELECT 3 ,GameID, DailyRate
FROM Game
WHERE Category = 'Strategy';


--============================================================
-- UPDATE QUESTIONS
--============================================================

--6. Change the phone number of CustomerID 5
--   to 780-555-0199.
UPDATE Customer
SET Phone = '780-555-0199'
WHERE CustomerID = 5;


--7. Update Azul using ONE UPDATE statement:
--   Change its Category to Family.
--   Change its DailyRate to 5.00.
--   Identify the game by its Title.
UPDATE Game
SET
Category = 'Family',
DailyRate = 5.00
WHERE Title = 'Azul';


--8. Increase the DailyRate of every game in the Strategy
--   category by 1.00.
--   Use the existing DailyRate in your calculation.
UPDATE Game
SET DailyRate = DailyRate + 1.00
WHERE Category = 'Strategy';


--9. Give Sam one extra day to enjoy the games.
--   Increase DaysRented by 1 for the rental from Question 3.
--   Identify the rental using its RentalID.
UPDATE Rental
SET DaysRented = DaysRented + 1
WHERE RentalID = 3;



--10. Give Sam a 10% discount on the Family games in the
--    rental from Question 3.
--
--    Update DailyRateCharged in RentalGame by multiplying
--    its existing value by 0.90.
--
--    Use a subquery to identify games whose current Category
--    is Family.
--    Apply the discount only to Sam's rental from Question 3.

Update RentalGame
Set DailyRateCharged = DailyRateCharged *.90
where RentalID = 3
and GameID  IN (Select GameID from Game where Category = 'Family')--2,7,5
select * from rentalgame


--============================================================
-- DELETE QUESTIONS
--============================================================

--11. Delete Monopoly from the Game table.
--    Identify the game by its Title.
DELETE FROM Game
WHERE Title = 'Monopoly';

--12. Remove games from Sam's rental where DailyRateCharged
--    is less than 4.00.
--
--    Delete the matching records from RentalGame.
--    Restrict the deletion to the rental from Question 3.

Select * from rentalgame

DELETE FROM RentalGame
WHERE RentalID = 3
and DailyRateCharged < 4.00;

--13. Delete every game that currently has no records in
--    RentalGame.
--
--    Use a subquery to identify these games.
--    Do not manually list their GameIDs.

DELETE FROM Game
WHERE
GameID NOT IN(Select gameID from RentalGame)


--14. Sam has decided to cancel the rental from Question 3.
--    Delete all remaining RentalGame records belonging
--    to that rental.
--
--    Keep the Rental record for now.

DELETE FROM RentalGame
WHERE RentalID = 3;


--15. Delete the Rental record created in Question 3.
--    Keep Sam's Customer record.
--
--    Think about why Question 14 must be completed before
--    this question.

DELETE FROM Rental
WHERE RentalID = 3;

1. nuthin
2. error
3. Monitor starts on fire 
