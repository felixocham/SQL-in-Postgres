--Impact of promotion on sales
CREATE OR REPLACE VIEW processes AS
SELECT promotion
		,sales_channel
		,ship_service_level
		,fulfil_party
		,courrier_status
		,SUM (gross_sales) AS total_sales
		,SUM(no_of_transactions) AS "No_of_Transactions"
		,shipping_status
FROM combined
GROUP BY promotion
		,sales_channel
		,ship_service_level
		,fulfil_party
		,courrier_status
		,shipping_status

SELECT *
FROM processes;


--Revenue where promotion used as percentage of total
WITH percentage AS(
SELECT *
	,SUM(total_sales) OVER() AS grand_total
FROM
		(SELECT promotion
				,SUM(total_sales) AS total_sales
				,SUM("No_of_Transactions") AS "No_of_Transactions"
		FROM processes 
		GROUP BY promotion) s3)
		
SELECT promotion
		,ROUND(total_sales/grand_total*100,2)||'%' AS "%_of_Total_Sales"
FROM percentage;


--shipping_status as a percentage of total transactions

WITH percentage AS(
SELECT *
	,SUM("No_of_Transactions") OVER() AS Total_Transactions
FROM
		(SELECT shipping_status
				,SUM("No_of_Transactions") AS "No_of_Transactions"
		FROM processes 
		GROUP BY shipping_status) s4)
		
SELECT shipping_status
		,"No_of_Transactions"
		,ROUND("No_of_Transactions"/Total_Transactions*100,2)||'%' AS "%_of_Total_Trans"
FROM percentage
ORDER BY 2 DESC;