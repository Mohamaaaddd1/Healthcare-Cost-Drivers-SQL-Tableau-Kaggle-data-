# US Medical Healthcare Cost Drivers: SQL + Tableau Case Study
This project explores the drivers of individual healthcare costs using a U.S. insurance dataset. SQL is used to perform in-depth analytics with Common Table Expressions (CTEs) and Key Performance Indicators (KPIs), while Tableau brings the findings to life with an interactive dashboard.

The analysis highlights how lifestyle choices (smoking, BMI), demographics (age, dependents, sex), and geography (region) influence medical costs. This mirrors the type of work done in healthcare analytics, insurance risk assessment, and policy planning.

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


## 🛠️ Tools Used:
SQL (aggregation, grouping, CTEs, KPIs, CASE statements)

Tableau (interactive dashboarding, KPI cards, maps, bar/line/scatter plots)

Github (project documentation & version control)


## 💡 Why This Project Matters

Healthcare organizations, insurers, and policymakers need to understand the drivers of rising medical costs. By applying SQL + Tableau to patient-level data, this project simulates real-world analytics used to:

Design insurance pricing models

Identify high-risk populations

Support preventive health interventions

For employers, this project demonstrates data storytelling, SQL fluency, and dashboard creation skills — directly applicable to healthcare analytics, actuarial analysis, and risk management roles.
