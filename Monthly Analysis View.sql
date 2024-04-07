--Monthly sale view
CREATE OR REPLACE VIEW monthy_sales AS
SELECT s1.date
		,s1.month_no
		,round(s1.total_daily_sales / s1.daily_transactions,2) AS avg_daily_sales
		,s1.daily_transactions
				
		
		,s1.total_daily_sales
		,sum(s1.total_daily_sales) OVER w AS total_monthly_sales
		,count(s1.date) OVER w AS trans_days
FROM
	(SELECT date 
			,TO_CHAR(date,'yyyy-mm') AS month_no
			,sum(gross_sales) AS total_daily_sales
			,sum(no_of_transactions) AS daily_transactions
	FROM combined
	GROUP BY date ,date_part('Month',date)
	) AS s1

GROUP BY s1.date
	,s1.month_no
	,s1.daily_transactions
	,round(s1.total_daily_sales / s1.daily_transactions,2)
	,s1.total_daily_sales 
WINDOW w AS (PARTITION BY month_no ORDER BY s1.date ROWS BETWEEN UNBOUNDED preceding AND UNBOUNDED FOLLOWING);



--Summary by month view
CREATE OR REPLACE VIEW summary_by_month AS
SELECT DISTINCT Month_no
		,total_monthly_sales
		,trans_days
		,ROUND(total_monthly_sales/trans_days,2) AS mothly_average
FROM monthy_sales;