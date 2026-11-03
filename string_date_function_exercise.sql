-- String and Date Functions Exercise
-- Use the IQSchool Database
-- 1.	Select the staff names and the name of the month they were hired.
-- 2.	How many days did Tess Agonor work for the school?
-- 3.	Select the names of all the students born in December. Remember that the to_char function pads the Month name to 9 chararacters.
-- 4.	Select last four characters of all the coursenames.
Select Right(CourseName,4) "Last4" from Course
-- 5.	Select the characters in the position description from characters 8 to 13 for PositionID 5.
Select substring(positiondescription,8,6) from position 
where positionID = 5
-- 6.	Select all the student first names as upper case.
Select UPPER(firstname)"upper_first_name" from student
-- 7.	Select the first names of students whose first names are 3 characters long.
Select firstname from student
where LENGTH(firstname) = 3
