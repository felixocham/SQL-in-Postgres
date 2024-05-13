SELECT *
FROM supplier

--checking if the query functions well before using it in a function
SELECT product.productname
	  ,product.unitsinstock
FROM product
JOIN supplier ON supplier.supplierid = product.supplierid
WHERE supplier.companyname = 'Exotic Liquids'

--creating a function using the tested query(The function return the inventory of a suppliers' products)
CREATE OR REPLACE FUNCTION fn_get_suppliers_units_stock(compname varchar)
RETURNS TABLE(prodname varchar, stock smallint) AS
$body$
	BEGIN
		RETURN QUERY
		SELECT  prod.productname
			  ,prod.unitsinstock
		FROM product prod
		JOIN supplier sup ON sup.supplierid = prod.supplierid
		WHERE sup.companyname = compname;
	END
$body$
LANGUAGE  plpgsql;

--using the function in a select statement and using a suppliers' company name as a parameter
SELECT (fn_get_suppliers_units_stock('Escargots Nouveaux')).*;

CREATE OR REPLACE FUNCTION fn_get_sum(val1 int, val2 int)
RETURNS int AS
$body$
	DECLARE
		ans int;
	BEGIN
		ans:= val1 + val2;
		RETURN ans;
	END
$body$
LANGUAGE plpgsql;

SELECT fn_get_sum(10, 17);

-- testing a function that generates a random number
CREATE OR REPLACE FUNCTION fn_get_random_number(min_val int, max_val int)
RETURNS int AS
$body$
	DECLARE
		rand int;
	BEGIN
		SELECT RANDOM()*(max_val - min_val) + min_val INTO rand;
		RETURN rand;
	END
$body$
LANGUAGE plpgsql

SELECT fn_get_random_number(14,22)

-- creating a function that returns a random employee name
SELECT *
FROM employee

CREATE OR REPLACE FUNCTION fn_get_rand_employee()
RETURNS varchar AS
$body$
	DECLARE
		rand int;
		emp record;
	BEGIN
		SELECT RANDOM()*(9 - 1) -1 INTO rand;
		SELECT *
			FROM employee
			INTO emp
			WHERE empid = rand;
			RETURN CONCAT(emp.titleofcourtesy,' ',emp.firstname,' ',emp.lastname);
	END;
$body$
LANGUAGE plpgsql;

SELECT fn_get_rand_employee()


SELECT TO_CHAR(birthdate, 'Dy')
FROM employee;

--create a function that gets the names of employees whose birthday falls in a given month.
CREATE OR REPLACE FUNCTION fn_get_employee_bday(IN the_month int, OUT bd_month text,
												OUT bd_day text, OUT emp_name text, OUT cong_msg text)
AS
$body$
	BEGIN
		SELECT TO_CHAR(birthdate, 'Mon'), TO_CHAR(birthdate, 'Dy'), CONCAT(titleofcourtesy,' ',firstname,' ',lastname),
		CONCAT('Happy birthday super for ', AGE(hiredate), ' with us') INTO bd_month, bd_day, emp_name, cong_msg
		FROM  employee
		WHERE EXTRACT(month FROM birthdate) = the_month;
		
	END;
$body$
LANGUAGE plpgsql;

SELECT * 
FROM fn_get_employee_bday(2);
												