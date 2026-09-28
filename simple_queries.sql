--Queries
--Select all columns from a table
--always select the columns you want to use. not *
Select * from Student;

Select StudentID, FirstName, LastName,Gender, StreetAddress, City, Province, PostalCode,Birthdate ,BalanceOwing from student;

--Aliases - do not use them unless needed
Select FirstName "Fname" , LastName "Lname" from student;
--Custom columns
Select FirstName || ' ' || LastName "FullName" from Student;  
--single quotes are for string literals
--double quotes for identifiers(aliases)
--MATH
Select CourseID, CourseName, CourseCost ,CourseCost * .8  "SaleCost" from Course
--how much money is made from each course of the max number of students enrolled. Show the courseid, coursename,money made
Select CourseID, CourseName, CourseCost * MaxStudents "MoneyMade" from Course

--Which students are registered in at least one course. SHow StudentID
--Distinct removes duplicate results
select distinct StudentID from Registration

--Where clause - conditions to identify which records to return
--Edmonton students
Select FirstName || ' ' || LastName "StudentName" from Student
where City = 'Edmonton'

--search by studentid
Select FirstName || ' ' || LastName "StudentName" from Student
where StudentID = 199899200
--all the other students
Select FirstName || ' ' || LastName "StudentName" from Student
where StudentID != 199899200

--WildCards
-- % -- any number of characters
-- _ -- any single character

--firstnames staring with M
Select FirstName from Student
where FirstName like 'M%'

--lastname starts with C and the third character is O
Select LastName from Student
where LastName like 'C_o%'

--ordering
Select FirstName, LastName from Student
order by LastName asc
--desc
Select FirstName, LastName from Student
order by LastName desc
--nested
Select FirstName, LastName from Student
order by LastName asc, FirstName asc

--And Or
--firstname of students with iD's 198933540 or 199912010
Select FirstName from Student
Where StudentID = 198933540 or StudentID = 199912010
--IN
Select FirstName from Student
Where StudentID in(198933540,199912010)

--AND
Select FirstName, LastName from Student
Where FirstName = 'Joe' and City = 'Edmonton'





 