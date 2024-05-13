--viewing the contents of the supplier table to make it visible while creating the trigger.
SELECT *
FROM  supplier;

--creating a suppplier audit table
CREATE TABLE supplieraudit(
	id SERIAL PRIMARY KEY,
	companyname varchar(40) NOT NULL,
	contactname varchar(30) NOT NULL,
	address varchar(60) NOT NULL,
	city varchar(15) NOT NULL,
	changedate TIMESTAMP NOT NULL
);

--creating a trigger function that will be bound to a trigger. This function updates the supplieraudit table when supplier table is updated.
CREATE OR REPLACE FUNCTION fn_supplieraudit()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS
$body$
	BEGIN
		IF 
			NEW.companyname <> OLD.companyname THEN
			INSERT INTO supplieraudit (companyname, contactname, address, city, changedate)
			VALUES
			(OLD.companyname, OLD.contactname, OLD.address, OLD.city, NOW());
		END IF;
		RAISE NOTICE 'Trigger Name: %', TG_NAME;
		RAISE NOTICE 'Table Name: %', TG_TABLE_NAME;
		RAISE NOTICE 'Operation: %', TG_OP;
		RAISE NOTICE 'When Executed: %', TG_WHEN;
		RAISE NOTICE 'Row or Stament: %', TG_LEVEL;
		RAISE NOTICE 'Table Schema: %', TG_TABLE_SCHEMA;
		RETURN NEW;

	END;
$body$
 

--creating a trigger and bing it to the trigger function.
CREATE TRIGGER tr_supplieraudit
	BEFORE UPDATE
	ON supplier
	FOR EACH ROW
	EXECUTE PROCEDURE fn_supplieraudit();

--Testing the created trigger by updating supplier table;

UPDATE supplier
SET companyname = 'Kyoto Traders'
WHERE supplierid = 4;

--updating the supplier table to its initial status.
UPDATE supplier
SET companyname = 'Tokyo Traders'
WHERE supplierid = 4;

--running the select stament to verify if the trigger is effective.
SELECT *
FROM supplieraudit;