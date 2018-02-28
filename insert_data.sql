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
-- INSERTING CUSTOMER DATA
--
INSERT INTO `customer` (`id`, `name`, `contact_number`, `address`, `email`, `age`) 
VALUES (1, 'Axel James', '9446695767', 'House no.42, 2FK street, Angamaly', 'axeljames644@gmail.com', '19'),
(2, 'Jude K Anil', '9446696867', '221B Baker street, Wayanad', 'judekanil@gmail.com', '65'),
(3, 'Libin N George', '8547275255', 'Neithelloor H, Koothattukulam', 'libinng@gmail.com', '42'),
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
-- INSERTING DATA FOR MANAGER
--
INSERT INTO `manager` (`id`, `name`, `address`, `salary`, `gender`) 
VALUES (1, 'Shivang Shukla', '214H, 32nd Street, Westland', '200000', 'male'),
(2, 'Sidhanth Thalian', 'Pookodethu H, Kallara, Kottayam', '175000', 'male'),
(3, 'Suresh Gopi', 'Lakshmi, Sasthamangalam, Kollam', '195000', 'male'),
(4, 'Jimmy Kimmel', '6840 Hollywood Blvd, Los Angeles', '190000', 'male');


--
-- INSERTING DATA FOR EMPLOYEE
--
INSERT INTO `employee` 
(`id`, `name`, `address`, `salary`, `gender`, `age`, `dept`, `managed_by`, `policy_manager`, `policy_join_date`, `policy_renewal_date`) 
VALUES (1, 'Seely Booth', '23A, BL street, Orleans', '80000', 'male', '35', 'broker', '1', '1', '2016-02-01', '2018-03-27'),
(2, 'Temperance Brennan', '23A, BL street, Orleans', '120000', 'female', '31', 'admin', '1', '1', '2016-02-01', '2018-03-27'),
(3, 'Sheldon Cooper', 'Neuhauser, Houston, Texas', '75000', 'male', '35', 'broker', '2', '2', '2016-08-14', '2018-03-27'),
(4, 'Sal Vulcano', '132A, Weighbridge, Rico', '112000', 'male', '35', 'auxiliary', '3', '1', '2016-06-13', '2018-03-27'),
(5, 'Chris Pratt', 'R216, Malcom St., Uphill', '80000', 'male', '35', 'human_resource', '4', '2', '2017-02-12', '2019-03-27'),
(6, 'Lisa Cuddy', 'A32, Licoln St., NewJearsy', '95000', 'female', '35', 'human_resource', '3', '1', '2017-01-24', '2019-03-27');


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

CALL insert_salary_payment(1, "ABCDEF123456", "0032", "256898456321", "2017-01-01", 86000);
CALL insert_salary_payment(1, "ABCDEF125346", "0032", "256898456321", "2017-02-01", 87000);
CALL insert_salary_payment(2, "ABCDEF124566", "0054", "256898456335", "2017-01-01", 129000);
CALL insert_salary_payment(2, "ABCDEF123215", "0063", "256825456335", "2017-02-01", 128000);
CALL insert_salary_payment(3, "ABCDEF123854", "0075", "256898452546", "2017-01-01", 76000);
CALL insert_salary_payment(3, "ABCDEF123488", "0031", "256845524321", "2017-02-01", 76000);
CALL insert_salary_payment(4, "ABCDEF122446", "0079", "424253556321", "2017-01-01", 113000);
CALL insert_salary_payment(5, "ABCDEF123336", "0064", "424253556321", "2017-01-01", 84000);

--
-- INSERTING DATA FOR CUSTOMER ORDERS
--
INSERT INTO `customer_order` 
(`id`, `ETA`, `status`, `date`, `customer_id`) VALUES 
('1', '2018-05-28', 'PENDING', '2018-02-28', '1'),
('2', '2018-04-18', 'PENDING', '2018-01-15', '3'),
('3', '2018-03-08', 'PENDING', '2018-01-12', '5'),
('4', '2018-02-28', 'PENDING', '2017-09-08', '2'),
('5', '2017-12-03', 'DELIVERED', '2017-02-13', '4'),
('6', '2017-11-09', 'DELIVERED', '2017-06-22', '5');

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
CALL insert_customer_payment(5, "ABCDEF133775", 'normal', NULL, "0034", "655453334568", "2017-12-02", 9490000);
CALL insert_customer_payment(6, "ABCDEF123439", 'advance', NULL, "0077", "655334578824", "2017-06-22", 120000);
CALL insert_customer_payment(6, "ABCDEF153784", 'normal', NULL, "0096", "453383334568", "2017-11-09", 97380000);


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
('1', 'Super 60', 'liability', '1');