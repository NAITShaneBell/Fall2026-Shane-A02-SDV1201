-- Simple Select Exercise 1
-- Use the IQSchool Database
-- 1.	Select all the information from the club table
Select * from club;
-- 2.	Select the FirstNames and LastNames of all the students
Select	FirstName, LastName 
From	Student;

-- 3.	Select all the CourseId and CourseName of all the courses. Create column aliases for Course ID and CourseName
Select	CourseID "Course_ID", CourseName "Course_Name" 
From	Course;

-- 4.	Select all the course information for CourseID 'DMIT1001'
Select	CourseID, CourseName, CourseHours, MaxStudents, CourseCost 
From	Course
Where	CourseID = 'DMIT1001';

-- 5.	Select the staff first and last names who have PositionID of 3
Select	FirstName, LastName 
From	Staff
Where	PositionID = 3;

-- 6.	Select the CourseNames whose CourseHours are less than 96
Select	CourseName 
From	Course 
Where	CourseHours < 96;

-- 7.	Select the StudentID, CourseID and Mark where the Mark is between 70 and 80
Select	StudentID, CourseID, Mark 
From	Registration 
Where	Mark >=70 and Mark <=80
--or
Select	StudentID, CourseID, Mark 
From	Registration 
Where mark between 70 and 80

-- 8.	Select the StudentID, CourseID and Mark where the Mark is between 70 and 80 and the courseID is ‘DMIT2003’ or ‘PHYS2446’
Select	StudentID, CourseID, Mark
from Registration
where Mark >=70 and Mark <=80 and (CourseID = 'DMIT2003' or CourseID = 'PHYS2446')
--OR
Select	StudentID, CourseID, Mark
from Registration
where Mark  between  70 And 80  and CourseID in('DMIT2003','PHYS2446')

-- 9.	Select the students first and last names who have last names starting with S
Select	FirstName, LastName 
from	Student
Where	LastName like 'S%';

-- 10.	Select course names whose CourseID have a 1 as the fifth character
Select CourseName from Course
where CourseID like '____1%'

-- 11.	Select the CourseID's and course names where the CourseName contains the word 'Programming'
Select	CourseID, CourseName 
From	Course 
Where	CourseName Like '%Programming%';

-- 12.	Select all the club names who start with N or C.
Select	ClubName 
From	club 
Where	ClubName Like 'N%' or 
		ClubName Like 'C%';
--OR
Select	ClubName 
From	club 
Where	ClubName ~'^[NC]'

-- 13.	Select student first and last names, street address, and city where the last name is exactly 3 characters long.
Select	FirstName, LastName, StreetAddress, City 
From	Student
Where	LastName Like '___';
--3 letters long
Select	FirstName, LastName, StreetAddress, City 
From	Student
Where	LastName ~*'^[A-Z][A-Z][A-Z]$';
--OR
LastName ~* '^[A-Z]{3}$';

-- 14.	Select all the StudentID's where the payment Amount < 500 or the PaymentTypeID is 5
Select	StudentID
From	Payment 
Where	Amount < 500 or 
		PaymentTypeID = 5;

