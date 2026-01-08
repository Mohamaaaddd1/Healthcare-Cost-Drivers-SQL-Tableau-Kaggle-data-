/* ============================================================================
   Healthcare Cost Drivers (Analysis) - MySQL 8
   Author: Mohamad Abdelrahman
   Purpose: Create segmentation + KPI views and answer project questions
   ========================================================================== */

USE healthcare;

-- ---------------------------------------------------------------------------
-- 0) Sanity checks
-- ---------------------------------------------------------------------------
SELECT COUNT(*) AS row_count FROM insurance;

-- ---------------------------------------------------------------------------
-- 1) Feature engineering view (CASE-based segmentation)
--    This is the "one dataset" you can connect Tableau to.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_patient_features AS
SELECT
  age,
  sex,
  bmi,
  children,
  smoker,
  region,
  charges,

  CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 29 THEN '18-29'
    WHEN age BETWEEN 30 AND 44 THEN '30-44'
    WHEN age BETWEEN 45 AND 59 THEN '45-59'
    ELSE '60+'
  END AS age_group,

  CASE
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi < 25 THEN 'Healthy'
    WHEN bmi < 30 THEN 'Overweight'
    ELSE 'Obese'
  END AS bmi_group,

  CASE
    WHEN children = 0 THEN '0'
    WHEN children = 1 THEN '1'
    WHEN children = 2 THEN '2'
    WHEN children = 3 THEN '3'
    ELSE '4+'
  END AS family_size
FROM insurance;

-- Quick peek
SELECT * FROM vw_patient_features LIMIT 10;

-- ---------------------------------------------------------------------------
-- 2) Population KPIs (view for Tableau KPI cards)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_kpis_population AS
SELECT
  COUNT(*) AS patient_count,
  ROUND(AVG(charges), 2) AS avg_charges,
  ROUND(MIN(charges), 2) AS min_charges,
  ROUND(MAX(charges), 2) AS max_charges,
  ROUND(STDDEV_SAMP(charges), 2) AS stddev_charges
FROM insurance;

SELECT * FROM vw_kpis_population;

-- ---------------------------------------------------------------------------
-- 3) Smoking impact (view)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_smoking_summary AS
SELECT
  smoker,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_charges
FROM insurance
GROUP BY smoker;

-- CTE KPI: how much more do smokers pay?
WITH s AS (
  SELECT smoker, AVG(charges) AS avg_charges
  FROM insurance
  GROUP BY smoker
)
SELECT
  ROUND((MAX(CASE WHEN smoker='yes' THEN avg_charges END) /
        MAX(CASE WHEN smoker='no'  THEN avg_charges END) - 1) * 100, 1) AS smoker_pct_more
FROM s;

SELECT * FROM vw_smoking_summary;

-- ---------------------------------------------------------------------------
-- 4) BMI groups (view)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_bmi_summary AS
SELECT
  bmi_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_charges
FROM vw_patient_features
GROUP BY bmi_group
ORDER BY
  CASE bmi_group
    WHEN 'Underweight' THEN 1
    WHEN 'Healthy' THEN 2
    WHEN 'Overweight' THEN 3
    WHEN 'Obese' THEN 4
    ELSE 99
  END;

-- CTE KPI: obese vs healthy difference ($)
WITH b AS (
  SELECT bmi_group, AVG(charges) AS avg_charges
  FROM vw_patient_features
  GROUP BY bmi_group
)
SELECT
  ROUND(MAX(CASE WHEN bmi_group='Obese' THEN avg_charges END) -
        MAX(CASE WHEN bmi_group='Healthy' THEN avg_charges END), 2) AS obese_minus_healthy
FROM b;

SELECT * FROM vw_bmi_summary;

-- ---------------------------------------------------------------------------
-- 5) Age groups (view)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_age_summary AS
SELECT
  age_group,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_charges
FROM vw_patient_features
GROUP BY age_group
ORDER BY
  CASE age_group
    WHEN 'Under 18' THEN 1
    WHEN '18-29' THEN 2
    WHEN '30-44' THEN 3
    WHEN '45-59' THEN 4
    WHEN '60+' THEN 5
    ELSE 99
  END;

SELECT * FROM vw_age_summary;

-- ---------------------------------------------------------------------------
-- 6) Family size (dependents) (view)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_family_summary AS
SELECT
  family_size,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_charges
FROM vw_patient_features
GROUP BY family_size
ORDER BY
  CASE family_size
    WHEN '0' THEN 1
    WHEN '1' THEN 2
    WHEN '2' THEN 3
    WHEN '3' THEN 4
    WHEN '4+' THEN 5
    ELSE 99
  END;

SELECT * FROM vw_family_summary;

-- ---------------------------------------------------------------------------
-- 7) Sex + Region (views)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_sex_summary AS
SELECT
  sex,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_charges
FROM insurance
GROUP BY sex;

CREATE OR REPLACE VIEW vw_region_summary AS
SELECT
  region,
  COUNT(*) AS patients,
  ROUND(AVG(charges), 2) AS avg_charges
FROM insurance
GROUP BY region
ORDER BY avg_charges DESC;

SELECT * FROM vw_sex_summary;
SELECT * FROM vw_region_summary;

-- ---------------------------------------------------------------------------
-- 8) README-friendly one-page “results” query (optional)
--    Use this if you want to quickly copy numbers into your README.
-- ---------------------------------------------------------------------------
SELECT
  (SELECT patient_count FROM vw_kpis_population) AS patient_count,
  (SELECT avg_charges FROM vw_kpis_population) AS avg_charges,
  (SELECT min_charges FROM vw_kpis_population) AS min_charges,
  (SELECT max_charges FROM vw_kpis_population) AS max_charges,
  (SELECT stddev_charges FROM vw_kpis_population) AS stddev_charges;
