-- Inner Joins with Aggregate Exercise
-- Use the IQSchool Database 

--	1.	How many staff are there in each position? Select the position description and quantity.
Select	PositionDescription, Count(*) as "NumberofStaff" 
From	Staff 
Inner Join Position	On Staff.PositionID = Position.PositionID
Group By Position.PositionId, PositionDescription;

--	2.	Select the average mark for each course. Display the course names and the average marks.
Select	CourseName, AVG(Mark) as AverageMark 
From	Registration
Inner Join Course On Registration.CourseId = Course.CourseId
Group By Course.CourseId,coursename;

--	3.	How many payments where made for each payment type. Display the PaymentTypeDescription and the count.
Select	PaymentTypeDescription, Count(*) "CountofPaymentType" 
From	Payment
Inner Join PaymentType On PaymentType.PaymentTypeID = Payment.PaymentTypeID
Group By Payment.PaymentTypeID, PaymentTypeDescription;

--	4.	Select the average mark for each student. Display the student names and their average mark.
Select	FirstName  || ' ' || LastName as StudentName , AVG(Mark)  as Average Mark 
From	Registration
Inner Join Student On Student.StudentID = Registration.StudentID
Group By Student.studentID, FirstName, LastName;

--	5.	Select the same data as question 4 but only show the student names and averages that are > 80.
Select	FirstName  || ' ' || LastName "StudentName" , AVG(Mark)"Average" 
From	Registration
Inner Join Student	On Student.StudentID = Registration.StudentID
Group By Student.StudentID, FirstName, LastName
Having AVG(Mark) > 80;

--	6.	What is the highest, lowest and average payment amount for each payment type Description?
Select	PaymentTypeDescription, Max(Payment.Amount) as HighestPaymentAmount,
		Min(Payment.Amount) Lowest Payment Amount, AVG(Payment.Amount) as Average Payment Amount 
From	Payment
			Inner Join PaymentType
				On Payment.PaymentTypeID = PaymentType.PaymentTypeID
Group By PaymentType.PaymentTypeID, PaymentTypedescription;

--	7.	How many students are there in each club? Show the club name and the count.
Select	Club.ClubName, Count(Activity.ClubID) "NumberofStudents" 
From	Activity
			Inner Join Club
				On Activity.ClubID = Club.ClubID
Group By club.clubid, ClubName;

--	8.	Which clubs have 3 or more students in them? Display the club names.
Select	ClubName from Activity
			Inner Join Club 
				On Activity.ClubID = Club.ClubID
Group By Club.ClubID, ClubName 
Having Count(*) >= 3;
