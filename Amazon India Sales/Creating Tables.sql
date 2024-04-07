CREATE TABLE location (
	loc_id varchar(100) PRIMARY KEY
	,ship_state varchar(100)
	,ship_city varchar(100)
	,ship_postal_code varchar(100)
);
COPY location
FROM 'D:\SQLPractice Files\Amazon India\location.csv' DELIMITER ',' HEADER CSV;

SELECT *
FROM orders;

ALTER TABLE orders
ADD CONSTRAINT fk_loc_id FOREIGN KEY (loc_id)
REFERENCES location (loc_id);
