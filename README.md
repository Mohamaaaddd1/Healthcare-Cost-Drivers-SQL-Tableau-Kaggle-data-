# US Medical Healthcare Cost Drivers: SQL + Tableau Case Study
This project explores the drivers of individual healthcare costs using a U.S. insurance dataset. SQL is used to perform analytics using CTEs (for KPI queries), KPI summary views, and CASE-based segmentation to compare costs across smoking status, BMI groups, age groups, family size, sex, and region. While Tableau brings the findings to life with an interactive dashboard.

The analysis highlights how lifestyle choices (smoking, BMI), demographics (age, dependents, sex), and geography (region) influence medical costs. This mirrors the type of work done in healthcare analytics, insurance risk assessment, and policy planning.

## 📋 Repository Structure

- `sql/`
  - `sql code/`
    - `01_setup_healthcare_costs.sql` – Creates database schema and tables
    - `02_load_data_healthcare_costs.sql` – Loads raw insurance data (run via MySQL CLI)
    - `03_analysis_healthcare_costs.sql` – Analysis queries, KPIs, and Tableau-ready views
  - `view exports/`
    - `vw_age_groups.tsv` - Average medical cost by age group to analyze how spending increases over the life course
    - `vw_bmi_categories.tsv` - Average medical cost by BMI category to assess the cost impact of obesity
    - `vw_children_impact.tsv` - Average medical cost by number of dependents, filtered for sufficient sample sizes
    - `vw_kpis.tsv` - High-level cost KPIs including average, min, max, and standard deviation across all patients
    - `vw_patient_features.tsv` - Patient-level dataset combining demographics, lifestyle factors, and costs
    - `vw_region_stats.tsv` - Average medical cost by U.S. region to identify geographic cost differences
    - `vw_sex_impact.tsv` - Average medical cost by sex to evaluate gender-based cost variation
    - `vw_smoker_bmi_matrix.tsv` - Medical costs segmented by smoking status and BMI to capture compounding risk effects
    - `vw_smoker_impact.tsv` - Average medical cost by smoking status to quantify smoking’s financial impact
- `tableau dashboard`
  - `Healthcare Cost Drivers.twbx` - Packaged Tableau workbook containing the full interactive dashboard built from SQL-derived views
- `data/`
  - `insurance.csv` – Raw dataset
- `README.md` – Project overview and findings


## 🎯 Objectives

Apply SQL for healthcare data analysis with CTEs and KPIs.

Identify key cost drivers of medical charges.

Create visual storytelling with Tableau to support healthcare decision-making.

Build a portfolio-ready project demonstrating technical and business-relevant skills.

## ❓ Key Questions Answered:
What lifestyle factors are the biggest cost drivers in healthcare?

* Do smokers pay significantly more than non-smokers?

* How does obesity (BMI ≥ 30) affect medical spending?

* Is there a “healthy baseline” for BMI groups?

How do healthcare costs evolve with age?

* Which age groups contribute most to total healthcare costs?

* Do costs rise steadily or accelerate at certain life stages?

Do family dynamics play a role in medical charges?

* Are larger families (more dependents) associated with higher average spending?

* Is there a cost efficiency or burden spread across families?

Are there geographic disparities in U.S. healthcare costs?

* Which regions face higher average charges?

* Do certain regions have lower or more stable costs?

How do population-level KPIs help summarize overall risk?

* What is the average cost per patient?

* What are the extremes (min & max charges)?

* How much variation (std. dev) exists in patient costs?


## 📈 Results:
Population Overview (KPIs)

* The average medical cost per person is $13,270, with charges ranging from $1,122 to $63,770.

* The standard deviation of ~$12,110 indicates wide variability in patient expenses, suggesting high-risk outliers.

Lifestyle Factors

* Smokers pay 280% more on average than non-smokers, making smoking the strongest individual cost driver.

* Obese patients (BMI ≥ 30) spend $5,143 more on average compared to those with a healthy BMI range (18.5–24.9).

Age & Life Stage

* Costs increase gradually in early adulthood but accelerate after age 50.

* Healthcare costs rise steadily with age, accelerating after 45. Seniors (60+) average $21,248 per year, more than double the costs of young adults ($9,182).

* The middle-age group (45–59) shows the steepest rise in average charges, signaling the onset of chronic conditions.

Family Burden

* Healthcare costs generally rise with family size, peaking at ~$15,355 for families with 3 children. Beyond that, averages decline, but due to very small sample sizes.

Regional Disparities

* The Southeast records the highest average charges, likely due to higher prevalence of obesity and smoking.

* The Southwest has the lowest average charges, while the Southeast has the highest, suggesting regional disparities tied to lifestyle and population risk factors.


## 📊 Tableau Dashboard

🔗 **Live Interactive Dashboard (Tableau Public):**  
https://public.tableau.com/views/HealthcareCostDrivers/HealthcareCostDriversWhoPaysMoreandWhy?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

The dashboard visualizes healthcare cost drivers across lifestyle, demographic, and geographic dimensions using SQL-generated analytical views.


## 🛠️ Tools Used:
SQL via VSCode & Terminal (CTEs for KPI queries, KPI/views for Tableau, aggregations, GROUP BY, and CASE-based segmentation)

Tableau (interactive dashboarding, KPI cards, maps, bar/line/scatter plots)

Github (project documentation & version control)

## ⚙️ Implementation Notes (Data Loading)

Note:
Data ingestion is performed via the MySQL command-line interface (CLI) using LOAD DATA LOCAL INFILE.
This approach was required due to client-side security restrictions that prevent some SQL editors (including VS Code SQL extensions) from executing local file imports.

All schema setup, analysis queries, CTEs, KPI views, and Tableau-ready outputs are fully reusable in any MySQL-compatible environment.

## 💡 Why This Project Matters

Healthcare organizations, insurers, and policymakers need to understand the drivers of rising medical costs. By applying SQL + Tableau to patient-level data, this project simulates real-world analytics used to:

Design insurance pricing models

Identify high-risk populations

Support preventive health interventions

For employers, this project demonstrates data storytelling, SQL fluency, and dashboard creation skills — directly applicable to healthcare analytics, actuarial analysis, and risk management roles.
