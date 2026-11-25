-- use The Monthly Desk tables

-- 1. Create a stored procedure named PR_AddDeskHolderWithLease that inserts a new record into the DeskHolder table and inserts a related lease into the Lease table - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are DeskHolderID, FirstName, LastName, CompanyName, EmailAddress, CellPhoneNumber, CreditCardNumber, ReferralSourceCode, LeaseNumber, StartDate, OfficeNumber, LeaseTypeNumber and all parameters will be passed in and will be valid
CREATE PROCEDURE PR_AddDeskHolderWithLease
(
    @DeskHolderID CHAR(6),
    @FirstName VARCHAR(35),
    @LastName VARCHAR(40),
    @CompanyName VARCHAR(55),
    @EmailAddress VARCHAR(75),
    @CellPhoneNumber BIGINT,
    @CreditCardNumber VARCHAR(16),
    @ReferralSourceCode INT,
    @LeaseNumber INT,
    @StartDate DATE,
    @OfficeNumber INT,
    @LeaseTypeNumber INT
)
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		INSERT INTO DeskHolder
			(DeskHolderID, FirstName, LastName, CompanyName, EmailAddress, CellPhoneNumber, CreditCardNumber, ReferralSourceCode)
		VALUES
			(@DeskHolderID, @FirstName, @LastName, @CompanyName, @EmailAddress, @CellPhoneNumber, @CreditCardNumber, @ReferralSourceCode);

		INSERT INTO Lease
			(LeaseNumber, StartDate, OfficeNumber, DeskHolderID, LeaseTypeNumber)
		VALUES
			(@LeaseNumber, @StartDate, @OfficeNumber, @DeskHolderID, @LeaseTypeNumber);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Insert into DeskHolder and Lease failed.', 1;
	END CATCH
END
RETURN
GO

-- 2. Create a stored procedure named PR_CreateInvoiceWithItems that inserts a new invoice into the Invoice table and inserts one related invoice item into the InvoiceItem table - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are InvoiceNumber, LeaseNumber, InvoiceGST, InvoiceTotal, AddOnNumber, QuantitySold, InvoiceAddOnCost, InvoiceAddOnPrice and all parameters will be passed in and will be valid
CREATE PROCEDURE PR_CreateInvoiceWithItems
(
    @InvoiceNumber INT,
    @LeaseNumber INT,
    @InvoiceGST DECIMAL(9,2),
    @InvoiceTotal DECIMAL(11,2),
    @AddOnNumber INT,
    @QuantitySold INT,
    @InvoiceAddOnCost DECIMAL(6,2),
    @InvoiceAddOnPrice DECIMAL(6,2)
)
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Invoice
			(InvoiceNumber, InvoiceDate, PaidYN, InvoiceGST, InvoiceTotal, LeaseNumber)
		VALUES
			(@InvoiceNumber, GETDATE(), 'N', @InvoiceGST, @InvoiceTotal, @LeaseNumber);

		INSERT INTO InvoiceItem
			(InvoiceNumber, AddOnNumber, QuantitySold, InvoiceAddOnCost, InvoiceAddOnPrice)
		VALUES
			(@InvoiceNumber, @AddOnNumber, @QuantitySold, @InvoiceAddOnCost, @InvoiceAddOnPrice);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Insert into Invoice and InvoiceItem failed.', 1;
	END CATCH
END
RETURN
GO

-- 3. Create a stored procedure named PR_UpdateOfficeAndLeasePrice that updates the MonthlyRent in the Office table and updates the TotalLeasePrice in the Lease table for all leases using that office - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are OfficeNumber, MonthlyRent, TotalLeasePrice and all parameters will be passed in and will be valid

