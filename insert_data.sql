--
-- INSERTING VEHICLES DATA
--
INSERT INTO `vehicle` 
 (`id`, `name`, `price`, `mileage`, `cylinder_vol`, `transmission`, `max_speed`, `particulars`)
 VALUES (1, 'Toyota GT 86', '11300000', '8', '2000', '5', '310', NULL),
 (2, 'Lykan Hypersport', '12500000', '7.8', '3746', '6', '384', NULL),
 (3, 'Bugatti Veyron', '115500000', '3.3', '7993', '6', '407', 'Fastest Car in the world'),
 (4, 'Nissan 350Z', '9500000', '7.5', '3500', '5', '240', NULL),
 (5, 'Lamborghini Egoista', '23000000', '5.3', '5200', '5', '325', NULL),
 (6, 'Hennessey Venom GT', '47200000', '5.5', '5000', '7', '418', NULL),
 (7, 'Ferrari LaFerrari', '97500000', '3.8', '6262', '7', '349', NULL),
 (8, 'McLaren P1', '86400000', '3.5', '3799', '7', '350', NULL);

 --
 -- INSERTING VEHICLES COLOR DATA
 --

INSERT INTO `vehicle_color` 
(`id`, `color`) 
VALUES ('1', 'black'), 
('1', 'white'),
('2', 'golden'),
('3', 'silver'),
('3', 'gray'),
('3', 'red'),
('4', 'white'),
('5', 'black'),
('5', 'silver'),
('6', 'white'),
('7', 'red'),
('8', 'black'),
('8', 'silver');

--
-- INSERTING DATA FOR EMI PLANS
--
INSERT INTO `emi` 
(`id`, `name`, `no_of_installments`, `installment_amount`) VALUES 
('1', 'Mega 500 offer', '19', '500500'),
('2', 'Egoista, no Ego', '24', '959000'),
('3', 'Hennessey Venom on EMI', '30', '1574000');


--
-- INSERTING DATA FOR EMI SUPPORT FOR VEHICLES
--
INSERT INTO `has_offer` 
(`emi_id`, `vehicle_id`) VALUES 
('1', '4'),
('2', '5'),
('3', '6');

--
-- INSERTING DATA FOR INSURANCE COMPANY
--
INSERT INTO `insurance_company` 
(`id`, `name`, `contact_number`) VALUES 
('1', 'Tresslers Insurance', '9947286188'),
('2', 'WillWall Digital Insurance', '8547275255');

--
-- INSERTING DATA FOR VEHICLE INSURANCES
--
INSERT INTO `vehicle_insurance` 
(`id`, `policy_name`, `coverage`, `insurance_company_id`) VALUES 
('1', 'Super 60', 'liability', '1'),
('2', 'Auto Cover', 'collission', '2');


--
-- INSERTING CUSTOMER DATA
--
INSERT INTO `customer` (`id`, `name`, `contact_number`, `address`, `email`, `age`) 
VALUES (1, 'Axel James', '9446695767', 'House no.42, 2FK street, Angamaly', 'axeljames644@gmail.com', '19'),
(2, 'Jude K Anil', '9446696867', '221B Baker street, Wayanad', 'judekanil@gmail.com', '65'),
(3, 'Libin N George', '8547275255', 'Naithelloor H, Kottarakkara', 'libinng@gmail.com', '42'),
(4, 'Aneesh M M', '9446695767', 'Mathirappilli H, Ernakulam', 'aneeshmm@gmail.com', '42'),
(5, 'Sooraj Tom', '9947286188', 'Kandathil H, Poonjar, Kottayam', 'soorajkandathil@gmail.com', '29');

--
-- INSERTING DATA FOR POLICY MANAGERS
--
INSERT INTO `policy_manager` 
(`id`, `name`, `contact_number`, `email`) 
VALUES (1, 'Athul M A', '9494226565', 'athulma@gmail.com'),
 (2, 'Iqbal Muhammed', '7745622563', 'iqbalmuhammed@gmail.com');

