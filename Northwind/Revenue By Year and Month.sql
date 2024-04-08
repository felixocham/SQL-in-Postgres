SELECT  DATE_PART('Year',orderdate) AS "Year"
	   ,DATE_TRUNC('month', orderdate) AS "EOMonth"
	   ,SUM(revenue) AS monthly_revenue
	   ,ROUND(AVG(revenue),2) AS avg_monthly_revenue
FROM prod_level 
GROUP BY ROLLUP (DATE_PART('Year',orderdate)
				,DATE_TRUNC('month', orderdate))
ORDER BY 1,2;
