# 🗳️ Spanish Municipal Electoral Analysis: Data Mining & Predictive Modeling

An econometric and statistical analysis of electoral behavior at the municipal level in Spain. Using a dataset of socioeconomic, demographic, and territorial variables (`DatosEleccionesEspaña.xlsx`),[...]

---

## 📌 Table of Contents

* [Overview](#-overview)
* [Repository Structure](#-repository-structure)
* [Data Pipeline & Preprocessing](#-data-pipeline--preprocessing)
* [Models & Results](#-models--results)
* [1. Linear Regression (Abstention Rate)](#1-linear-regression-abstentionptge)
* [2. Logistic Regression (Left-Wing Victory)](#2-logistic-regression-izquierda)


* [Tech Stack & Dependencies](#-tech-stack--dependencies)
* [Quickstart](#-quickstart)
* [Author & Academic Context](#-author--academic-context)

---

## 📖 Overview

This project investigates key socioeconomic and regional drivers behind electoral participation and political orientation across 8,117 Spanish municipalities. By applying statistical quality filters, [...]

1. **Abstention Rate (`AbstentionPtge`)**: Continuous target modeled via OLS Linear Regression.


2. **Left-Wing Block Victory (`Izquierda`)**: Binary classification target modeled via Logistic Regression with optimal decision boundary tuning.



---

## 📁 Repository Structure

```text
.
├── DatosEleccionesEspaña.xlsx            # Primary dataset (8,117 municipalities, 41 variables)
├── FuncionesMineria.py                    # Custom Python helper module (data processing & evaluation)
├── CarlosSanRomanCazorla_MineriaDatos_I.pdf # Full methodological report & execution outputs
└── README.md                              # Repository documentation

```

* **`DatosEleccionesEspaña.xlsx`**: Raw dataset containing municipal-level indicators.


* **`FuncionesMineria.py`**: Custom library providing utility functions for descriptive statistics, outlier conversion, imputation, stepwise feature selection, and repeated cross-validation.


* **`CarlosSanRomanCazorla_MineriaDatos_I.pdf`**: In-depth academic document detailing the full statistical rationale and test outputs.



---

## 🧹 Data Pipeline & Preprocessing

The raw dataset underwent strict quality engineering prior to model fitting:

* **Target Isolation**:
* Selected `AbstentionPtge` (continuous) and `Izquierda` (binary) as primary target variables.


* Dropped unused target variables (`Izda_Pct`, `Dcha_Pct`, `Otros_Pct`, `AbstencionAlta`, `Derecha`) to eliminate target leakage.




* **Identifier Filtering**:
* Removed `Name` due to high cardinality (8,117 unique categories) to prevent overfitting and dummy explosion.




* **Inconsistency Resolution**:
* Converted `'?'` string codes in `Densidad` to missing values (`NaN`).


* Replaced sentinel value `99999` in `Explotaciones` with `NaN`.


* Filtered out-of-bounds percentage values (< 0% or > 100%) in `Age_over65_pct` and `ForeignersPtge` to `NaN`.




* **Robust Outlier Treatment**:
* Identified multivariate outliers using a combined Median Absolute Deviation (MAD) and Interquartile Range (IQR) criterion, remapping anomalous entries to missing values.




* **Missing Value Imputation**:
* Handled residual missingness via random imputation for quantitative (`ImputacionCuant`) and qualitative (`ImputacionCuali`) variables.





---

## 📊 Models & Results

### 1. Linear Regression (`AbstentionPtge`)

> **Goal:** Predict municipal abstention percentage without applying variable transformations or interaction terms.
> 
> 

* **Data Partitioning**: 70% Train (5,681 obs) / 30% Test (2,436 obs) with fixed seed random splitting.


* **Optimal Feature Selection**: Forward / Stepwise BIC.


* **Performance Metrics**:
* **Number of Parameters**: 62


* **Train R²**: 0.4241


* **Test R²**: 0.4180


* **20x5 Repeated Cross-Validation**: Mean R² = 0.4081 (SD = 0.0368)


* **Residual Diagnostics**: Durbin-Watson = 1.982 (indicates uncorrelated errors)




* **Top Explanatory Predictors**: `CodigoProvincia`, `SameComAutonPtge`, `ActividadPpal`.



---

### 2. Logistic Regression (`Izquierda`)

> **Goal:** Estimate the probability that the left-wing block secures more votes than competing political blocks in a municipality.
> 
> 

* **Optimal Feature Selection**: Stepwise AIC / BIC.


* **Performance Metrics**:
* **Number of Parameters**: 76


* **Train Pseudo-R²**: 0.3314


* **Test Pseudo-R²**: 0.3479


* **Test Area Under Curve (AUC)**: 0.8787


* **20x5 Repeated Cross-Validation**: Mean AUC = 0.8602




* **Decision Boundary Tuning**:
* Optimal decision threshold set at **0.21** using **Youden's J Statistic** to balance Sensitivity and Specificity.





#### Classification Matrix & Evaluation (Threshold = 0.21)

| Metric | Train Set | Test Set |
| --- | --- | --- |
| **Optimal Cutoff** | 0.21

 | 0.21

 |
| **Accuracy** | 76.78%

 | 78.12%

 |
| **Sensitivity (Recall)** | 83.28%

 | 83.93%

 |
| **Specificity** | 74.90%

 | 76.49%

 |
| **Negative Predictive Value (NPV)** | 93.94%

 | 94.42%

 |

* **Top Explanatory Predictors**: `CodigoProvincia`, `DifComAutonPtge`, `ActividadPpal`, `CCAA`.



---

## 🛠️ Tech Stack & Dependencies

* **Python 3.8+**
* **Data Manipulation**: `pandas`, `numpy`
* **Modeling & Statistics**: `scikit-learn`, `statsmodels`
* **Visualization**: `matplotlib`, `seaborn`
* **Excel I/O**: `openpyxl`

---

## 🚀 Quickstart

1. **Clone the repository**:
```bash
git clone https://github.com/your-username/spanish-electoral-analysis.git
cd spanish-electoral-analysis

```


2. **Install required packages**:
```bash
pip install pandas numpy matplotlib seaborn scikit-learn statsmodels openpyxl

```


3. **Run pipeline script**:
```python
import pandas as pd
from FuncionesMineria import (
    analizar_variables_categoricas,
    atipicosAmissing,
    ImputacionCuant,
    ImputacionCuali,
    lm_stepwise,
    glm_stepwise,
    sensEspCorte,
    curva_roc
)

# Load data
df = pd.read_excel('DatosEleccionesEspaña.xlsx')

# Execute pipeline functions...

```



---

## 👤 Author & Academic Context

* **Author:** Carlos San Román Cazorla


* **Institution:** Universidad Complutense de Madrid (UCM)


* **Program:** Master's in Artificial Intelligence, Big Data, and Data Science


* **Course:** Data Mining and Predictive Modeling I


* **Date:** May 2026
