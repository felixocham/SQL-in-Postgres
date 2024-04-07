SELECT ship_state AS "Ship_State"
		,size AS "Size"
		,SUM(gross_sales) AS "Total_Sales"
		,SUM(no_of_transactions) AS "Total_Transactions"
FROM combined 
WHERE ship_state <> 'BLANK'
							AND courrier_status <>'Cancelled' 
							AND size NOT IN('3XL','4XL','5XL','6XL','Free')
GROUP BY ship_state
		,size
ORDER BY 1,4 DESC;


--SELECT *
--FROM COMBINED
