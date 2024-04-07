--ship_city with zero sales
SELECT ship_state
		,ship_city
		,SUM(gross_sales) AS total_sales
FROM combined
GROUP BY 1,2
HAVING SUM(gross_sales) = 0;

--top 10 ship city with highest sales
SELECT ship_state
		,ship_city
		,SUM(gross_sales) AS total_sales
FROM combined
GROUP BY 1,2
HAVING SUM(gross_sales) > 0
ORDER BY total_sales DESC
LIMIT 10;

SELECT ship_state
		,SUM(gross_sales) AS total_sales
FROM combined
GROUP BY ship_state
HAVING SUM(gross_sales) > 0
ORDER BY total_sales DESC
LIMIT 10;

--ship_state and product(top five categories in city state by total sales)

WITH loc_summ AS (
SELECT *
		,RANK() OVER(PARTITION BY ship_state ORDER BY total_sales
DESC) AS cat_rank
FROM
	(SELECT ship_state
			,category
			,SUM(gross_sales) AS total_sales
			,SUM(no_of_transactions) AS transactions
	FROM combined
	WHERE gross_sales > 0
	GROUP BY ship_state,category
	) S2)
SELECT *
FROM loc_summ
WHERE cat_rank <=5 AND ship_state<> 'BLANK';