--
-- INSERTING DATA FOR EMPLOYEE
--
INSERT INTO  `employee` 
(`id`, `name`, `address`, `salary`, `gender`, `age`, `dept`, `policy_manager`, `policy_join_date`, `policy_renewal_date`) 
VALUES (1, 'Shivang Shukla', '214H, 32nd Street, Westland', '200000', 'male', '35', 'manager', '1', '2016-02-01', '2018-03-27'),
(2, 'Sidhanth Thalian', 'Pookodethu H, Kallara, Kottayam', '175000', 'male', '35', 'manager', '1', '2016-06-13', '2018-03-27'),
(3, 'Suresh Gopi', 'Lakshmi, Sasthamangalam, Kollam', '195000', 'male', '35', 'manager', '1', '2017-01-24', '2019-03-27'),
(4, 'Jimmy Kimmel', '6840 Hollywood Blvd, Los Angeles', '190000', 'male', '35' , 'manager', '1', '2017-05-24', '2019-02-21'),
(5, 'Seely Booth', '23A, BL street, Orleans', '80000', 'male', '35', 'broker', '1', '2016-02-01', '2018-03-27'),
(6, 'Temperance Brennan', '23A, BL street, Orleans', '120000', 'female', '31', 'admin',  '1', '2016-02-01', '2018-03-27'),
(7, 'Sheldon Cooper', 'Neuhauser, Houston, Texas', '75000', 'male', '35', 'broker',  '2', '2016-08-14', '2018-03-27'),
(8, 'Sal Vulcano', '132A, Weighbridge, Rico', '112000', 'male', '35', 'auxiliary',  '1', '2016-06-13', '2018-03-27'),
(9, 'Chris Pratt', 'R216, Malcom St., Uphill', '80000', 'male', '35', 'human_resource', '2', '2017-02-12', '2019-03-27'),
(10, 'Lisa Cuddy', 'A32, Licoln St., NewJearsy', '95000', 'female', '35', 'human_resource', '1', '2017-01-24', '2019-03-27');

--
-- INSERT INTO managed_by TABLE
--
INSERT INTO `managed_by` (`employee_id`, `managed_by`) VALUES
('5', '1'),
('6', '1'),
('7', '2'),
('8', '1'),
('9', '4'),
('10', '3');


 --
 -- INSERTING DATA FOR DEPENDANTS
 --
 INSERT INTO `dependants` 
 (`name`, `age`, `employee_id`) 
 VALUES ('Clint Antony', '21', '1'), 
 ('S Somasekharan', '68', '2'),
 ('Jason Bourne', '45', '1'),
 ('Matt Daemon', '58', '4'),
 ('Navaneeth A', '28', '3');

--
-- INSERTING DATA FOR SALARY TRANSACTIONS
--
-- insert_salary_payment(
--        IN employee_id INT,
--        IN transaction_id VARCHAR(50),
-- 		  IN bank VARCHAR(100),
-- 		  IN account_number VARCHAR(50),
-- 		  IN payment_date DATE,
-- 		  IN amount DECIMAL(12,2))

CALL insert_salary_payment(5, "ABCDEF123456", "0032", "256898456321", "2017-01-01", 86000);
CALL insert_salary_payment(5, "ABCDEF125346", "0032", "256898456321", "2017-02-01", 87000);
CALL insert_salary_payment(6, "ABCDEF124566", "0054", "256898456335", "2017-01-01", 129000);
CALL insert_salary_payment(6, "ABCDEF123215", "0063", "256825456335", "2017-02-01", 128000);
CALL insert_salary_payment(7, "ABCDEF123854", "0075", "256898452546", "2017-01-01", 76000);
CALL insert_salary_payment(7, "ABCDEF123488", "0031", "256845524321", "2017-02-01", 76000);
CALL insert_salary_payment(8, "ABCDEF122446", "0079", "424253556321", "2017-01-01", 113000);
CALL insert_salary_payment(9, "ABCDEF123336", "0064", "424253556321", "2017-01-01", 84000);

--
-- INSERTING DATA FOR CUSTOMER ORDERS 5 & 6 DELIVERED
--
INSERT INTO `customer_order` 
(`id`, `ETA`, `status`, `date`, `customer_id`, `sold_by`) VALUES 
('1', '2018-05-28', 'PENDING', '2018-02-28', '1', '5'),
('2', '2018-04-18', 'PENDING', '2018-01-15', '3', '6'),
('3', '2018-03-08', 'PENDING', '2018-01-12', '5', '5'),
('4', '2018-02-28', 'PENDING', '2017-09-08', '2', '6'),
('5', '2017-12-03', 'PENDING', '2017-02-13', '4', '5'), 
('6', '2017-11-09', 'PENDING', '2017-06-22', '5', '6');

--
-- INSERING DATA FOR BOOKING TABLE
--
INSERT INTO `books` 
(`vehicle_id`, `customer_order_id`, `color`) VALUES 
('1', '1', 'white'),
('3', '2', 'silver'),
('5', '3', 'black'),
('2', '4', 'golden'),
('4', '5', 'white'),
('7', '6', 'red');


