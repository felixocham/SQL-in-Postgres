SELECT *
	   ,AVG(revenue_per_order) OVER() AS average_revenue_per_order
FROM
	(SELECT orderdate
		   ,orderid
		   ,SUM(revenue) revenue_per_order
	FROM prod_level
	GROUP BY orderdate
		   ,orderid) sub2
