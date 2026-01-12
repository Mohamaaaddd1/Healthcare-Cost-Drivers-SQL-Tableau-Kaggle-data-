/* =========================================================
   Healthcare Cost Drivers — Analysis
   Author: Mohamad Abdelrahman
   Purpose: Views & KPIs for Tableau and README insights
   ========================================================= */

USE healthcare;

-- 1) Feature engineering view
CREATE OR REPLACE VIEW vw_patient_features
SQL SECURITY INVOKER
AS
SELECT
  age, sex, bmi, children, smoker, region, charges,
  CASE
    WHEN age < 18 THEN 'Child'
    WHEN age BETWEEN 18 AND 29 THEN 'Young Adult'
    WHEN age BETWEEN 30 AND 44 THEN 'Adult'
    WHEN age BETWEEN 45 AND 59 THEN 'Middle Age'
    ELSE 'Senior'
  END AS age_group,
  CASE
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi < 25 THEN 'Healthy'
    WHEN bmi < 30 THEN 'Overweight'
    ELSE 'Obese'
  END AS bmi_group
FROM insurance;

-- 2) Global KPIs
CREATE OR REPLACE VIEW vw_kpis
SQL SECURITY INVOKER
AS
SELECT
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(MIN(charges), 2) AS min_cost,
  ROUND(MAX(charges), 2) AS max_cost,
  ROUND(STDDEV_SAMP(charges), 2) AS stddev_cost,
  COUNT(*) AS n
FROM insurance;

-- 3) Smoking impact
CREATE OR REPLACE VIEW vw_smoker_impact
SQL SECURITY INVOKER
AS
SELECT
  smoker,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY smoker;

-- 4) BMI categories
CREATE OR REPLACE VIEW vw_bmi_categories
SQL SECURITY INVOKER
AS
SELECT
  bmi_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM vw_patient_features
GROUP BY bmi_group;

-- 5) Age groups
CREATE OR REPLACE VIEW vw_age_groups
SQL SECURITY INVOKER
AS
SELECT
  age_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM vw_patient_features
GROUP BY age_group;

-- 6) Children / family size
CREATE OR REPLACE VIEW vw_children_impact
SQL SECURITY INVOKER
AS
SELECT
  children,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY children
ORDER BY children;

-- 7) Region stats
CREATE OR REPLACE VIEW vw_region_stats
SQL SECURITY INVOKER
AS
SELECT
  region,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY region;

-- 8) Sex impact
CREATE OR REPLACE VIEW vw_sex_impact
SQL SECURITY INVOKER
AS
SELECT
  sex,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY sex;

-- 9) Smoker x BMI matrix
CREATE OR REPLACE VIEW vw_smoker_bmi_matrix
SQL SECURITY INVOKER
AS
SELECT
  smoker,
  bmi_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost
FROM vw_patient_features
GROUP BY smoker, bmi_group
ORDER BY smoker, bmi_group;

-- 10) README helper (nice summary table)
CREATE OR REPLACE VIEW vw_readme_summary
SQL SECURITY INVOKER
AS
SELECT
  (SELECT ROUND(AVG(charges),2) FROM insurance) AS avg_cost,
  (SELECT ROUND(MIN(charges),2) FROM insurance) AS min_cost,
  (SELECT ROUND(MAX(charges),2) FROM insurance) AS max_cost,
  (SELECT ROUND(STDDEV_SAMP(charges),2) FROM insurance) AS stddev_cost,
  (SELECT ROUND(AVG(charges),2) FROM insurance WHERE smoker='yes') AS smoker_avg,
  (SELECT ROUND(AVG(charges),2) FROM insurance WHERE smoker='no')  AS nonsmoker_avg,
  (SELECT ROUND(AVG(charges),2) FROM vw_patient_features WHERE bmi_group='Obese')  AS obese_avg,
  (SELECT ROUND(AVG(charges),2) FROM vw_patient_features WHERE bmi_group='Healthy') AS healthy_bmi_avg;