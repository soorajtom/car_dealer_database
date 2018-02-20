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
DELIMITER ;