CREATE PROCEDURE PR_UpdateOfficeAndLeasePrice
(
    @OfficeNumber INT,
    @MonthlyRent DECIMAL(6,2),
    @TotalLeasePrice DECIMAL(15,2)
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;

		UPDATE	Office
		SET		MonthlyRent = @MonthlyRent
		WHERE	OfficeNumber = @OfficeNumber;

		UPDATE	Lease
		SET		TotalLeasePrice = @TotalLeasePrice
		WHERE	OfficeNumber = @OfficeNumber;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Update of Office and Lease failed.', 1;
	END CATCH
END
RETURN
GO

-- 4. Create a stored procedure named PR_DeleteInvoiceAndItems that deletes all InvoiceItem records for a specified invoice and deletes the related Invoice record - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameter InvoiceNumber will be passed in and will be valid
CREATE PROCEDURE PR_DeleteInvoiceAndItems
(
    @InvoiceNumber INT
)
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		DELETE FROM InvoiceItem
		WHERE InvoiceNumber = @InvoiceNumber;

		DELETE FROM Invoice
		WHERE InvoiceNumber = @InvoiceNumber;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Delete from Invoice and InvoiceItem failed.', 1;
	END CATCH
END
RETURN
GO

-- 5. Create a stored procedure named PR_MoveDeskHolderLease that updates a lease to assign it to a different office and updates the TotalLeasePrice by increasing it 10% - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are LeaseNumber, NewOfficeNumber and all parameters will be passed in and will be valid
CREATE PROCEDURE PR_MoveDeskHolderLease
(
    @LeaseNumber INT,
    @NewOfficeNumber INT
)
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		UPDATE	Lease
		SET		OfficeNumber = @NewOfficeNumber
		WHERE	LeaseNumber = @LeaseNumber;

		UPDATE	Lease
		SET		TotalLeasePrice = TotalLeasePrice * 1.10
		WHERE	LeaseNumber = @LeaseNumber;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Lease move failed.', 1;
	END CATCH

END
RETURN
GO

-- 6. Create a stored procedure named PR_AddOfficeWithType that inserts a new OfficeType record and inserts a new Office record using that OfficeTypeCode - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are OfficeTypeCode, OfficeTypeDescription, OfficeNumber, MonthlyRent, SquareFootage, BookShelfYN, ExtraFilingCabinetYN, MeetingTableYN, WindowQuantity, WindowStatus and all parameters will be passed in and will be valid
CREATE PROCEDURE PR_AddOfficeWithType
(
    @OfficeTypeCode INT,
    @OfficeTypeDescription VARCHAR(35),
    @OfficeNumber INT,
    @MonthlyRent DECIMAL(6,2),
    @SquareFootage DECIMAL(6,2),
    @BookShelfYN CHAR(1),
    @ExtraFilingCabinetYN CHAR(1),
    @MeetingTableYN CHAR(1),
    @WindowQuantity INT,
    @WindowStatus CHAR(1)
)
AS
BEGIN
	BEGIN TRANSACTION;
		BEGIN TRY

		INSERT INTO OfficeType
			(OfficeTypeCode, OfficeTypeDescription)
		VALUES
			(@OfficeTypeCode, @OfficeTypeDescription);

		INSERT INTO Office
			(OfficeNumber, MonthlyRent, SquareFootage, BookShelfYN, ExtraFilingCabinetYN, MeetingTableYN, WindowQuantity, WindowStatus, OfficeTypeCode)
		VALUES
			(@OfficeNumber, @MonthlyRent, @SquareFootage, @BookShelfYN, @ExtraFilingCabinetYN, @MeetingTableYN, @WindowQuantity, @WindowStatus, @OfficeTypeCode);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Insert into OfficeType and Office failed.', 1;
	END CATCH
END
RETURN
GO

-- 7. Create a stored procedure named PR_ProcessInvoicePayment that updates an invoice to set PaidYN = 'Y' and inserts a new invoice item for a payment processing fee - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are InvoiceNumber, AddOnNumber, QuantitySold, InvoiceAddOnCost, InvoiceAddOnPrice and all parameters will be passed in and will be valid
CREATE PROCEDURE PR_ProcessInvoicePayment
(
    @InvoiceNumber INT,
    @AddOnNumber INT,
    @QuantitySold INT,
    @InvoiceAddOnCost DECIMAL(6,2),
    @InvoiceAddOnPrice DECIMAL(6,2)
)
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		UPDATE	Invoice
		SET		PaidYN = 'Y'
		WHERE	InvoiceNumber = @InvoiceNumber;

		INSERT INTO InvoiceItem
			(InvoiceNumber, AddOnNumber, QuantitySold, InvoiceAddOnCost, InvoiceAddOnPrice)
		VALUES
			(@InvoiceNumber, @AddOnNumber, @QuantitySold, @InvoiceAddOnCost, @InvoiceAddOnPrice);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Invoice payment processing failed.', 1;
	END CATCH
END
RETURN
GO

-- 8. Create a stored procedure named PR_DeleteDeskHolderData that deletes all InvoiceItem records related to a desk holder, deletes all Invoice records related to the desk holder, deletes all Lease records related to the desk holder, deletes the DeskHolder record - use transactions and error handling to maintain referential integrity; input parameter DeskHolderID will be passed in and will be valid
CREATE PROCEDURE PR_DeleteDeskHolderData
(
    @DeskHolderID CHAR(6)
)
AS
BEGIN
	BEGIN TRANSACTION;

	
	BEGIN TRY
		DELETE InvoiceItem
		WHERE InvoiceItem.InvoiceNumber IN (SELECT Invoice.InvoiceNumber FROM Invoice
    INNER JOIN Lease ON Invoice.LeaseNumber = Lease.LeaseNumber
    WHERE Lease.DeskHolderID = @DeskHolderID);
		
	-- NEW WAY TO WRITE DELETE
	-- OR
	-- NEW WAY TO WRITE DELETE
	-- Delete InvoiceItem 
	-- from InvoiceItem
	-- 			Inner Join Invoice 
	-- 				On InvoiceItem.InvoiceNumber = Invoice.InvoiceNumber
	-- 			Inner Join Lease 
	-- 				On Invoice.LeaseNumber = Lease.LeaseNumber
		-- Where	Lease.DeskHolderID = @DeskHolderID;

		DELETE Invoice
		WHERE Invoice.LeaseNumber IN (SELECT Lease.LeaseNumber
    FROM Lease WHERE Lease.DeskHolderID = @DeskHolderID);

		DELETE FROM Lease
		WHERE	DeskHolderID = @DeskHolderID;

		DELETE FROM DeskHolder
		WHERE	DeskHolderID = @DeskHolderID;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Delete of desk holder related data failed.', 1;
	END CATCH
END
RETURN
GO

-- 9. Create a stored procedure named PR_TransferLease that ends an existing lease by updating the EndDate and creates a new lease for another desk holder - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are OldLeaseNumber, NewLeaseNumber, NewDeskHolderID, TransferDate, OfficeNumber, LeaseTypeNumber and all parameters will be passed in and will be valid
CREATE PROCEDURE PR_TransferLease
(
    @OldLeaseNumber INT,
    @NewLeaseNumber INT,
    @NewDeskHolderID CHAR(6),
    @TransferDate DATE,
    @OfficeNumber INT,
    @LeaseTypeNumber INT
)
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		UPDATE	Lease
		SET		EndDate = @TransferDate
		WHERE	LeaseNumber = @OldLeaseNumber;

		INSERT INTO Lease
			(LeaseNumber, StartDate, OfficeNumber, DeskHolderID, LeaseTypeNumber)
		VALUES
			(@NewLeaseNumber, @TransferDate, @OfficeNumber, @NewDeskHolderID, @LeaseTypeNumber);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Lease transfer failed.', 1;
	END CATCH
END
RETURN
GO

-- 10. Create a stored procedure named PR_AddInvoiceWithMultipleItems that inserts a new invoice, inserts two related invoice items, and updates the InvoiceTotal based on the inserted invoice items - use a transaction and structured TRY…CATCH error handling so all operations succeed or fail together; input parameters are InvoiceNumber, LeaseNumber, InvoiceGST, AddOnNumber1, QuantitySold1, InvoiceAddOnCost1, InvoiceAddOnPrice1, AddOnNumber2, QuantitySold2, InvoiceAddOnCost2, InvoiceAddOnPrice2 and all parameters will be passed in and will be valid
CREATE PROCEDURE PR_AddInvoiceWithMultipleItems
(
    @InvoiceNumber INT,
    @LeaseNumber INT,
    @InvoiceGST DECIMAL(9,2),
    @AddOnNumber1 INT,
    @QuantitySold1 INT,
    @InvoiceAddOnCost1 DECIMAL(6,2),
    @InvoiceAddOnPrice1 DECIMAL(6,2),
    @AddOnNumber2 INT,
    @QuantitySold2 INT,
    @InvoiceAddOnCost2 DECIMAL(6,2),
    @InvoiceAddOnPrice2 DECIMAL(6,2)
)
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		INSERT INTO Invoice
			(InvoiceNumber, InvoiceDate, PaidYN, InvoiceGST, InvoiceTotal, LeaseNumber)
		VALUES
			(@InvoiceNumber, GETDATE(), 'N', @InvoiceGST, 0, @LeaseNumber);

		INSERT INTO InvoiceItem
			(InvoiceNumber, AddOnNumber, QuantitySold, InvoiceAddOnCost, InvoiceAddOnPrice)
		VALUES
			(@InvoiceNumber, @AddOnNumber1, @QuantitySold1, @InvoiceAddOnCost1, @InvoiceAddOnPrice1),
			(@InvoiceNumber, @AddOnNumber2, @QuantitySold2, @InvoiceAddOnCost2, @InvoiceAddOnPrice2);

		UPDATE	Invoice
		SET		InvoiceTotal =	(SELECT	SUM(QuantitySold * InvoiceAddOnPrice) + @InvoiceGST
								 FROM	InvoiceItem
								 WHERE	InvoiceNumber = @InvoiceNumber
								)
		WHERE InvoiceNumber = @InvoiceNumber;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW 50000, 'Invoice with multiple items failed.', 1;
	END CATCH
END
RETURN
GO
