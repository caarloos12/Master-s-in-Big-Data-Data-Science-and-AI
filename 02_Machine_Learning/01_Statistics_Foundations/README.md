# 💀 Egyptian Skull Width Analysis: Inferential & Descriptive Statistics

An econometric and statistical investigation into the morphological evolution of ancient Egyptian skulls. Using skull width measurements (mm) across two distinct historical eras (Early Predynastic vs. Late Predynastic), this repository performs descriptive analysis, normality testing, variance homogeneity testing, confidence interval estimations, and Student's t-tests to evaluate head shape roundness over time.

---

## 📌 Table of Contents

* [Overview](https://www.google.com/search?q=%23-overview)
* [Repository Structure](https://www.google.com/search?q=%23-repository-structure)
* [Descriptive Analysis](https://www.google.com/search?q=%23-descriptive-analysis)
* [Hypothesis Testing & Statistical Inference](https://www.google.com/search?q=%23-hypothesis-testing--statistical-inference)
* [1. Normality Testing (Kolmogorov-Smirnov)](https://www.google.com/search?q=%231-normality-testing-kolmogorov-smirnov)
* [2. Equality of Variances (F-Test)](https://www.google.com/search?q=%232-equality-of-variances-f-test)
* [3. Confidence Intervals for Mean Difference](https://www.google.com/search?q=%233-confidence-intervals-for-mean-difference)
* [4. Two-Sample Student's t-Test](https://www.google.com/search?q=%234-two-sample-students-t-test)


* [Key Anthropological Conclusions](https://www.google.com/search?q=%23-key-anthropological-conclusions)
* [Tech Stack & Quickstart](https://www.google.com/search?q=%23-tech-stack--quickstart)
* [Author & Academic Context](https://www.google.com/search?q=%23-author--academic-context)

---

## 📖 Overview

This study addresses an anthropological question: **Did ancient Egyptian skull widths increase over time toward a rounder cranial structure?**

Using a dataset of 60 archaeological skull measurements divided equally between the Early Predynastic (Period 1) and Late Predynastic (Period 2) eras, we execute a rigorous hypothesis testing workflow to determine whether the observed statistical differences in cranial breadth are statistically significant.

---

## 📁 Repository Structure

```text
.
├── datosejercicioevaluacionanchuras.xlsx  # Dataset (60 observations: 30 Early, 30 Late)
├── CarlosSanRomanCazorla_Estadística.pdf   # Complete academic report and analysis
└── README.md                               # Project documentation

```

* **`datosejercicioevaluacionanchuras.xlsx`**: Excel dataset containing historical period codes (`1` = Early Predynastic, `2` = Late Predynastic) and skull width measurements in millimeters.


* **`CarlosSanRomanCazorla_Estadística.pdf`**: Methodological report detailing mathematical proofs, distribution charts, statistical outputs, and analytical commentary.



---

## 📈 Descriptive Analysis

Summary statistics calculated for both historical subsamples ($n_1 = 30$, $n_2 = 30$):

| Metric | Early Predynastic (Period 1) | Late Predynastic (Period 2) |
| --- | --- | --- |
| **Sample Size ($n$)** | 30 | 30 |
| **Mean ($\mu$)** | 131.5333 mm | 132.4667 mm|
| **Median** | 131.5000 mm| 133.0000 mm |
| **Mode** | 131.0000 mm | 133.0000 mm |
| **Std. Deviation ($s$)** | 0.8193 mm | 1.0080 mm |
| **Variance ($s^2$)** | 0.6713 | 1.0161 |
| **Min / Max** | 130.0 / 134.0 mm | 131.0 / 135.0 mm |
| **Pearson Coeff. of Variation** | 0.0062 | 0.0076 |
| **Fisher Skewness** | 0.6570 (Right-skewed) | 0.1951 (Slight right-skew) |
| **Kurtosis** | 1.3044 (Leptokurtic) | -0.1862 (Platykurtic) |
---

## 🧪 Hypothesis Testing & Statistical Inference

### 1. Normality Testing (Kolmogorov-Smirnov)

* **Hypotheses**:
* $H_0$: The subsample follows a normal distribution.


* $H_1$: The subsample does not follow a normal distribution.




* **Results ($\alpha = 0.05$, Critical $D_{0.05, 30} = 0.2470$)**:


* **Early Predynastic**: Observed $D = 0.2425$, $p\text{-value} = 0.0489 < 0.05 \implies$ **Reject $H_0$** (Sample does not conform strictly to normality).


* **Late Predynastic**: Observed $D = 0.2350$, $p\text{-value} = 0.0611 > 0.05 \implies$ **Accept $H_0$** (No statistical evidence to reject normality).





---

### 2. Equality of Variances (F-Test)

Before applying two-sample mean comparison procedures, population variances were tested for homoscedasticity:

* **Hypotheses**: $H_0: \sigma_1^2 = \sigma_2^2$ vs. $H_1: \sigma_1^2 \neq \sigma_2^2$.


* **Observed Statistic**: $F_{obs} = \frac{S_1^2}{S_2^2} = \frac{0.6713}{1.0161} = 0.6606$.


* **Acceptance Region ($90\%$ CI)**: $[0.5374, 1.8608]$.


* **Decision**: $F_{obs}$ falls inside the acceptance zone $\implies$ **Accept $H_0$** (Population variances are statistically equal).



---

### 3. Confidence Intervals for Mean Difference ($\overline{X}_1 - \overline{X}_2$)

Pooled standard deviation $S_p = 0.9185$, Standard Error $SE = 0.2372$, Degrees of Freedom $df = 58$:

| Confidence Level | Critical $t$-value | Confidence Interval (mm) |
| --- | --- | --- |
| **90% CI** | $\pm 1.6716$<br> | $(-1.3298, -0.5369)$<br> |
| **95% CI** | $\pm 2.0017$<br> | $(-1.4081, -0.4586)$<br> |
| **99% CI** | $\pm 2.6633$<br> | $(-1.5650, -0.3017)$<br> |

> **Key Takeaway**: At all confidence levels, the interval strictly contains negative values and excludes zero. This establishes that $\mu_1 < \mu_2$ with up to 99% statistical confidence.
> 
> 

---

### 4. Two-Sample Student's t-Test

* **Hypotheses**: $H_0: \mu_1 = \mu_2$ vs. $H_1: \mu_1 \neq \mu_2$.


* **Test Parameters**:
* Mean Difference ($\overline{X}_1 - \overline{X}_2$): $-0.9333$ mm


* Standard Error: $0.2372$

* $t$-statistic Observed: $-3.9354$

* Critical $t$ Bounds ($\alpha = 0.05$, two-tailed): $[-2.0017, +2.0017]$

* **$p$-value**: $0.000225$ ($p < 0.05$)




* **Decision**: **Reject $H_0$** ($T_{obs} = -3.9354$ lies far into the rejection region).



---

## 🦴 Key Anthropological Conclusions

1. **Evolutionary Morphology**: The mean skull width increased significantly from $131.53$ mm in the Early Predynastic period to $132.47$ mm in the Late Predynastic period ($p = 0.000225$).


2. **Storytelling & Interpretation**: The statistical evidence strongly aligns with the archaeological hypothesis that ancient Egyptian cranial morphology transitioned over time from an elongated structure toward a rounder (broader) head shape.


3. **Methodological Validity**: Although the early period sample slightly violated strict normality in the K-S test ($p = 0.0489$), the robustness of the Student's t-test and the extremely small $p$-value ($0.000225$) reinforce the conclusion.



---

## 🛠️ Tech Stack & Quickstart

```python
import pandas as pd
import numpy as np
from scipy import stats

# Load dataset
df = pd.read_excel('datosejercicioevaluacionanchuras.xlsx')

# Filter subsamples
early = df[df['Época histórica'] == 1]['Anchura del cráneo']
late = df[df['Época histórica'] == 2]['Anchura del cráneo']

# Perform Two-Sample t-Test
t_stat, p_val = stats.ttest_ind(early, late, equal_var=True)
print(f"t-statistic: {t_stat:.4f}, p-value: {p_val:.6f}")

```

---

## 👤 Author & Academic Context

* **Author:** Carlos San Román Cazorla


* **Institution:** Universidad Complutense de Madrid (UCM)


* **Program:** Master's in Artificial Intelligence, Big Data, and Data Science


* **Course:** Statistics


* **Date:** April 2026
