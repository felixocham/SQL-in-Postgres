SELECT categoryname
	   ,productname
	   ,SUM(revenue) AS gross_revenue 
FROM prod_level
GROUP BY ROLLUP (categoryname
	   			,productname)
ORDER BY 1, 2;