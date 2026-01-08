/* ============================================================================
   Healthcare Cost Drivers (Data Load) - MySQL 8
   Author: Mohamad Abdelrahman
   Purpose: Load insurance.csv into healthcare.insurance (via LOCAL INFILE)
   Notes:
     - Run from MySQL CLI started with: mysql --local-infile=1 -u root -p
     - Update the CSV path below if you move the file
   ========================================================================== */

USE healthcare;

-- Optional: re-load cleanly (comment out if you don't want to wipe)
TRUNCATE TABLE insurance;

-- Update this path if needed
LOAD DATA LOCAL INFILE '/Users/mohamaaaddd_/Desktop/Anything Code/Healthcare-Cost-Drivers-SQL-Tableau-Kaggle-data-/insurance.csv'
INTO TABLE insurance
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(age, sex, bmi, children, smoker, region, charges);

-- Verify load
SELECT COUNT(*) AS row_count FROM insurance;      -- expect 1338
SELECT * FROM insurance LIMIT 5;
