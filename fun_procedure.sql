DELIMITER //

CREATE OR REPLACE FUNCTION check_phone_num (phone_no VARCHAR(20), t_name VARCHAR(20)) RETURNS  VARCHAR(20)
BEGIN
	DECLARE msg VARCHAR (120);
	SET msg = CONCAT('[table:', t_name, '] - `contact_number` column is not valid phone number');
	IF phone_no NOT RLIKE '^(\\+?[0-9]{1,3})?[0-9]{10}$' THEN
		SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = msg;
	ELSE
	BEGIN
		IF (LENGTH(phone_no)=10) THEN
		   SET phone_no = CONCAT('+91', phone_no);	   
		END IF;
		IF (phone_no NOT LIKE '+%') AND NOT (LENGTH(phone_no)=10) THEN
   		   SET phone_no = CONCAT('+', phone_no);		
		END IF;
	END;
	END IF;
	RETURN phone_no;

END//

CREATE OR REPLACE PROCEDURE check_email(IN email VARCHAR(255),
       	  	  	    		IN t_name VARCHAR(20))
BEGIN
	DECLARE msg VARCHAR(120);
	SET msg = CONCAT('[table:', t_name, '] - `email` column is not valid');
	IF email NOT LIKE '%_@%_.__%' THEN
	   SIGNAL SQLSTATE VALUE '45000'
	   	  SET MESSAGE_TEXT = msg;
	END IF;

END//

-- 
-- PROCEDURE TO INSERT CUSTOMER PAYMENT
--
CREATE OR REPLACE PROCEDURE insert_customer_payment(
       	  	  IN order_id INT,
       	  	  IN transaction_id VARCHAR(50),
		  IN type enum('advance','emi','normal'),
		  IN emi_id INT,
		  IN bank VARCHAR(100),
		  IN account_number VARCHAR(50),
		  IN payment_date DATE,
		  IN amount DECIMAL(12,2))
BEGIN
DECLARE customer_id INT ;
DECLARE _date DATE ;
SET customer_id = (SELECT C.customer_id
    		  FROM customer_order AS C
		  WHERE C.id=order_id);
SET _date = IF(ISNULL(payment_date), CURDATE(), payment_date);
INSERT INTO customer_transaction
       (transaction_id,
       bank,
       date,
       account_number,
       amount) VALUES (transaction_id,
       	       	      bank,
		      _date,
       		      account_number,
       		      amount);
INSERT INTO customer_payment(transaction_id, customer_id, type)
       VALUES (transaction_id, customer_id, type);
       IF type='emi' THEN
       	  INSERT INTO registered(customer_order_id,
				emi_id) VALUES
				(order_id, emi_id);
       END IF;
END //

-- 
-- PROCEDURE FOR INSERTING SALARY PAYMENT
--

CREATE OR REPLACE PROCEDURE insert_salary_payment(
       	  	  IN employee_id INT,
       	  	  IN transaction_id VARCHAR(50),
		  IN bank VARCHAR(100),
		  IN account_number VARCHAR(50),
		  IN payment_date DATE,
		  IN amount DECIMAL(12,2))
BEGIN
DECLARE salary DECIMAL(12,2) ;
DECLARE _date DATE ;
SET salary = (SELECT E.salary
    	     FROM Employee AS E
	     WHERE E.id=employee_id);
SET _date = IF(ISNULL(payment_date), CURDATE(), payment_date);
    IF NOT salary=amount THEN
       SIGNAL SQLSTATE VALUE '45000'
       SET MESSAGE_TEXT = 'THE SALARY OF EMPLOYEE AND PAYMENT ARE NOT MATCHING';
    END IF;
INSERT INTO salary_transaction
       (transaction_id,
       bank,
       date,
       account_number,
       amount) VALUES (transaction_id,
       	       	      bank,
		      _date,
       		      account_number,
       		      amount);
INSERT INTO give_salary(employee_id, transaction_id)
       VALUES (employee_id, transaction_id);
END //

--
-- PROCEDURE FOR GETTING SUMMARY OF SALARY PAID TO AN EMPLOYER
--
CREATE OR REPLACE PROCEDURE salary_summary(IN empid INTEGER)
BEGIN
	SELECT E.name, ST.date, ST.amount FROM `employee` AS E, `give_salary` AS GS, `salary_transaction` AS ST 
	WHERE E.id=empid AND GS.employee_id=empid AND ST.transaction_id=GS.transaction_id;
END//

DELIMITER ;
-- show procedure status \G;
-- show function status \G
