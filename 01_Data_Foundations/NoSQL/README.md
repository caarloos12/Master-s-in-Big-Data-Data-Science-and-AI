# 🌲 NoSQL Project: The "Budget Masterclass" XI

This project is part of the **NoSQL** module within the **Master in Big Data, Data Science, & AI**. The goal is to demonstrate the ability to handle flexible data schemas and perform exploratory analysis on real-world sports data.

## ⚽ Project Objective
The mission is to build the **optimal starting XI** from the top European leagues using a **limited budget**. 

Instead of just buying the stars, we use data to find "hidden gems"—players whose performance metrics (KPIs) are high but whose market value or salary remains low.

---

## 🛠️ Data Pipeline

1.  **Data Ingestion:**
    * Scraping and downloading updated datasets from major European leagues.
    * Data source: [Specify source, e.g., Football-Data.org API, FBRef, or Kaggle].
2.  **Storage (NoSQL):**
    * Importing raw JSON/BSON data into **MongoDB**.
    * Leveraging NoSQL's flexible schema to store diverse player statistics (goals, assists, xG, defensive actions, and financial data).
3.  **Exploratory Data Analysis (EDA):**
    * Querying the database to filter players by position and age.
    * Identifying correlations between price and performance.
4.  **Selection Criteria:**
    * **KPIs:** Analyzing Efficiency per Euro (Performance / Market Value).
    * **Constraint:** Total squad value must not exceed [€500M].

---

## 📊 Key Queries & Techniques
In this folder, you will find:
* **Aggregation Pipelines:** Used to calculate average performance metrics across different leagues.
* **Indexing:** Optimizing search queries for players by specific attributes.
* **Python Integration:** Using `PyMongo` to bridge the NoSQL database with our analysis environment.

---

## 🏆 The "Best Value" Eleven
*Final results and the list of the selected 11 players can be found in the `equipo_titular/` collecction or the final report notebook.*

---

### 💡 Why NoSQL for this?
Football data is highly dynamic. New metrics (like "Expected Threads" or advanced tracking) are added constantly. A NoSQL approach (Document-oriented) allows us to update player profiles without the rigid constraints of a traditional relational table.
