DROP TABLE customerdemographic;

ALTER TABLE orderdetail
ADD CONSTRAINT orderdetail_product FOREIGN KEY (productid)
REFERENCES product(productid);

ALTER TABLE product
ADD CONSTRAINT product_category FOREIGN KEY (categoryid)
REFERENCES category(categoryid),
ADD CONSTRAINT product_supplier FOREIGN KEY (supplierid)
REFERENCES supplier(supplierid);

ALTER TABLE salesorder
ALTER COLUMN custid
TYPE int
USING custid::integer;

ALTER TABLE salesorder
ADD CONSTRAINT salesorder_customer FOREIGN KEY (custid)
REFERENCES customer(custid);

ALTER TABLE salesorder
ADD CONSTRAINT salesorder_shipper FOREIGN KEY (shipperid)
REFERENCES shipper(shipperid);

ALTER TABLE orderdetail
ADD CONSTRAINT orderdetail_salesorder FOREIGN KEY (orderid)
REFERENCES salesorder(orderid);

ALTER TABLE salesorder
ADD CONSTRAINT salesorder_employee FOREIGN KEY (empid)
REFERENCES employee(empid);


ALTER TABLE employeeterritory
ADD CONSTRAINT employeeterritory_employee FOREIGN KEY (employeeid)
REFERENCES employee(empid);

ALTER TABLE employeeterritory
ADD CONSTRAINT employeeterritory_territory FOREIGN KEY (territoryid)
REFERENCES territory(territoryid);

ALTER TABLE territory
ADD CONSTRAINT territory_region FOREIGN KEY (regionid)
REFERENCES region(regionid);
