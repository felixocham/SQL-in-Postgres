CREATE OR REPLACE FUNCTION fn_revenue_year_compname(year numeric, compname varchar)
RETURNS numeric AS

$body$
	SELECT SUM(s1."Revenue") AS "Total Revenue"

	FROM
		(SELECT orderid
			,SUM ((unitprice - discount) * qty) AS "Revenue"
		FROM orderdetail
		GROUP BY orderid) AS s1
		LEFT JOIN salesorder sal ON s1.orderid = sal.orderid
		LEFT JOIN customer cus ON cus.custid = sal.custid
	GROUP BY cus.companyname
			,EXTRACT(year FROM sal.orderdate)
	HAVING EXTRACT(year FROM sal.orderdate)= year AND cus.companyname = compname
$body$

LANGUAGE SQL


SELECT fn_revenue_year_compname(2006, 'Around the Horn')
