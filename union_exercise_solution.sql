Select 'Student Born: ' || FirstName || ' ' || LastName as "Event:Name"
from student
where TO_CHAR(BirthDate,'FMMonth') = 'October'
UNION ALL
Select 'Staff Hired: ' || FirstName || ' ' || LastName
from staff
where TO_CHAR(DateHired,'FMMonth') = 'October'
order by "Event:Name"

