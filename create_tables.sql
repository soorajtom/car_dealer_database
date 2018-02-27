-- drop database if it exists
DROP DATABASE IF EXISTS car_dealer;

--
-- Current Database: `Car_dealer`
--

CREATE DATABASE `car_dealer`;

USE `car_dealer`;


--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE(`email`)
);


--
-- Table structure for table `insurance_company`
--

CREATE TABLE `insurance_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `contact_number` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Table structure for table `policy_manager`
--

CREATE TABLE `policy_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  UNIQUE(`email`),
  PRIMARY KEY (`id`)
) ;

--
-- Table structure for table `vehicle_vendor`
--

CREATE TABLE `vehicle_vendor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(500) NOT NULL,
  `date_of_join` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `comments` varchar(511) DEFAULT NULL,
  UNIQUE(`email`),
  PRIMARY KEY (`id`)
) ;


--
-- Table structure for table `customer_transaction`
--
CREATE TABLE `customer_transaction` (
  `transaction_id` varchar(50) NOT NULL,
  `bank` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  PRIMARY KEY (`transaction_id`)
) ;

--
-- Table structure for table `emi`
--
CREATE TABLE `emi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `no_of_installments` int(11) NOT NULL,
  `installment_amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(511) NOT NULL,
  `salary` int(11) NOT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;
--
-- Table structure for table `salary_transaction`
--

CREATE TABLE `salary_transaction` (
  `transaction_id` varchar(50) NOT NULL,
  `bank` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  PRIMARY KEY (`transaction_id`)
) ;


--
-- Table structure for table `dealer_vendor_transaction`
--

CREATE TABLE `dealer_vendor_transaction` (
  `transaction_id` varchar(50) NOT NULL,
  `bank` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  PRIMARY KEY (`transaction_id`)
);

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `color` varchar(100) NOT NULL,
  `mileage` decimal(5,2) NOT NULL,
  `cylinder_vol` decimal(5,2) NOT NULL,
  `transmission` int(11) NOT NULL DEFAULT '5',
  `max_speed` int(11) NOT NULL,
  `particulars` varchar(511) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Table structure for table `customer_order`
--

CREATE TABLE `customer_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ETA` date NOT NULL,
  `status` enum('PENDING','DELIVERED','IN_TRANSIT') NOT NULL,
  `date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `vehicle_id` int(11) NOT NULL,
  `customer_order_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_order_id`),
  FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (`customer_order_id`) REFERENCES `customer_order` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
); 

--
-- Table structure for table `customer_payment`
--

CREATE TABLE `customer_payment` (
  `transaction_id` varchar(50) NOT NULL,
  `order_id` int(11) NOT NULL,
  `type` enum('advance','emi','normal') NOT NULL DEFAULT 'normal',
  PRIMARY KEY (`transaction_id`,`order_id`),
  FOREIGN KEY (`transaction_id`) REFERENCES `customer_transaction` (`transaction_id`) ON DELETE NO ACTION,
  FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`id`) ON DELETE NO ACTION
) ;

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(511) NOT NULL,
  `salary` decimal(12,2) NOT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `age` int(11) NOT NULL,
  `dept` enum('admin','broker','auxiliary','human_resource') NOT NULL,
  `managed_by` int(11) DEFAULT NULL,
  `policy_manager` int(11) NOT NULL,
  `policy_join_date` date NOT NULL,
  `policy_renewal_date` date NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`managed_by`) REFERENCES `manager` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (`policy_manager`) REFERENCES `policy_manager` (`id`) ON UPDATE CASCADE
) ;

--
-- Table structure for table `dependants`
--
CREATE TABLE `dependants` (
  `name` varchar(60) NOT NULL,
  `age` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  PRIMARY KEY (`employee_id`, `name`)
) ;


--
-- Table structure for table `give_salary`
--

CREATE TABLE `give_salary` (
  `employee_id` int(11) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  PRIMARY KEY (`employee_id`,`transaction_id`),
  FOREIGN KEY (`transaction_id`) REFERENCES `salary_transaction` (`transaction_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ;
--
-- Table structure for table `vehicle_insurance`
--

CREATE TABLE `vehicle_insurance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(60) NOT NULL,
  `coverage` enum('liability','collission','comprehensive','personal_injury','underinsured_protection') NOT NULL DEFAULT 'liability',
  `insurance_company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`insurance_company_id`) REFERENCES `insurance_company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

--
-- Table structure for table `has_insurance`
--

CREATE TABLE `has_insurance` (
  `customer_order_id` int(11) NOT NULL,
  `vehicle_insurance_id` int(11) NOT NULL,
  `renewal_date` date NOT NULL,
  PRIMARY KEY (`customer_order_id`,`vehicle_insurance_id`),
  FOREIGN KEY (`customer_order_id`) REFERENCES `customer_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`vehicle_insurance_id`) REFERENCES `vehicle_insurance` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ;
--
-- Table structure for table `has_offer`
--

CREATE TABLE `has_offer` (
  `emi_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  PRIMARY KEY (`emi_id`,`vehicle_id`),
  FOREIGN KEY (`emi_id`) REFERENCES `emi` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

--
-- Table structure for table `registered`
--

CREATE TABLE `registered` (
  `customer_order_id` int(11) NOT NULL,
  `emi_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_order_id`),
  KEY `emi_id` (`emi_id`),
  FOREIGN KEY (`emi_id`) REFERENCES `emi` (`id`),
  FOREIGN KEY (`customer_order_id`) REFERENCES `customer_order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


--
-- Table structure for table `vendor_order`
--

CREATE TABLE `vendor_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `status` enum('PENDING','DELIVERED','IN_TRANSIT') NOT NULL DEFAULT 'PENDING',
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`transaction_id`) REFERENCES `dealer_vendor_transaction` (`transaction_id`),
  FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`),
  FOREIGN KEY (`vendor_id`) REFERENCES `vehicle_vendor` (`id`)
) ;

--
-- 
--
CREATE TABLE `vendor_order_customer_order` (
  `vendor_order_id` int(11) NOT NULL,
  `customer_order_id` int(11) NOT NULL,
  PRIMARY KEY (`vendor_order_id`, `customer_order_id`),
  FOREIGN KEY (`vendor_order_id`) REFERENCES `vendor_order` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`customer_order_id`) REFERENCES `customer_order` (`id`) ON DELETE CASCADE
);
