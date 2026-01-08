/* ============================================================================
   Healthcare Cost Drivers (Setup) - MySQL 8
   Author: Mohamad Abdelrahman
   Purpose: Create database + table for U.S. insurance cost analysis
   ========================================================================== */

CREATE DATABASE IF NOT EXISTS healthcare;
USE healthcare;


DROP TABLE IF EXISTS insurance;

CREATE TABLE insurance (
  age      INT NOT NULL,
  sex      VARCHAR(10) NOT NULL,
  bmi      DECIMAL(5,2) NOT NULL,
  children INT NOT NULL,
  smoker   VARCHAR(3) NOT NULL,
  region   VARCHAR(20) NOT NULL,
  charges  DECIMAL(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

