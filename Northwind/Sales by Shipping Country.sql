SELECT shipcountry
		,shipcity
		,companyname
		--,sale_rep_name
		--,categoryname
		--,productname
		,SUM(revenue)  AS "Revenue"
		,SUM(qty) AS "Prod_Qty"
		,COUNT(orderid) AS "Num_orders"
FROM (SELECT DISTINCT orderid
		,productname
		,categoryname
		,revenue
		,qty
		,companyname
		,sale_rep_name
		--,orderdate
		--,requireddate
		--,shippeddate
		,shipcity
		,shipcountry
FROM prod_level) sub4
GROUP BY shipcountry
		,shipcity
		,companyname
		--,sale_rep_name
		--,categoryname
		--,productname
HAVING SUM(revenue)  > 20000
ORDER BY 1,4 DESC;