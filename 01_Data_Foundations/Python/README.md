# 🐍 Python for Data Science: Employment Analysis in Madrid

This repository contains the Python development and data processing projects for the **Master in Big Data, Data Science, & AI**. The practice focuses on analyzing the profiles of people registered in the **Employment Agency of the Madrid City Council** during 2025.

## 🎯 Project Goals
The main objective was to process a large-scale dataset (approx. 30MB) containing registration dates, demographics (gender, age, nationality), and professional goals of citizens seeking employment.

The project is divided into two main technical stages:

### 1. Pure Python & Data Engineering (`01_python.ipynb`)
* **Custom Sampling:** Developed a `gen_sample` function to create statistically representative subsets of the data using the `random` module.
* **Data Cleaning:** Managing diverse events and granular details to ensure data consistency.
* **Efficiency:** Reading and processing large CSV files using standard libraries to optimize memory usage.

### 2. Advanced Data Wrangling with Pandas (`02_pandas.ipynb`)
* **DataFrame Transformation:** Loading and structuring data into complex DataFrames, including custom date parsing and string sanitization (handling extra spaces in district descriptions).
* **Feature Engineering:** Creating new metrics like `MONTH_REGISTRATION` and `YEAR_REGISTRATION` to enable time-series analysis.
* **Exploratory Data Analysis (EDA):** Aggregating profiles by district, age, and nationality to identify employment trends in the city.

---

## 🛠️ Tech Stack
* **Language:** Python 3.x
* **Libraries:** `Pandas`, `NumPy`, `Matplotlib` (for visualization), and `Pytest` (for unit testing and quality assurance).
* **Environment:** Jupyter Notebooks.

## 📊 Key Findings
The analysis allowed us to:
1.  Map the geographical distribution of job seekers across Madrid's districts.
2.  Analyze the most sought-after professional roles (e.g., Building Janitors, Shop Salespersons, Construction Laborers).
3.  Track registration peaks throughout the year to understand seasonal employment demands.

---

## 📂 Deliverables
* `01_python.ipynb`: Scripting, sampling logic, and data structure foundations.
* `02_pandas.ipynb`: Advanced analysis, DataFrame operations, and visualization.
* `testing.py`: A comprehensive suite of tests to ensure the integrity of the developed functions.

---

### 💡 Why this matters?
In the context of **Big Data and AI**, managing the diversity of events and details is crucial. This project demonstrates the ability to take raw, messy public data and transform it into a structured format ready for predictive modeling or business intelligence.
