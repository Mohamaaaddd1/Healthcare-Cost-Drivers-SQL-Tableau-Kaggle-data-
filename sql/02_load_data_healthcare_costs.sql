/* ============================================================================
   Healthcare Cost Drivers (Data Load) - MySQL 8
   Author: Mohamad Abdelrahman
   Purpose: Load insurance.csv into healthcare.insurance (via LOCAL INFILE)
   ========================================================================== */

USE healthcare;

-- Clean reload
TRUNCATE TABLE insurance;

LOAD DATA LOCAL INFILE '/Users/mohamaaaddd_/Desktop/Anything Code/Healthcare-Cost-Drivers-SQL-Tableau-Kaggle-data-/data/insurance.csv'
INTO TABLE insurance
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(age, sex, bmi, children, smoker, region, charges);

-- Verify load
SELECT COUNT(*) AS row_count FROM insurance;
SELECT * FROM insurance LIMIT 5;
