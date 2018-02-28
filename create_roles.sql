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


