CREATE VIEW sales_by_region AS

SELECT regiondescription AS "Region"
		--,territorydescription AS "Territory"
		,"Sales_Rep_Name"
		,SUM("Revenue") AS "Revenue"
FROM reports_by_order
GROUP BY ROLLUP (regiondescription 
		--,territorydescription 
		,"Sales_Rep_Name")
ORDER BY 1 ASC,3 DESC;
