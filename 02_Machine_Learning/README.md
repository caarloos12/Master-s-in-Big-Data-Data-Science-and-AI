# 🤖 Machine Learning & Applied Analytics (`02_Machine_Learning`)

> **Master’s Degree in Big Data, Data Science & Artificial Intelligence**
> A comprehensive suite of end-to-end Machine Learning implementations, ranging from statistical inference and classic supervised/unsupervised algorithms to deep learning architectures and specialized domain applications in **Geostatistics** and **Financial Modelling**.

---

## 📑 Table of Contents

* [📌 Module Overview](https://www.google.com/search?q=%23-module-overview)
* [📂 Repository Architecture](https://www.google.com/search?q=%23-repository-architecture)
* [🔬 Core Topics & Deliverables](https://www.google.com/search?q=%23-core-topics--deliverables)
* [💡 Specialized Domain Applications](https://www.google.com/search?q=%23-specialized-domain-applications)
* [🛠️ Tech Stack & Ecosystem](https://www.google.com/search?q=%23%EF%B8%8F-tech-stack--ecosystem)
* [📜 License](https://www.google.com/search?q=%23-license)

---

## 📌 Module Overview

This repository contains all code, notebooks, and analytical reports developed for the **Machine Learning** module. The primary goal is to bridge rigorous statistical theory with real-world predictive modeling and scalable machine learning workflows.

### **Key Takeaways & Capabilities:**

* **End-to-End Pipelines:** Data preprocessing, feature engineering, cross-validation strategies, and hyperparameter tuning (`GridSearchCV`, `Optuna`).
* **Supervised & Unsupervised Learning:** From foundational regression/classification models to complex ensemble architectures and spatial clustering.
* **Deep Learning Foundations:** Multi-Layer Perceptrons (MLP).
* **Domain Specializations:** Applied predictive analytics for high-frequency financial modeling and spatial geostatistical data.

---

## 📂 Repository Architecture

```text
02_Machine_Learning/
├── 01_Statistics_Foundations/       # Inferential statistics, hypothesis testing, EDA
├── 02_Data_Mining/                  # Association rules (Apriori), feature selection
├── 03_SVM/                          # Support Vector Machines (SVC / SVR + Kernels)
├── 04_Ensemble_Methods/             # Bagging, Boosting (XGBoost, LightGBM, CatBoost)
├── 05_PCA_Clustering/               # PCA, t-SNE, UMAP variance analysi, K-Means, Hierarchical, DBSCAN, Silhouette metrics
├── 07_Time_Series/                  # ARIMA/SARIMA, Prophet, Lag feature modeling
├── 08_Neural_Networks/              # Perceptrons, MLPs, CNNs, LSTMs (Keras / PyTorch)
├── Domain_Applications/
│   ├── Financial_Modelling/         # Risk scoring, algorithmic signals, portfolio optimization
│   └── Geostatistics/               # Spatial interpolation, Kriging, Spatial Autocorrelation
└── README.md                        # Module documentation

```

---

## 🔬 Core Topics & Deliverables

| Directory | Primary Algorithms / Techniques | Key Libraries |
| --- | --- | --- |
| **`01_Statistics`** | Hypothesis testing (t-test, ANOVA), distribution fitting, linear/logistic regression. | `scipy.stats`, `statsmodels` |
| **`02_Data_Mining`** | Association Rule Mining (Apriori, FP-Growth), outlier detection, data cleansing. | `mlxtend`, `pandas` |
| **`03_SVM`** | Linear & Kernel Support Vector Machines (RBF, Polynomial) for classification & regression. | `scikit-learn` |
| **`04_Ensemble_Methods`** | Random Forests, AdaBoost, Gradient Boosting, XGBoost, LightGBM, CatBoost. | `xgboost`, `lightgbm` |
| **`05_PCA`** | Principal Component Analysis, Scree plots, variance retention, t-SNE visualization. | `scikit-learn`, `matplotlib` |
| **`06_Clustering`** | K-Means, Agglomerative Hierarchical, DBSCAN, Silhouette & Elbow evaluation. | `scikit-learn`, `seaborn` |
| **`07_Time_Series`** | Stationarity tests (ADF), ARIMA/SARIMAX, Facebook Prophet, dynamic lag features. | `statsmodels`, `prophet` |
| **`08_Neural_Networks`** | Feedforward MLPs, CNNs for pattern recognition, RNN/LSTM for sequential data. | `tensorflow`, `torch` |

---

## 💡 Specialized Domain Applications

### 🏦 Financial Modelling (`/Domain_Applications/Financial_Modelling`)

* **Credit Risk Assessment:** Classification models predicting default probabilities using historical consumer credit data.
* 
### 🌍 Geostatistics (`/Domain_Applications/Geostatistics`)

* **Spatial Autocorrelation:** Quantifying spatial dependence using Moran's I and Geary's C statistics.
* **Geostatistical Interpolation:** Spatial prediction using Ordinary and Universal **Kriging**.
* **Spatial ML:** Distance-weighted feature embedding combined with spatial clustering algorithms (DBSCAN).

---

## 🛠️ Tech Stack & Ecosystem

* **Core Language:** Python 3.10+
* **Data Processing & Math:** `NumPy`, `Pandas`, `SciPy`
* **Machine Learning Frameworks:** `scikit-learn`, `XGBoost`, `LightGBM`, `CatBoost`
* **Deep Learning Frameworks:** `TensorFlow` / `Keras`, `PyTorch`
* **Time Series & Econometrics:** `statsmodels`, `prophet`, `arch`
* **Geospatial Processing:** `GeoPandas`, `Shapely`, `PyKrige`, `GSTools`
* **Data Visualization:** `Matplotlib`, `Seaborn`, `Plotly`

---

## 📜 License

Distributed under the **MIT License**. See `LICENSE` for more information.
