CREATE OR REPLACE VIEW costing AS
SELECT sal.orderid
	   ,cus.companyname
	   ,CONCAT(emp.titleofcourtesy,' ',emp.lastname,' ',Emp.firstname) AS "Sales_Rep_Name"
	   ,sal.requireddate-sal.orderdate AS "OrderToRequired"
	   ,sal.shippeddate-sal.orderdate AS "OrderTo Ship"
	   ,sal.freight
	   ,shi.companyname AS "Shipping Company"
	   ,sal.shipcity
	   ,sal.shipcountry
FROM salesorder sal
JOIN employee emp
					ON sal.empid = emp.empid
JOIN customer cus
					ON sal.custid = cus.custid
JOIN shipper shi
					ON sal.shipperid = shi.shipperid				
--WHERE productname = 'Ikura'
--ORDER BY orderid;

CREATE OR REPLACE VIEW reports_by_order AS
SELECT sub3.orderid
	   ,"Revenue"
	   ,cos.companyname
	   ,cos."Sales_Rep_Name"
	   ,cos."OrderToRequired"
	   ,cos."OrderTo Ship"
	   ,cos.freight
	   ,cos."Shipping Company"
	   ,cos.shipcity
	   ,cos.shipcountry
FROM
	(SELECT orderid
		   ,SUM(revenue) AS "Revenue"
	FROM prod_level
	GROUP BY orderid)sub3
	JOIN costing cos
						ON sub3.orderid = cos.orderid;
