
DELIMITER //
--
-- CUSTOMER TABLE TRIGGERS
--
DROP TRIGGER IF EXISTS `email_validate_customer` //
CREATE TRIGGER `email_validate_customer`
	BEFORE INSERT
	ON `customer`
	FOR EACH ROW
BEGIN
	CALL check_email(new.email, 'customer');
END;//

DROP TRIGGER IF EXISTS `phone_number_validate_customer` //
CREATE TRIGGER `phone_number_validate_customer`
	BEFORE INSERT
	ON `customer`
	FOR EACH ROW
BEGIN
	SET NEW.contact_number = check_phone_num(NEW.contact_number, 'customer');
END;//
--
-- INSURANCE COMPANY TABLE TRIGGERS
--
DROP TRIGGER IF EXISTS `phone_number_validate_insurance_company` //
CREATE TRIGGER `phone_number_validate_insurance_company`
	BEFORE INSERT
	ON `insurance_company`
	FOR EACH ROW
BEGIN
	SET NEW.contact_number = check_phone_num(NEW.contact_number, 'insurance_company');
END;//
--
-- VEHICLE VENDOR TABLE TRIGGERS
--
DROP TRIGGER IF EXISTS `email_validate_vehicle_vendor` //
CREATE TRIGGER `email_validate_vehicle_vendor`
	BEFORE INSERT
	ON `vehicle_vendor`
	FOR EACH ROW
BEGIN
	CALL check_email(new.email, 'vehicle_vendor');
END;//

--
-- triggers for policy_manager
--

DROP TRIGGER IF EXISTS `email_validate_policy_manager` //
CREATE TRIGGER `email_validate_policy_manager`
	BEFORE INSERT
	ON `policy_manager`
	FOR EACH ROW
BEGIN
	CALL check_email(new.email, 'policy_manager');
END;//

DROP TRIGGER IF EXISTS `phone_number_validate_policy_manager` //
CREATE TRIGGER `phone_number_validate_policy_manager`
	BEFORE INSERT
	ON `policy_manager`
	FOR EACH ROW
BEGIN
	SET NEW.contact_number = check_phone_num(NEW.contact_number, 'policy_manager');
END;//

-- -
-- - TRIGGER FOR VALIDATING EMI OFFER FOR VEHICLES
-- -
DROP TRIGGER IF EXISTS `has_offer_validations` //
CREATE TRIGGER `has_offer_validations`
	BEFORE INSERT
	ON `has_offer`
	FOR EACH ROW
BEGIN
DECLARE amount DECIMAL(12,2);
DECLARE price DECIMAL(12,2);
SET amount = (SELECT no_of_installments*installment_amount
    	     FROM emi
	     WHERE id=new.emi_id);
SET price = (SELECT price
    	    FROM vehicle
	    WHERE id=new.vehicle_id);
	IF amount >= price THEN
	   SIGNAL SQLSTATE VALUE '45000'
	   SET MESSAGE_TEXT = '[table : has_offer] - total price of vehicle not matching emi aggregate';
	END IF;
END;//

-- -
-- - TRIGGER FOR VALIDATING CUSTOMER 
-- -

DROP TRIGGER IF EXISTS `validate_age` //
CREATE TRIGGER `validate_age`
	BEFORE INSERT
	ON `customer`
	FOR EACH ROW
BEGIN
	IF new.age < 18 THEN
	   SIGNAL SQLSTATE VALUE '45000'
	   SET MESSAGE_TEXT = '[table : customer] - customer should be atleast 18 years old';
	END IF;
END;//


-- -
-- - TRIGGER FOR VALIDATING EMI REGISTRATION 
-- -

DROP TRIGGER IF EXISTS `emi_register_check` //
CREATE TRIGGER `emi_register_check`
	BEFORE INSERT
	ON `registered`
	FOR EACH ROW
BEGIN
DECLARE v_id INT;
SET v_id = (SELECT vehicle_id FROM books WHERE customer_order_id = new.customer_order_id);
	IF new.emi_id NOT IN (SELECT emi_id FROM has_offer WHERE vehicle_id = v_id) THEN
	   SIGNAL SQLSTATE VALUE '45000'
	   SET MESSAGE_TEXT = '[table : registered] - emi_id entered is invalid for given vehicle';
	END IF;
END;//


DROP TRIGGER IF EXISTS `emi_avalibility_check` //
CREATE TRIGGER `emi_avalibility_check`
	BEFORE INSERT
	ON `customer_payment`
	FOR EACH ROW
