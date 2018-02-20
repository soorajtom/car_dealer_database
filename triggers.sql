
DELIMITER //
DROP TRIGGER IF EXISTS `email_validate_customer` //
CREATE TRIGGER `email_validate_customer`
	BEFORE INSERT
	ON `customer`
	FOR EACH ROW
BEGIN
	IF NEW.`email` NOT LIKE '%_@%_.__%' THEN
		SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = '[table:person] - `email` column is not valid';
	END IF;
END;//

DROP TRIGGER IF EXISTS `phone_number_validate_customer` //
CREATE TRIGGER `phone_number_validate_customer`
	BEFORE INSERT
	ON `customer`
	FOR EACH ROW
BEGIN
	IF NEW.`contact_number` NOT RLIKE '^(\\+?[0-9]{1,3})?[0-9]{10}$' THEN
		SIGNAL SQLSTATE VALUE '45000'
			SET MESSAGE_TEXT = '[table:person] - `contact_number` column is not valid phone number';
	ELSE
	BEGIN
		IF NEW.`contact_number` NOT LIKE '+%' THEN
		SET new.contact_number = CONCAT('+91', new.contact_number);
		END IF;
	END;
	END IF;
END;//

DELIMITER ;
