CREATE OR REPLACE VIEW top_5_prod_by_cat AS

WITH prod_rank AS 
(SELECT *
	,RANK()OVER(PARTITION BY categoryname ORDER BY gross_revenue)
FROM
(SELECT categoryname
	   ,productname
	   ,SUM(revenue) AS gross_revenue 
FROM prod_level
GROUP BY  categoryname
	   	 ,productname))
SELECT *
FROM prod_rank
WHERE rank <= 5;
