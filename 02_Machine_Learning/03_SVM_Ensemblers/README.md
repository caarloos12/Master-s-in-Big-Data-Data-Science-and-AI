# Telco Customer Churn Prediction: SVM & Ensemble Learning

An end-to-end Machine Learning pipeline designed to predict customer churn for a telecommunications company using the dataset `BBDD_ML_TAREA.csv`. This project explores data cleaning, feature engineering, Support Vector Machines (Linear & RBF), and ensemble architectures (Bagging & Stacking) to maximize predictive performance.

---

## 📌 Project Overview

Customer churn poses a major challenge in the telecommunications sector. This repository contains the full analytical pipeline to identify at-risk customers, allowing the business to proactively execute retention campaigns.

### Key Objectives

* **Data Cleaning & Preprocessing:** Address duplicates, multicollinearity, missing values, and outliers.


* **Kernel Exploration:** Compare Linear SVM against Non-Linear (RBF) SVM kernels.


* **Ensemble Learning:** Evaluate performance gains using Bagging and Stacking ensemble methods.


* **Business Evaluation:** Determine the optimal balance between accuracy, AUC, and operational efficiency.



---

## 🛠️ Data Preprocessing & Feature Engineering

The dataset initially contained 9,200 observations. A rigorous Exploratory Data Analysis (EDA) and cleaning process was performed:

* **Duplicate Removal:** Identified and removed 5,661 duplicate entries. This revealed a realistic class imbalance (~80% retention vs. ~20% churn).


* **Feature Elimination:**
* Removed `V4` (phone number identifier).


* Dropped `V1` (US state) due to high cardinality and low predictive signal.


* Dropped cost variables `V10, V13, V16, V19` due to perfect collinearity ($r = 1.0$) with minute variables `V8, V11, V14, V17`.




* **Categorical Encoding:** Applied binary mapping to `V5` and `V6` (contracted plans) and One-Hot Encoding to `V3` (area code).


* **Missing Values:** Imputed missing values (<3% of total data, following an MCAR pattern) using feature medians.


* **Outliers:** Retained extreme values as they represent critical business signals (e.g., high customer service calls in `V20`) necessary for detecting churn intent.


* **Scaling:** Normalized all numerical attributes using `StandardScaler`.



---

## 🤖 Model Architectures

### 1. Linear SVM

* Applied class weighting (`class_weight='balanced'`) to handle class imbalance.


* Optimized the regularization parameter $C$.



### 2. Radial Basis Function (RBF) SVM

* Conducted a fine grid search to capture non-linear decision boundaries.


* Optimal hyperparameters found: $C = 50.1187$, $\gamma = 0.01$.



### 3. Bagging (RBF SVM)

* Combined 50 RBF SVM base estimators to reduce variance and enhance prediction stability.



### 4. Stacking Classifier

* **Level 0 Base Models:** RBF SVM, Random Forest, KNN, and Logistic Regression.


* **Level 1 Meta-Learner:** L2-regularized Logistic Regression ($C = 0.1$) trained on out-of-fold predictions.


* Feature importance assigned highest weights to Random Forest (~3.92) and RBF SVM (~1.91).



---

## 📊 Performance Comparison

Evaluation results on the unseen test dataset:

| Model | Test Accuracy | Test AUC | Recall (Class 1) | Characteristics |
| --- | --- | --- | --- | --- |
| **Linear SVM** | 76.08% | 84.93% | 81.10% | High explainability; struggles with non-linear relationships. |
| **RBF SVM** | 86.72% | 92.11% | 84.90% | Excellent balance between bias, variance, and complexity. |
| **Bagging (RBF SVM)** | 90.96% | 92.28% | 67.00% | Increases robustness, but reduces positive class recall. |
| **Stacking Classifier** | **94.35%** | **93.86%** | 80.70% | **Best overall accuracy**, minimizing overall false positives. |

---

## 💻 Tech Stack & Requirements

* **Python 3.8+**
* **scikit-learn**
* **pandas**
* **numpy**
* **matplotlib / seaborn**

```bash
# Clone repository
git clone https://github.com/your-username/telco-churn-svm-stacking.git
cd telco-churn-svm-stacking

# Install dependencies
pip install -r requirements.txt

```

---

## 💡 Key Takeaways & Recommendations

1. **For Production Performance:** The **Stacking Classifier** is recommended if the primary goal is maximizing overall accuracy (94.35%) and reducing false positives in commercial target campaigns.


2. **For Lightweight Deployment:** The standalone **RBF SVM** is the optimal choice if low inference latency and simple pipeline maintenance are required, maintaining a strong 92.11% AUC.



---
