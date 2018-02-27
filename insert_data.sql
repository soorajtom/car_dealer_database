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
VALUES (1, 'Shivang Shukla', '214H, 32nd Street, Westland', '80000', 'male'),
(2, 'Sidhanth Thalian', 'Pookodethu H, Kallara, Kottayam', '75000', 'male'),
(3, 'Suresh Gopi', 'Lakshmi, Sasthamangalam, Kollam', '95000', 'male'),
(4, 'Jimmy Kimmel', '6840 Hollywood Blvd, Los Angeles', '90000', 'male');


--
-- INSERTING DATA FOR EMPLOYEE
--
INSERT INTO `employee` 
(`id`, `name`, `address`, `salary`, `gender`, `age`, `dept`, `managed_by`, `policy_manager`, `policy_join_date`, `policy_renewal_date`) 
VALUES (1, 'Seely Booth', '23A, BL street, Orleans', '61000', 'male', '35', 'broker', '1', '4', '2018-02-01', '2018-02-27'),
(2, 'Temperance Brennan', '23A, BL street, Orleans', '80000', 'female', '31', 'admin', '1', '4', '2018-02-01', '2018-02-27'),
(3, 'Sheldon Cooper', 'Newhauser, Pasadena, CA', '75000', 'male', '35', 'broker', '2', '3', '2017-02-01', '2018-02-27'),
(4, 'Seely Booth', '23A, BL street, Orleans', '61000', 'male', '35', 'broker', '1', '4', '2018-02-01', '2018-02-27'),
(5, 'Seely Booth', '23A, BL street, Orleans', '61000', 'male', '35', 'broker', '1', '4', '2018-02-01', '2018-02-27'),
(6, 'Seely Booth', '23A, BL street, Orleans', '61000', 'male', '35', 'broker', '1', '4', '2018-02-01', '2018-02-27'),


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
