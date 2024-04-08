CREATE OR REPLACE VIEW prod_level AS
SELECT ord.orderid
	   ,pro.productname
	   ,cat.categoryname
	   ,(ord.unitprice - ord.discount)*ord.qty AS revenue
	   ,ord.qty
	   ,cus.companyname
	   ,CONCAT(emp.titleofcourtesy,' ',emp.lastname,' ',Emp.firstname) AS sale_rep_name
	   ,sal.orderdate
	   ,sal.requireddate
	   ,sal.shippeddate
	   ,sal.shipcity
	   ,sal.shipcountry
FROM orderdetail ord
JOIN salesorder sal
					ON ord.orderid = sal.orderid
JOIN product pro
					ON ord.productid = pro.productid 
JOIN category cat
					ON pro.categoryid = cat.categoryid
JOIN employee emp
					ON sal.empid = emp.empid
JOIN customer cus
					ON sal.custid = cus.custid;