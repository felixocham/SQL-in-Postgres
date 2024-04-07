--select * from orders;
CREATE OR REPLACE VIEW combined AS
select 	ord.date
		,ord.fulfil_Party
		,ord.sales_channel
		,ord.ship_service_level
		,ord.courrier_status
		,COUNT(ord.rw_id) AS No_of_Transactions
		,SUM(ord.qty*ord.amount) AS gross_sales
		,ord.promotion
		,ord.b2b
		,ord.fulfilled_by
		,loc.ship_state
		,loc.ship_city
		,pro.prod_style
		,pro.category
		,siz.size
		,ord.shipping_status
FROM orders ord
LEFT JOIN location loc
						ON ord.loc_id = loc.loc_id
LEFT JOIN product pro
						ON ord.prod_id = pro.prod_id
LEFT JOIN size siz
						ON ord.size_id = siz.size_id
GROUP BY ord.date
		,ord.fulfil_Party
		,ord.sales_channel
		,ord.ship_service_level
		,ord.courrier_status
		,ord.promotion
		,ord.b2b
		,ord.fulfilled_by
		,loc.ship_state
		,loc.ship_city
		,pro.prod_style
		,pro.category
		,siz.size
		,ord.shipping_status;
		
SELECT *
FROM combined;

