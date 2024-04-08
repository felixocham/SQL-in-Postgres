CREATE OR REPLACE VIEW employee_details AS
SELECT empid
		,CONCAT(titleofcourtesy,' ',lastname,' ',firstname) AS "Name"
		,EXTRACT(Year FROM AGE(birthdate)) AS "Employee Age"
		,EXTRACT(Year FROM AGE(hiredate,birthdate)) AS "Age_at_Hire"
		,EXTRACT(year FROM AGE(hiredate)) AS "Years_Worked"
		,phone
		,address
		,postalcode
		,city
		,country
FROM employee;

