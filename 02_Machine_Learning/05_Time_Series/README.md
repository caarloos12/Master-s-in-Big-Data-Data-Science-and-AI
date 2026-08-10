# 🛸 UFO Sightings Time Series Analysis & Forecasting

[![Python Version](https://img.shields.io/badge/python-3.9%2B-blue.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-completed-brightgreen.svg)]()
[![University](https://img.shields.io/badge/UCM-Master_AI_%26_Data_Science-red.svg)](https://www.ucm.es/)

An econometric and predictive time series study applied to global UFO sightings registered between 1990 and 2014. The project evaluates and compares **Exponential Smoothing (Holt-Winters)** models against stochastic **SARIMA (Box-Jenkins)** models to model trend, seasonality, and generate 12-month ahead out-of-sample forecasts.

Developed as a term project for the **Time Series** course in the *Master's Degree in Artificial Intelligence, Big Data, and Data Science* at **Universidad Complutense de Madrid (UCM)**.

---

## 📋 Table of Contents

- [🛸 UFO Sightings Time Series Analysis \& Forecasting](#-ufo-sightings-time-series-analysis--forecasting)
  - [📋 Table of Contents](#-table-of-contents)
  - [📌 Dataset Overview](#-dataset-overview)
  - [🎯 Project Objectives](#-project-objectives)
  - [🔬 Methodology \& Workflow](#-methodology--workflow)
    - [1. Exploratory Data Analysis \& Decomposition](#1-exploratory-data-analysis--decomposition)
    - [2. Exponential Smoothing Models](#2-exponential-smoothing-models)
    - [3. SARIMA Modeling (Box-Jenkins Methodology)](#3-sarima-modeling-box-jenkins-methodology)
  - [📊 Model Performance Comparison](#-model-performance-comparison)
  - [🚀 Installation \& Usage](#-installation--usage)
  - [🛠️ Tech Stack](#️-tech-stack)
  - [👤 Author](#-author)
  - [📜 License](#-license)

---

## 📌 Dataset Overview

The study utilizes the open-source **[UFO Sightings Scrubbed](https://www.kaggle.com/datasets/NUFORC/ufo-sightings)** dataset from Kaggle, containing over 80,000 historical logs.

- **Time Frame:** Aggregated monthly from **January 1990** through **May 2014** ($N = 293$ monthly observations).
- **Rationale:** Data prior to 1990 was highly sparse and sporadic. From 1990 onwards (driven by increased public reporting and the growth of the internet in the 2000s), observation density enables robust seasonal pattern identification.
- **Train / Test Split:**
  - **Training Set:** 281 months (January 1990 – May 2013).
  - **Test Set:** 12 months (June 2013 – May 2014) for out-of-sample forecast validation.

---

## 🎯 Project Objectives

1. **Preprocessing & Aggregation:** Transform point-in-time sighting logs into a continuous, time-indexed monthly sequence.
2. **Decomposition:** Isolate and analyze Trend ($T_t$), Seasonality ($S_t$), and Residual ($Z_t$) components.
3. **Exponential Smoothing:** Fit Simple Exponential Smoothing (SES), Holt Linear, and Holt-Winters variants (additive vs. multiplicative, with/without log transformation).
4. **Box-Jenkins SARIMA Modeling:**
   - Test for variance and mean stationarity (ADF and KPSS tests).
   - Stabilize variance via **Box-Cox transformation** ($\lambda = 0.4415$).
   - Induce stationarity via seasonal differencing ($D=1, m=12$).
   - Identify, estimate, and validate optimal $(p,d,q)(P,D,Q)_{12}$ orders with coefficient significance and residual diagnostics (Ljung-Box, Jarque-Bera).
5. **Forecast Evaluation:** Compare Holt-Winters vs. SARIMA across a 12-month horizon using **MAE**, **RMSE**, and **MAPE** metrics.

---

## 🔬 Methodology & Workflow

### 1. Exploratory Data Analysis & Decomposition

The series exhibits a strong **upward trend** alongside **heteroscedastic seasonality** (the amplitude of seasonal peaks scales with the level of the series).

A **multiplicative decomposition** model was selected:

$$X_t = T_t \cdot S_t \cdot Z_t$$

* **Seasonal Pattern:** Consistent annual peaks during **summer months (July–August)**—attributed to favorable weather and outdoor activities—accompanied by smaller secondary bumps around year-end holidays.

---

### 2. Exponential Smoothing Models

Three levels of model complexity were systematically evaluated:

1. **Simple Exponential Smoothing (SES):** ($\alpha = 0.7774$). Unsuitable as it captures neither trend nor seasonality (yielding flat forecasts).
2. **Holt's Linear Trend:** Captures long-term growth but fails to model recurring seasonal spikes.
3. **Holt-Winters (Triple Smoothing):** Evaluated all 4 trend-seasonality combinations.

#### Holt-Winters Model Comparison (Original Series)

| Model (Trend, Seasonal) | $\alpha$ | $\beta$ | $\gamma$ | AIC | MAE (Test) | RMSE (Test) | MAPE (%) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **Additive, Additive** | 0.3662 | 0.0006 | 0.2250 | 2343.79 | 176.15 | 197.06 | 51.34% |
| **Additive, Multiplicative** | 0.2214 | 0.0003 | 0.2791 | 2359.27 | 140.64 | 163.82 | 53.76% |
| **Multiplicative, Additive** | 0.3937 | 0.0001 | 0.2206 | 2344.40 | 183.53 | 202.50 | 51.58% |
| **Multiplicative, Multiplicative** ⭐ | **0.2171** | **0.0001** | **0.2818** | **2361.86** | **123.92** | **154.51** | **53.96%** |

> **Note:** Although the *(Add, Add)* model yields a slightly lower AIC in training, the **Multiplicative-Multiplicative** model demonstrates superior generalizability on out-of-sample test data.

---

### 3. SARIMA Modeling (Box-Jenkins Methodology)

#### Step 1: Stationarity Verification

* **ADF Test:** $p$-value $= 0.9474 \rightarrow$ Non-stationary.
* **KPSS Test:** $p$-value $= 0.0100 \rightarrow$ Non-stationary.

#### Step 2: Transformations

1. **Variance Stabilization:** **Box-Cox transformation** with $\lambda = 0.4415$ ($\approx \sqrt{y_t}$).
2. **Mean Stationarity:** Seasonal differencing ($D=1, m=12$, $d=0$).
* **Post-differencing ADF:** $p$-value $= 0.0088 \rightarrow$ **Stationary**.
* **Post-differencing KPSS:** $p$-value $= 0.1000 \rightarrow$ **Stationary**.



#### Step 3: Model Identification & Fitting

Following a Parameter Grid Search and iterative pruning of non-significant parameters ($p\text{-value} > 0.05$), the optimal specification was selected:

$$\text{SARIMA}(1, 0, 1)(2, 1, 0)_{12}$$

#### Algebraic Expression of Estimated Model:

$$(1 + 0.9945 B^{12} + 0.4729 B^{24})(1 - 0.8463 B)(1 - B^{12}) y_t^{(\lambda)} = (1 - 0.4170 B) \varepsilon_t$$

Where $\varepsilon_t \sim \mathcal{N}(0, 11.5793)$.

#### Residual Diagnostics:

* **Ljung-Box Test:** $Prob(Q) = 0.83 > 0.05 \rightarrow$ Residuals are independent (**White Noise**).
* **Jarque-Bera Test:** $Prob(JB) = 0.46 > 0.05 \rightarrow$ Residuals are **Normally Distributed**.
* **Parameter Significance:** All estimated coefficients have $p\text{-value} < 0.001$.

---

## 📊 Model Performance Comparison

Out-of-sample evaluation over the **12-month Test set** (June 2013 – May 2014):

| Model | MAE | RMSE | MAPE (%) |
| --- | --- | --- | --- |
| **Multiplicative Holt-Winters** 🏆 | **108.20** | **143.50** | **~23.6%** |
| **SARIMA $(1,0,1)(2,1,0)_{12}$** | **125.40** | **158.20** | **~26.1%** |

### Key Takeaways:

* **Winner:** The **Multiplicative Holt-Winters** model achieves lower overall errors ($MAE$ and $RMSE$) on the test set.
* **Behavioral Dynamics:**
* **SARIMA** tends to slightly overpredict actual sighting values, showing higher sensitivity to volatile fluctuations.
* **Holt-Winters** delivers a smoother, highly accurate trajectory, capturing the exact scale of summer peak activity.


* **Forecast Horizon:** Both models project moderate continued growth over the next 12 months with persistent summer seasonality.

---

## 🚀 Installation & Usage

### Prerequisites

Python 3.9 or higher.

### 1. Clone the repository

```bash
git clone [https://github.com/your-username/ufo-time-series-forecasting.git](https://github.com/your-username/ufo-time-series-forecasting.git)
cd ufo-time-series-forecasting

```

### 2. Create a virtual environment

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\\Scripts\\activate

```

### 3. Install dependencies

```bash
pip install -r requirements.txt

```

### 4. Run Notebooks or Scripts

```bash
# Launch Jupyter Lab / Notebook
jupyter notebook notebooks/UFO_Time_Series_Analysis.ipynb

# Or execute the pipeline script directly
python src/sarima_modeling.py

```

---

## 🛠️ Tech Stack

* **Language:** Python 3.9+
* **Data Analysis:** `pandas`, `numpy`
* **Time Series Modeling:** `statsmodels`, `scipy`
* **Visualization:** `matplotlib`, `seaborn`
* **IDE / Tools:** Jupyter Notebook, VS Code

---

## 👤 Author

**Carlos San Román Cazorla**

* **Degree:** M.Sc. in AI, Big Data & Data Science – Universidad Complutense de Madrid (UCM)
* **Date:** June 2026
* **LinkedIn:** [Carlos San Román Cazorla](https://linkedin.com)
* **GitHub:** [@caarloos12](https://github.com)

---

## 📜 License

This project is licensed under the **MIT License**. See the `LICENSE` file for full details.
