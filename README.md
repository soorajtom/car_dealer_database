# Car Dealer Database Management System

## ER Digram

![alt text](https://github.com/soorajtom/car_dealer_database/blob/master/Car_Dealer_ER.png)

## Testing 
 
1. Login to mysql/ maridb
	`mysql -u root -p` -p if you have password for root account
2. Use the command `source mymake.sql` for creating tables and inserting sample data.

## Running without inserting Test data
1. If you donot need to insert test data, remove `source insert_data.sql` from `mymake.sql` and run `source mymake.sql`

## Running FrontEnd

1. Go to the directory `frondend` and run the command `php -S <addr>:<port>`
1. For testing use `php -S localhost:8000` 
1. Now open a browser and go to `http://localhost:8000` (for testing). 
