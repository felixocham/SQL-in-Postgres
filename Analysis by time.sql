--1.) sales trends 
WITH cte_s_totals AS
(SELECT date
 	    --,DATE_PART('Month',date) AS Month_No
		,SUM(gross_sales) AS Total_daily_sales
		,SUM(no_of_transactions) AS daily_transactions
		,AVG(gross_sales) AS avg_daily_sales
FROM combined
GROUP BY date)
		--,DATE_PART('Month',date))

SELECT date
		--,Month_No
		,total_daily_sales
		,daily_transactions
		,avg_daily_sales
 		,ROUND(total_daily_sales/daily_transactions,2) AS avg_daily_sales1
FROM cte_s_totals ORDER BY date;