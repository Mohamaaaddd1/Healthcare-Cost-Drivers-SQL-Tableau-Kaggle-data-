/* =========================================================
   Healthcare Cost Drivers — Data Load
   Author: Mohamad Abdelrahman
   Purpose: Load insurance.csv into insurance table
   ========================================================= */

USE healthcare;

/* Optional: clear table before reload */
TRUNCATE TABLE insurance;

/* IMPORTANT:
   This script is meant to be run AFTER logging into MySQL with:
   mysql --local-infile=1 -u root -p
*/

LOAD DATA LOCAL INFILE '/Users/mohamaaaddd_/Desktop/Anything Code/Healthcare-Cost-Drivers-SQL-Tableau-Kaggle-data-/data/insurance.csv'
INTO TABLE insurance
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(age, sex, bmi, children, smoker, region, charges);

-- quick checks
SELECT COUNT(*) AS row_count FROM insurance;
SELECT * FROM insurance LIMIT 5;
