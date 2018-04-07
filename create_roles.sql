CREATE OR REPLACE ROLE DBA;
GRANT ALL PRIVILEGES ON car_dealer.* TO DBA WITH GRANT OPTION;

CREATE OR REPLACE ROLE manager;
GRANT SELECT, DELETE, UPDATE, INSERT ON car_dealer.* TO manager WITH GRANT OPTION;

CREATE OR REPLACE ROLE accountant;
GRANT EXECUTE ON PROCEDURE car_dealer.insert_customer_payment TO accountant;
GRANT EXECUTE ON PROCEDURE car_dealer.insert_salary_payment TO accountant;
GRANT EXECUTE ON PROCEDURE car_dealer.pending_emi_payments TO accountant;
GRANT SELECT, UPDATE, DELETE ON car_dealer.customer_payment_view TO accountant;
GRANT SELECT, UPDATE, DELETE ON car_dealer.salary_payment_view TO accountant;
GRANT SELECT ON car_dealer.emi TO accountant;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.registered TO accountant;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.customer_transaction TO accountant;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.dealer_vendor_transaction TO accountant;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.salary_transaction TO accountant;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.customer_payment TO accountant;
GRANT SELECT ON car_dealer.customer_order_view TO accountant;
GRANT SELECT ON car_dealer.vehicle_emi_view TO accountant;
GRANT SELECT ON car_dealer.vendor_order TO accountant;

CREATE OR REPLACE ROLE broker;
GRANT SELECT ON car_dealer.customer_order_view TO broker;
GRANT SELECT ON car_dealer.vehicle_emi_view TO broker;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.customer TO broker;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.customer_order TO broker;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.books TO broker;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.customer_order TO broker;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.customer_order TO broker;
GRANT SELECT ON car_dealer.vehicle_insurance TO broker;
GRANT SELECT ON car_dealer.has_offer TO broker;
GRANT SELECT ON car_dealer.has_insurance TO broker;
GRANT SELECT ON car_dealer.vehicle TO broker;
GRANT SELECT ON car_dealer.registered TO broker;
GRANT SELECT ON car_dealer.insurance_company TO broker;
GRANT SELECT ON car_dealer.vehicle_insurance TO broker;
GRANT SELECT ON car_dealer.emi TO broker;
GRANT SELECT ON car_dealer.customer_payment TO broker;
GRANT SELECT ON car_dealer.customer_transaction TO broker;

CREATE OR REPLACE ROLE insurance_agent;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.insurance_company TO insurance_agent;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.vehicle_insurance TO insurance_agent;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.has_insurance TO insurance_agent;
GRANT SELECT ON car_dealer.vehicle TO insurance_agent;
GRANT SELECT ON car_dealer.customer TO insurance_agent;
GRANT SELECT ON car_dealer.customer_order TO insurance_agent;
GRANT SELECT ON car_dealer.books TO insurance_agent;

CREATE OR REPLACE ROLE vendor_company_dealer;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.vehicle TO vendor_company_dealer;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.vehicle_vendor TO vendor_company_dealer;
GRANT SELECT, UPDATE, DELETE, INSERT ON car_dealer.vendor_order TO vendor_company_dealer;
GRANT SELECT ON car_dealer.dealer_vendor_transaction TO vendor_company_dealer;




--
-- CREATING USER
--

DELIMITER //

CREATE OR REPLACE PROCEDURE create_user( IN username VARCHAR(30),
       	  	 	     IN `password` VARCHAR(30), IN role VARCHAR(30))
BEGIN
DECLARE stmt VARCHAR(100);
prepare stmt FROM CONCAT('CREATE USER IF NOT EXISTS ''', username, '''@''%'' IDENTIFIED BY ''',`password`, '''');
execute stmt;
DEALLOCATE PREPARE stmt;
prepare stmt FROM CONCAT('GRANT ', role , ' TO ''', username, '''');
execute stmt;
DEALLOCATE PREPARE stmt;
prepare stmt FROM CONCAT('SET DEFAULT ROLE ' , role,' FOR ''',  username, '''@''%''');
execute stmt;
DEALLOCATE PREPARE stmt;
END //


CREATE OR REPLACE PROCEDURE INITEMPLOYEE()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE username VARCHAR(30);
DECLARE role VARCHAR(30);
DECLARE _dept VARCHAR(20);
SELECT COUNT(*) FROM employee INTO n;
SET i = 0;
WHILE i<n DO
  SET username = (SELECT name FROM employee LIMIT i,1);
  SET _dept = (SELECT dept FROM employee LIMIT i,1);
  	IF (_dept = 'manager') THEN
		SET role = 'manager'; 
	END IF; 
	IF (_dept = 'accountant') THEN
		SET role = 'accountant';
	END IF;
	IF (_dept = 'broker') THEN
		SET role = 'broker';
	END IF;
	IF (_dept = 'admin') THEN
		SET role = 'DBA';
	END IF;
  CALL create_user(username, username, role);
  SET i = i + 1;
END WHILE;
END //

CREATE OR REPLACE PROCEDURE INIT_VEHICLE_DEALER()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE username VARCHAR(30);
DECLARE role VARCHAR(30);
SELECT COUNT(*) FROM vehicle_vendor INTO n;
SET role = 'vendor_company_dealer';
SET i = 0;
WHILE i<n DO
  SET username = (SELECT name FROM vehicle_vendor LIMIT i,1);
  CALL create_user(username, username, role);
  SET i = i + 1;
END WHILE;
END //


CREATE OR REPLACE PROCEDURE INIT_INSURANCE_AGENT()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE username VARCHAR(30);
DECLARE role VARCHAR(30);
SELECT COUNT(*) FROM insurance_company INTO n;
SET role = 'insurance_agent';
SET i = 0;
WHILE i<n DO
  SET username = (SELECT name FROM insurance_company LIMIT i,1);
  CALL create_user(username, username, role);
  SET i = i + 1;
END WHILE;
END //

DELIMITER ;

