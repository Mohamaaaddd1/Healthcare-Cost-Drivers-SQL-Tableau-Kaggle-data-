/* ============================================================================
   Healthcare Cost Drivers – Analysis (Views for Tableau + README)
   Author: Mohamad Abdelrahman
   Purpose: Create reusable views for KPIs + segment comparisons
   ========================================================================== */

USE healthcare;

-- Cleanly refresh files if ran again
DROP VIEW IF EXISTS vw_readme_summary;
DROP VIEW IF EXISTS vw_smoker_bmi_matrix;
DROP VIEW IF EXISTS vw_sex_impact;
DROP VIEW IF EXISTS vw_region_stats;
DROP VIEW IF EXISTS vw_children_impact;
DROP VIEW IF EXISTS vw_age_groups;
DROP VIEW IF EXISTS vw_bmi_categories;
DROP VIEW IF EXISTS vw_smoker_impact;
DROP VIEW IF EXISTS vw_kpis;
DROP VIEW IF EXISTS vw_patient_features;

-- 1) Feature engineering (age groups + BMI categories)
CREATE VIEW vw_patient_features AS
SELECT
  age,
  sex,
  bmi,
  children,
  smoker,
  region,
  charges,

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

-- 2) Global KPIs (population overview)
CREATE VIEW vw_kpis AS
SELECT
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(MIN(charges), 2) AS min_cost,
  ROUND(MAX(charges), 2) AS max_cost,
  ROUND(STDDEV_SAMP(charges), 2) AS stddev_cost,
  COUNT(*) AS patients
FROM insurance;

-- 3) Smoking impact
CREATE VIEW vw_smoker_impact AS
SELECT
  smoker,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY smoker;

-- 4) BMI groups impact (engineered view)
CREATE VIEW vw_bmi_categories AS
SELECT
  bmi_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM vw_patient_features
GROUP BY bmi_group
ORDER BY avg_cost DESC;

-- 5) Age groups impact
CREATE VIEW vw_age_groups AS
SELECT
  age_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM vw_patient_features
GROUP BY age_group
ORDER BY avg_cost DESC;

-- 6) Children / dependents impact
CREATE VIEW vw_children_impact AS
SELECT
  children,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY children
ORDER BY children;

-- 7) Region stats
CREATE VIEW vw_region_stats AS
SELECT
  region,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY region
ORDER BY avg_cost DESC;

-- 8) Sex impact
CREATE VIEW vw_sex_impact AS
SELECT
  sex,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost,
  ROUND(SUM(charges), 2) AS total_cost
FROM insurance
GROUP BY sex
ORDER BY avg_cost DESC;

-- 9) Smoking x BMI matrix 
CREATE VIEW vw_smoker_bmi_matrix AS
SELECT
  smoker,
  bmi_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_cost
FROM vw_patient_features
GROUP BY smoker, bmi_group
ORDER BY smoker, bmi_group;

-- 10) README summary view (quick numbers to quote)
CREATE VIEW vw_readme_summary AS
SELECT
  (SELECT ROUND(AVG(charges), 2) FROM insurance) AS avg_cost,
  (SELECT ROUND(MIN(charges), 2) FROM insurance) AS min_cost,
  (SELECT ROUND(MAX(charges), 2) FROM insurance) AS max_cost,
  (SELECT ROUND(STDDEV_SAMP(charges), 2) FROM insurance) AS stddev_cost,

  (SELECT ROUND(
     ( (SELECT AVG(charges) FROM insurance WHERE smoker='yes')
       / (SELECT AVG(charges) FROM insurance WHERE smoker='no') - 1
     ) * 100, 1
   )
  ) AS smoker_pct_higher
;
