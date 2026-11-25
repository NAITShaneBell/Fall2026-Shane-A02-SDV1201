--Case lets SQl choose a value based on a condition
--used anywhere an expression/value is used

--Syntax
--CASE
--	WHEN condition1 THEN result
--	WHEN condition2 THEN result
--	ELSE default_result
--END AS NewColumName

--Show if a student owes money
--SHow Studentid, balanceowing, 
SELECT 
	StudentID,
	BalanceOwing,
	CASE 
		WHEN BalanceOwing IS NULL THEN 'Balance Unknown'
		WHEN BalanceOwing > 0 THEN 'Payment Due'
		WHEN BalanceOwing = 0 THEN 'Paid in full'
	END as PaymentStatus
from Student

--Convert marks to letter grad
--show studentid, courseid, mark, lettergrade
--null - not graded
--90-100 - A
--80-89 - B
--70 - 79 -C
--60-69 - D
--50-59 - P
-- F

Select 
StudentID,
CourseID,
Mark,
CASE
	WHEN Mark IS NULL THEN 'Not Graded'
	WHEN Mark >=90 THEN 'A'
	WHEN Mark >=80 THEN 'B'
	WHEN Mark >=70 THEN 'C'
	WHEN Mark >=60 THEN 'D'
	WHEN Mark >=50 THEN 'P'
	ELSE 'F'
END as LetterGrade
from registration

--Update student balances. Subtract 25 from everyone balanceowing but only if they balancowing is at least 25 already. Otherwise, just set the balance to 0
 
Update Student
Set BalanceOwing = 
CASE
	WHEN BalanceOwing >=25 THEN BalanceOwing - 25
	ELSE 0
END  


