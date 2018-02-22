CREATE OR REPLACE ROLE DBA;
GRANT ALL PRIVILEGES ON car_dealer.* TO DBA WITH GRANT OPTION;

CREATE OR REPLACE ROLE manager;
GRANT SELECT, DELETE, UPDATE, INSERT ON car_dealer.* TO manager WITH GRANT OPTION;

CREATE OR REPLACE ROLE accountant;
GRANT EXECUTE ON PROCEDURE car_dealer.insert_customer_payment TO accountant;
GRANT EXECUTE ON PROCEDURE car_dealer.insert_salary_payment_view TO accountant;
GRANT SELECT, UPDATE, DELETE ON car_dealer.customer_payment_view TO accountant;
GRANT SELECT, UPDATE, DELETE ON car_dealer.salary_payment TO accountant;
GRANT SELECT ON car_dealer.emi TO accountant;

GRANT SELECT ON car_dealer.customer_order_view TO accountant;
GRANT SELECT ON car_dealer.vehicle_emi_view TO accountant;





