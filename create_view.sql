USE car_dealer ;
--
-- VIEW FOR CUSTOMER PAYMENT 
--
CREATE OR REPLACE VIEW customer_payment_view AS
       SELECT C.name AS customer_name,
       	      P.transaction_id AS transaction_id,
	      IF (P.type='emi', E.name, NULL) AS emi_name,
	      T.bank AS bank,
	      T.account_number AS account_number,
       	      T.date AS payment_date,
	      T.amount AS amount
       FROM customer_payment as P,
      	    customer AS C ,
	    customer_transaction AS T,
	    emi AS E,
	    registered AS R,
	    customer_order AS CO
       WHERE C.id = P.customer_id
	    and P.transaction_id=T.transaction_id
	    and IF (P.type='emi', R.emi_id = E.id
	    and CO.id = R.customer_order_id
	    and CO.customer_id = C.id, True);
--
-- VIEW FOR SALARY PAYMENTS
--
CREATE OR REPLACE VIEW salary_payment_view AS 
       SELECT T.transaction_id AS transaction_id,
	      E.name AS employee_name,
	      T.bank AS bank,
	      T.account_number AS account_number,
       	      T.date AS payment_date,
	      T.amount AS amount
       FROM give_salary AS S,
       	    employee AS E,
	    salary_transaction AS T
       WHERE S.employee_id = E.id
       	     and S.transaction_id=T.transaction_id
	     WITH CHECK OPTION;
--
-- VIEW FOR cusomer order
-- 
CREATE OR REPLACE VIEW customer_order_view AS
       SELECT
	C_ODR.id AS order_id,
	C.name AS customer_name,
	C_ODR.ETA AS ETA,
	C_ODR.status AS status,
	V.id AS vehicle_id,
	V.name AS vehicle_name,
	C_ODR.date AS order_date
       FROM
	customer AS C,
       	customer_order AS C_ODR,
       	vehicle as V,
	books AS B
       WHERE C.id=C_ODR.customer_id
	and V.id=B.vehicle_id
	and B.customer_order_id=C_ODR.id;
	
--
-- VIEW FOR GETTING DETAILS OF EMI
--
CREATE OR REPLACE VIEW vehicle_emi_view AS
       SELECT V.*,
	      E.name AS emi_name,
       	      E.no_of_installments as no_of_installments,
	      E.installment_amount as installment_amount
       FROM (vehicle AS V)
       	    INNER JOIN (has_offer AS O)
	    ON V.id=O.vehicle_id
	    INNER JOIN (emi AS E) ON E.id=O.emi_id ;


--
-- VIEW FOR GETTING DETAILS OF ORDERS NOT YET DELIVERED
--
CREATE OR REPLACE VIEW vehicles_not_delivered AS
	SELECT C.*, CO.ETA FROM `customer_order` AS CO, `customer` AS C
	WHERE CO.status <> 'DELIVERED' AND CO.customer_id=C.id;
