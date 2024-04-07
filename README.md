# Amazon Sales Dataset
## Source: [Kaggle.com](https://www.kaggle.com/datasets/karkavelrajaj/amazon-sales-dataset)
## Introduction
This analysis presents the sales overview and trends of the dataset above. The sales overview is by product, size, region, shipping methods, and trends over the period of the dataset.
## Datacard
- product_id - Product ID
- product_name - Name of the Product
- category - Category of the Product
- discounted_price - Discounted Price of the Product
- actual_price - Actual Price of the Product
- discount_percentage - Percentage of Discount for the Product
- rating - Rating of the Product
- rating_count - Number of people who voted for the Amazon rating
- about_product - Description about the Product
- user_id - ID of the user who wrote review for the Product
- user_name - Name of the user who wrote review for the Product
- review_id - ID of the user review
- review_title - Short review
- review_content - Long review
- img_link - Image Link of the Product
- product_link - Official Website Link of the Product
## Entity Relationship Diagram (ERD)
![Entity Relationship Diagram.](ProjectERD.png)
## Data Analysis
1. Statistics
```
SELECT ship_state AS "Ship_State"
		,size AS "Size"
  	,SUM(gross_sales) AS "Total_Sales"
  	,SUM(no_of_transactions) AS "Total_Transactions"
```
2. Views
```
CREATE OR REPLACE VIEW processes AS
SELECT promotion
		,sales_channel
```
3. Database
```
CREATE TABLE location (
	loc_id varchar(100) PRIMARY KEY
```
4. Window Functions
```
GROUP BY s1.date
	,s1.month_no...
WINDOW w AS (PARTITION BY month_no ORDER BY s1.date ROWS BETWEEN UNBOUNDED preceding AND UNBOUNDED FOLLOWING);
```
5. Joins
```
FROM orders ord
LEFT JOIN location loc
						ON ord.loc_id = loc.loc_id
```
6. Filtering and Aggregation
```
GROUP BY 1,2
HAVING SUM(gross_sales) > 0
ORDER BY total_sales DESC
LIMIT 10;
```
### Why I Picked This Dataset
I am curious about how businesses perform in commercial markets based on regions and product categories, and Amazon, being a multi-national company in e-commerce fits that profile. I analyzed this dataset to sharpen my skills in recommendation systems.