BEGIN
DECLARE v_id INT;
SET v_id = (SELECT vehicle_id FROM books WHERE customer_order_id = new.order_id);
    IF new.type = 'emi' THEN
	IF NOT EXISTS (SELECT emi_id
	       	      FROM has_offer
	       	      WHERE vehicle_id = v_id) THEN
	   SIGNAL SQLSTATE VALUE '45000'
	   SET MESSAGE_TEXT = '[table : customer_payment] - emi plan does not exist for given vehicle';
	END IF;
    END IF;
END;//

--
-- CHANGE STATUS IN customer order on reciving Vendor order status change
--
DROP TRIGGER IF EXISTS `change_order_status` //
CREATE TRIGGER `change_order_status`
	AFTER UPDATE
	ON `vendor_order`
	FOR EACH ROW
BEGIN
DECLARE order_id INT;
SET order_id = (SELECT customer_order_id FROM vendor_order_customer_order WHERE vendor_order_id=new.id);
    IF new.status = 'DELIVERED' THEN
		UPDATE customer_order SET status='READY' WHERE id=order_id;
    END IF;
END;//

--
-- CHANGE STATUS IN customer order on reciving Vendor order status change
--
DROP TRIGGER IF EXISTS `change_order_status2` //
CREATE TRIGGER `change_order_status2`
	AFTER INSERT
	ON `vendor_order`
	FOR EACH ROW
BEGIN
DECLARE order_id INT;
SET order_id = (SELECT customer_order_id FROM vendor_order_customer_order WHERE vendor_order_id=new.id);
    IF new.status = 'DELIVERED' THEN
		UPDATE customer_order SET status='READY' WHERE id=order_id;
    END IF;
END;//

--
-- CHANGE STATUS IN customer order on inserting Vendor order 
--
DROP TRIGGER IF EXISTS `change_order_status1` //
CREATE TRIGGER `change_order_status1`
	AFTER INSERT
	ON `vendor_order_customer_order`
	FOR EACH ROW
BEGIN
	DECLARE status_ enum('PENDING','IN_TRANSIT','READY','DELIVERED');
	SET status_ = (SELECT status FROM customer_order WHERE id=new.customer_order_id);
	IF (status_='PENDING' ) THEN
		UPDATE customer_order SET status='IN_TRANSIT' WHERE id=new.customer_order_id;
	END IF;
END;//

--
-- CHANGE STATUS in customer order on inserting customer payment  
--
DROP TRIGGER IF EXISTS `change_order_status3` //
CREATE TRIGGER `change_order_status3`
	AFTER INSERT
	ON `customer_payment`
	FOR EACH ROW
BEGIN
DECLARE status_ enum('PENDING','IN_TRANSIT','READY','DELIVERED')	;
DECLARE amount_paid DECIMAL(12,2);
DECLARE v_price DECIMAL(12,2);
SET status_ = (SELECT status FROM customer_order WHERE id=new.order_id);
SET amount_paid = (SELECT SUM(T.amount)
    		  FROM customer_transaction AS T,
		  customer_payment AS P
		  WHERE P.order_id = new.order_id
		  AND P.transaction_id = T.transaction_id);
SET v_price = (SELECT V.price FROM books AS B, vehicle AS V , customer_order AS CO
    	      WHERE V.id = B.vehicle_id and CO.id = B.customer_order_id and CO.id = new.order_id );
	IF (status_='READY') THEN
	   IF new.type = 'emi' OR (amount_paid=v_price) THEN
	      UPDATE customer_order SET status='DELIVERED' WHERE id=new.order_id;
	   END IF;
	END IF;
END;//

--
-- CHECK STATUS of customer order on inserting customer payment (type ready)  
--

DROP TRIGGER IF EXISTS `check_for_normal_payment` //
CREATE TRIGGER `check_for_normal_payment`
	BEFORE INSERT
	ON `customer_payment`
	FOR EACH ROW
BEGIN
	DECLARE status_ enum('PENDING','IN_TRANSIT','READY','DELIVERED')	;
	SET status_ = (SELECT status FROM customer_order WHERE id=new.order_id);
	IF ((new.type = 'normal') AND (NOT status_='READY')) THEN
		SIGNAL SQLSTATE VALUE '45000'
	   	SET MESSAGE_TEXT = '[table : customer_payment] - Your Car has not reached showroom yet';
	END IF;
END;//

DELIMITER ;
-- show triggers \G;

