--String Functions
--Select the firstname and lastname of all my students as one column
Select FirstName ||  ' ' ||   LastName "FullName" from Student;
Select CONCAT(FirstName,' ', LastName) "FullName" from Student;

Select Length(FirstName)"Length", FirstName from Student;

Select Lower(FirstName)"Lower", Upper(LastName) "Upper" from Student;

Select ('    Hello World    ')"NoTrim", Trim('    Hello World    ')"Trimmed" 

Select Replace('Hello World! How you are having a terrific day!','terrific','groovy')

Select Substring(CourseName, 2, 5)"SubString", CourseName from Course

Select * from Course 
where Substring(CourseName, 2, 5) = 'ataba'

Select CourseID, CourseName , Left(CourseID,4) "Left", Right(CourseID,4)"Right" from Course

--All the columns for DMIT courses
Select * from Course 
where CourseID like 'DMIT%'
Select * from Course 
where Left(CourseID,4) = 'DMIT'




