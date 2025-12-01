# 🚴‍♀️ Yulu Shared Electric Cycle Demand Analysis

> Statistical analysis of Yulu bike rentals using hypothesis testing to uncover how weather, season, and working days influence ride demand.

---

## 📘 Project Overview  
Yulu, India’s leading **micro-mobility service**, offers shared electric bicycles across major cities. This project aims to analyze **daily rental patterns** to understand how external factors such as **weather, season, and working days** influence user demand.  

The dataset contains approximately **10,886 records** of daily rental data with variables like temperature, humidity, weather situation, and user counts (registered, casual, total).  

The goal is to derive **statistical insights** using **hypothesis testing** that can guide **data-driven operational decisions** such as fleet allocation, promotional campaigns, and service planning.

---

## 🎯 Business Problem

Yulu wants to **optimize operations and boost revenue** by understanding:
- Do **working days** influence the number of rides?  
- Does **weather condition** or **season** significantly affect total rentals?  
- Are **weather and season** interrelated?  

By answering these questions statistically, Yulu can:
- Forecast demand better.
- Optimize bike distribution.
- Plan **targeted promotions** during low-demand periods.
- Improve customer experience and operational efficiency.

---

## 🧮 Data Overview

| Variable | Description |
|-----------|--------------|
| **datetime** | Timestamp of observation |
| **season** | Season (1: Spring, 2: Summer, 3: Fall, 4: Winter) |
| **holiday** | Whether day is a holiday |
| **workingday** | 1 if not a weekend/holiday |
| **weather** | Weather (1: Clear, 2: Misty, 3: Light Rain, 4: Heavy Rain) |
| **temp**, **atemp** | Temperature, Feels-like temperature |
| **humidity** | Humidity |
| **windspeed** | Wind speed |
| **casual**, **registered**, **count** | Users (casual, registered, total) |

---

## ⚙️ Techniques & Methodology

### 🔹 Phase 1: Data Understanding & Cleaning
- Verified data types, non-null counts, and categorical distributions.  
- No missing values or inconsistencies found. The dataset is clean and ready for analysis.

### 🔹 Phase 2: Exploratory Data Analysis (EDA)
- **Univariate and bivariate analysis** performed using boxplots, histograms, and countplots.  
- Key findings:
  - Rentals are **right-skewed** — few high-demand days raise the average.  
  - **Registered users dominate** total rentals.  
  - Rentals peak in **summer and fall**, lowest in **winter**.  
  - **Clear weather** correlates with higher rentals.

### 🔹 Phase 3: Hypothesis Testing
Statistical tests were used to validate business questions.

| Test | Purpose | Result | Interpretation |
|------|----------|---------|----------------|
| **T-Test** | Rentals on working vs non-working days | p = 0.226 → Fail to reject H₀ | No significant difference — both types of days have similar rental demand. |
| **ANOVA (Season)** | Rentals across seasons | p < 0.001 → Reject H₀ | Rentals differ significantly across seasons. |
| **ANOVA (Weather)** | Rentals across weather conditions | p < 0.001 → Reject H₀ | Rentals vary significantly by weather type. |
| **Chi-Square Test** | Weather vs Season dependency | p < 0.001 → Reject H₀ | Weather patterns depend on seasons. |

---

## 📊 Key Insights

### **1. Working Day vs Rentals**
- Rentals are similar on working and non-working days.  
- Indicates **balanced usage** — both leisure and commute contribute to demand.

### **2. Weather Influence**
- Clear and mildly cloudy days see **significantly higher rentals**.  
- Rentals drop sharply during rain.  
- 💡 *Recommendation:* Offer **discounts or incentives** during rainy days to stabilize demand.

### **3. Seasonal Trends**
- Rentals are highest during **summer and fall**, lowest during **winter**.  
- 💡 *Recommendation:* Adjust **fleet deployment and maintenance schedules** seasonally.

### **4. Weather-Season Relationship**
- Statistically dependent (Chi-square).  
- 💡 *Recommendation:* Use **season and weather as predictive variables** in future demand forecasting models.

---

## 🧠 Business Takeaways

| Area | Insight | Recommendation |
|------|----------|----------------|
| **Fleet Optimization** | Weather and season strongly affect rentals | Allocate more bikes during clear weather and high-demand seasons |
| **Marketing** | Rentals drop in poor weather | Introduce rainy-day offers to maintain engagement |
| **Operations** | Stable usage across weekdays and weekends | Maintain a consistent fleet throughout the week |
| **Data Strategy** | Weather & season correlation | Include both in predictive and forecasting models |

---

## 🧰 Tools & Technologies

| Category | Tools |
|-----------|-------|
| **Programming Language** | Python |
| **Libraries Used** | Pandas, NumPy, Matplotlib, Seaborn, SciPy, Statsmodels |
| **Statistical Methods** | T-test, ANOVA, Chi-square, Levene’s Test, Shapiro-Wilk Test |
| **Visualization** | Boxplot, Countplot, Distribution Plot, QQ Plot |

---

## 📂 Project Structure
```
data/                # Dataset files  
notebooks/           # Pythin notebook  
reports/            # Final insights & recommendations (PDF)  
```

---

## 🚀 How to Reproduce
1. Clone the repository.  
2. Open the notebook: `notebooks/YuluBikeDemandAnalysis.ipynb`  
3. Run step-by-step analysis and review plots, sampling distributions, and confidence intervals.  
4. Check `/reports/` for visuals and final insights.

---

## Project Link
https://colab.research.google.com/drive/1PNuftQ90sMWoOwTGmfGlQTVbLZihdgxp?usp=sharing