--
-- INSERTING VENDOR DETAILS
--
INSERT INTO `vehicle_vendor` 
(`id`, `address`, `date_of_join`, `name`, `email`, `comments`) VALUES 
('1', 'P.O. Box 283 8562 Fusce Rd., Frederick Nebraska', '2017-01-06', 'Lykan', 'support@lykan.com', NULL),
('2', '606-3727 Ullamcorper. Street, Roseville', '2017-01-06', 'Bugatti', 'sales@bugatti.com', NULL),
('3', '7292 Dictum Av., San Antonio MI', '2017-01-06', 'Nissan', 'sales@nissan.com', NULL),
('4', 'Ap #285-7193 Ullamcorper Avenue', '2017-01-06', 'Lamborghini', 'info@lamborghini.com', NULL),
('5', 'Miami Beach North Dakota 58563', '2017-01-06', 'Hennessey', 'care@hennessey.com', NULL),
('6', 'Arcu St., Rolling Hills Georgia', '2017-01-06', 'Ferrari', 'admin@ferrarri.com', NULL),
('7', 'Nascetur St., Hawthorne Louisiana', '2017-01-06', 'McLaren', 'manager@mclaren.com', NULL),
('8', 'Yorba Linda South Carolina 28423', '2017-01-06', 'Toyota', 'support@toyota.com', NULL);

--
-- INSRTING VENDOR ORDER 
--
INSERT INTO `vendor_order` 
(`id`, `vendor_id`, `vehicle_id`, `status`, `quantity`) VALUES 
('1', '3', '4', 'PENDING', '1'),
('2', '6', '7', 'PENDING', '1'),
('3', '8', '1', 'PENDING', '1'),
('4', '2', '3', 'PENDING', '1'),
('5', '4', '5', 'PENDING', '1'),
('6', '1', '2', 'PENDING', '1');

--
-- INSERTING THE LINK BETWEEN CUSTOMER AND VENDOR ORDER
--

INSERT INTO `vendor_order_customer_order` 
(`vendor_order_id`, `customer_order_id`) VALUES 
('1', '5'),
('2', '6'),
('3', '1'),
('4', '2'),
('5', '3'),
('6', '4');

--
-- UPDATES vender_order on arrival of vehicle
--

UPDATE `vendor_order` SET `status` = 'DELIVERED' WHERE id = 1;
UPDATE `vendor_order` SET `status` = 'DELIVERED' WHERE id = 2;

--
-- INSERTING DATA FOR DEALER VENDOR TRANSACTIONS
--
INSERT INTO `dealer_vendor_transaction` 
(`transaction_id`, `vendor_order_id`, `bank`, `date`, `account_number`, `amount`) VALUES 
('ABCDE56985634', '1', '0036', '2017-02-15', '546521684326', '600000'),
('ABCDE59558564', '2', '0034', '2017-06-28', '546521684326', '4600000'),
('ABCDE51540634', '2', '0085', '2017-11-15', '546521684326', '2600000'),
('ABCDE56024034', '3', '0075', '2018-03-01', '546521684326', '420000'),
('ABCDE59603234', '4', '0034', '2018-01-18', '546521684326', '600000'),
('ABCDE59500634', '5', '0097', '2018-01-15', '546521684326', '600000');

INSERT INTO `registered` (`customer_order_id`, `emi_id`) VALUES
(5, 1);

--
-- INSERTING DATA FOR CUSTOMER PAYMENT
--
-- PROCEDURE insert_customer_payment(
--        IN order_id INT,
--        IN transaction_id VARCHAR(50),
-- 		  IN type enum('advance','emi','normal'),
-- 		  IN emi_id INT, 
-- 		  IN bank VARCHAR(100),
-- 		  IN account_number VARCHAR(50),
-- 		  IN payment_date DATE,
-- 		  IN amount DECIMAL(12,2))

CALL insert_customer_payment(1, "ABCDEF123335", 'advance', NULL, "0051", "658951334568", "2018-02-28", 10000);
CALL insert_customer_payment(2, "ABCDEF139535", 'advance', NULL, "0075", "657454534568", "2018-01-15", 20000);
CALL insert_customer_payment(3, "ABCDEF243338", 'advance', NULL, "0035", "658534234568", "2018-01-12", 10000);
CALL insert_customer_payment(4, "ABCDEF969938", 'advance', NULL, "0074", "658599684568", "2017-09-08", 30000);
CALL insert_customer_payment(5, "ABCDEF127535", 'advance', NULL, "0014", "658453834568", "2017-02-13", 10000);
CALL insert_customer_payment(5, "ABCDEF133775", 'emi', NULL, "0034", "655453334568", "2017-12-02", 500500);
CALL insert_customer_payment(6, "ABCDEF123439", 'advance', NULL, "0077", "655334578824", "2017-06-22", 120000);
CALL insert_customer_payment(6, "ABCDEF153784", 'normal', NULL, "0096", "453383334568", "2017-11-09", 97380000);


--
-- INSERTING DATA FOR INSURANCES AVAILABLE FOR VEHICLES
--
INSERT INTO `has_insurance` 
(`customer_order_id`, `vehicle_insurance_id`, `renewal_date`) VALUES 
('5', '1', '2018-12-03'),
('6', '2', '2018-11-09');

CALL INITEMPLOYEE();
CALL INIT_VEHICLE_DEALER();
CALL INIT_INSURANCE_AGENT();
