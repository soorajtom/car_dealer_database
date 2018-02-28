
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

DELIMITER ;
-- show triggers \G;

