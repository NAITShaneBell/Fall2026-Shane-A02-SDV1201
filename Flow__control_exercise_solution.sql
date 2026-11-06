-- use The Monthly Desk tables

-- 1. Write a SQL Server script that declares a variable named @OfficeRent and stores the MonthlyRent for OfficeNumber 217. Display the value using Print

Declare @OfficeRent decimal(6,2);

Select	@OfficeRent = MonthlyRent
From	Office
Where	OfficeNumber = 217;

Print 'Monthly Rent: ' + Cast(@OfficeRent as varchar(10));

-- 2. Write a SQL Server script that declares variables for a desk holder’s first name and last name. Retrieve the values for DeskHolderID 'GRE001' and display a message using concatenation.
Declare @FirstName varchar(35),
@LastName varchar(40);

Select	@FirstName = FirstName,
		@LastName = LastName
From	DeskHolder
Where	DeskHolderID = 'GRE001';

Print 'Desk Holder: ' + @FirstName + ' ' + @LastName;

   

-- 3. Write a SQL Server script that checks whether OfficeNumber 210 exists. If it exists, display 'Office Exists'; otherwise display 'Office Does Not Exist'.
If Exists	(Select * From	Office Where	OfficeNumber = 210)
	Begin
		Print 'Office Exists';
	End
Else
	Begin
		Print 'Office Does Not Exist';
	End 

-- 4. Write a SQL Server script that checks whether any invoices exist for LeaseNumber 168 using If Exists. If invoices exist, display the total number of invoices for that lease.
 If Exists	(Select	* From	Invoice Where	LeaseNumber = 168)
	Begin
		Declare @InvoiceCount decimal(5,0);
		Select	@InvoiceCount = Count(*)
		From	Invoice Where	LeaseNumber = 168;

		Print 'Total Invoices: ' + Cast(@InvoiceCount As varchar(5));
	End
Else
	Begin
	 Print 'No invoices found'
	End
-- 5. Write a SQL Server script that declares a variable named @TotalInvoices and stores the number of invoices where PaidYN = 'N'. Display the result.
Declare @TotalInvoices decimal(5,0);

Select	@TotalInvoices = Count(*)
From	Invoice Where	PaidYN = 'N';

Print 'Unpaid Invoices: ' + Cast(@TotalInvoices As varchar(5));

-- 6. Write a SQL Server script that uses If Not Exists to determine whether a referral source description of 'TikTok Ads' exists. If it does not exist, insert the new referral source with ReferralSourceCode 19.
If Not Exists	(Select	* From	ReferralSource Where ReferralSourceDescription = 'TikTok Ads')
	Begin
		Insert Into ReferralSource
			(ReferralSourceCode, ReferralSourceDescription)
		Values
			(19, 'TikTok Ads');
	End

-- 7. Write a SQL Server script that declares variables for @CurrentPrice and @Discount. Retrieve the values for AddOnNumber 8 and calculate the discounted price if the discount is not NULL. Print 'No discount' available if Discount is null. Discount is a percent.
Declare @CurrentPrice decimal(6,2),
        @Discount decimal(3,0),
        @DiscountedPrice decimal(6,2);

Select	@CurrentPrice = CurrentPrice, @Discount = Discount
From	OfficeAddOn
Where	AddOnNumber = 8;

If @Discount Is Not Null
	Begin
		Set @DiscountedPrice = @CurrentPrice - (@CurrentPrice * @Discount / 100.0);

		Print 'Discounted Price: ' + Cast(@DiscountedPrice As varchar(10));
	End
Else
	Begin
		Print 'No discount available';
	End
	
-- 8. Write a SQL Server script that checks whether DeskHolderID 'BUR001' has any active leases where EndDate IS NULL. If active leases exist, display 'Active Lease Found'.
If Exists	(Select	* From	Lease Where	DeskHolderID = 'BUR001' And	EndDate Is Null)
	Begin
		Print 'Active Lease Found';
	End
 

-- 9. Write a SQL Server script that uses variables and IF…ELSE logic to determine whether InvoiceNumber 240 has been paid. Display either 'Invoice Paid' or 'Invoice Outstanding'.
Declare @PaidYN char(1);

Select	@PaidYN = PaidYN
From	Invoice
Where	InvoiceNumber = 240;

If @PaidYN = 'Y'
	Begin
		Print 'Invoice Paid';
	End
Else
	Begin
		Print 'Invoice Outstanding';
	End

-- 10. Write a SQL Server script that checks whether an office exists with: OfficeTypeDescription = 'Shared Office' and WindowStatus = 'O'. If such an office exists, display the OfficeNumber and MonthlyRent for all matching offices. Otherwise display 'No matching offices found'.
If Exists	(Select	* From	Office INNER JOIN OfficeType 
					ON Office.OfficeTypeCode = OfficeType.OfficeTypeCode
					Where	OfficeType.OfficeTypeDescription = 'Shared Office' And
					Office.WindowStatus = 'O'
			)
Begin
	Select	OfficeNumber, MonthlyRent From	Office INNER JOIN OfficeType ON Office.OfficeTypeCode = OfficeType.OfficeTypeCode Where	OfficeType.OfficeTypeDescription = 'Shared Office' And	Office.WindowStatus = 'O'
End
Else
	Begin
		print'No matching offices found'
	End