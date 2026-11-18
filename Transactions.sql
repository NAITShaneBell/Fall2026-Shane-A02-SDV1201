SELECT * FROM position -- P
SELECT * FROM staff -- C

--A single DML statement has a built in transaction around it
--so it will already  fully succeed OR fully fail
DELETE Position

--A transaction is an ALL or NOTHING approach 

--Use transaction code when performing > 1 DML statement to complete a task
--Syntax
--BEGIN TRANSACTION - Starts a transaction. Changes after this can be Rolled Back
--COMMIT TRANSACTION - Makes the changes permanent
--ROLLBACK TRANSACTION - Rollsback the changes between here and the BEGIN TRANSACTION
--Once a rollback or commit is completed, the transaction is over

DROP TABLE IF EXISTS account
DROP PROC IF EXISTS TransferFunds
CREATE TABLE Account
(
    CustomerID INT NOT NULL IDENTITY(1,1) CONSTRAINT pk_Account PRIMARY KEY,
    AccountBalance SMALLMONEY NOT NULL CONSTRAINT ck_TooMuchMoney CHECK (AccountBalance <=800)
)

INSERT INTO Account(AccountBalance)
VALUES
    (500),
    (500)

SELECT * FROM account

GO
CREATE PROCEDURE TransferFunds(@fromCustomer INT = NULL,@toCustomer INT = NULL, @amount SMALLMONEY = NULL)
AS                              --1                         --2                   200
BEGIN
    IF @fromCustomer IS NULL OR @toCustomer IS NULL OR @amount IS NULL
    BEGIN
        ;THROW 50001, 'You must provide 2 customerIDs and an amount.', 1;
    END

    BEGIN TRY
        BEGIN TRANSACTION;
        -- Withdraw from the source account.
        UPDATE Account
        SET AccountBalance -= @amount
        WHERE CustomerID = @fromCustomer;

        -- Deposit into the destination account.
        UPDATE Account
        SET AccountBalance += @amount
        WHERE CustomerID = @toCustomer;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Roll back if a transaction is still active.
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50000, 'Transfer failed!',1;
        END
    END CATCH
END
RETURN
GO

CREATE PROCEDURE PR_RegisterStudent (@StudentID INT = NULL, @CourseID CHAR(8) = NULL, @Semester CHAR(5)=NULL)
AS
BEGIN
    IF @CourseID IS NULL OR @StudentID IS NULL OR @Semester IS NULL
    BEGIN
        ;THROW 50001, 'Must Provide student ID, course ID and semester.', 1;
    END

    BEGIN TRY
        BEGIN TRANSACTION
        INSERT INTO Registration (StudentID,CourseID, Semester)
        VALUES
            (@StudentID, @CourseID, @Semester);

        UPDATE Student
        SET BalanceOwing = BalanceOwing + (SELECT CourseCost FROM Course WHERE CourseID = @CourseID)
        WHERE StudentID = @StudentID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW 50000, 'Registration Failed', 1;
    END CATCH
END
RETURN


--Use transaction code when your SP contains a task that involves more than one DML statement