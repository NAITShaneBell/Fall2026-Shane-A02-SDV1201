--Date Functions
Select CURRENT_DATE;
Select NOW(); 

--Extract() - returns numberic values of parts of a date
Select BirthDate, EXTRACT(DAY from BirthDate) "BirthDay", EXTRACT(MONTH from BirthDate) "BirthMonth",EXTRACT(YEAR from BirthDate)"BirthYear" from Student;

Select EXTRACT(MONTH from BirthDate) "MonthNumber",
TO_CHAR(BirthDate,'MONTH') "MonthName"
from Student;

--List all the students full names, and Birth Month Name in order of month
Select FirstName || ' ' || LastName "Student", TO_CHAR(BirthDate, 'MONTH') "Month" from Student
order by EXTRACT(MONTH from BirthDate)

--Select names of students born in 1990
Select firstname, lastname from student
where Extract(YEAR from birthdate) = 1990
--OR look for all dates in that year (between jan 1, 1990 and dec 31 1990)

--AGE
Select FirstName, LastName, AGE(DateReleased,DateHired)"WorkedHowLong"
from Staff

--Date Math
Select BirthDate, BirthDate + INTERVAL '625 days' "DaysLater" from Student

--There is an April Birthdate. Why no row returned?
Select TO_CHAR(BirthDate,'Month') from Student
Where TO_CHAR(BirthDate,'Month') = 'April'
--Postgres pads all month names to 9 characters
--Use fill mode to strip spaces
Select TO_CHAR(BirthDate,'Month') from Student
Where TO_CHAR(BirthDate,'FMMonth') = 'April'


SELECT FirstName, LastName
FROM Student
WHERE Birthdate between '1990-01-01'AND '1991-01-01';


--TO_DATE
--Convert a






-- Select names of students born in 1990 - more efficient approach
--DATE treats a string literal as a date
SELECT FirstName, LastName
FROM Student
WHERE Birthdate between DATE '1990-01-01' AND DATE '1990-12-31';

