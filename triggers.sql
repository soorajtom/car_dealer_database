
DELIMITER //
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

DELIMITER ;
