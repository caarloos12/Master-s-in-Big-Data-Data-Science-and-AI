# PCA and Cluster Analysis on Palmer Penguins

An end-to-end data science project exploring dimensionality reduction via Principal Component Analysis (PCA) and pattern discovery using Hierarchical and Non-Hierarchical (K-Means) Clustering on the Seaborn Palmer Penguins dataset.

---

## 📌 Project Overview

This repository performs multivariate exploratory analysis and unsupervised learning on physical attributes of penguin species:

1. **Principal Component Analysis (PCA)**: Reduces dataset dimensionality from 4 continuous physical dimensions to 2 principal components while retaining 88.09% of total variance. Evaluates supplementary categorical variables (`species`, `island`, `sex`) onto the principal component plane.


2. **Cluster Analysis**: Applies Euclidean distance metrics, Ward's hierarchical agglomerative clustering, and K-Means clustering ($k=3$) to partition penguins into distinct morphological groups without prior exposure to species labels.



---

## 📊 Dataset Description

The analysis uses the `penguins` dataset from Python's `seaborn` library. After removing missing values, the final dataset contains **333 complete observations**.

### Numerical Features (Active Variables)

* `bill_length_mm`: Bill length in millimeters.


* `bill_depth_mm`: Bill depth in millimeters.


* `flipper_length_mm`: Flipper length in millimeters.


* `body_mass_g`: Body mass in grams.



### Categorical Features (Supplementary Variables)

* `species`: *Adelie*, *Chinstrap*, *Gentoo*.


* `island`: *Biscoe*, *Dream*, *Torgersen*.


* `sex`: *Male*, *Female*.



---

## ⚙️ Methodology & Pipeline

### 1. Exploratory Data Analysis & Standardization

* **Descriptive Analysis**: Calculated metrics of dispersion and central tendency (mean, standard deviation, quartiles).


* **Z-Score Normalization**: Standardized all numeric features because physical scale differences (grams vs. millimeters) would otherwise bias variance calculations.


* **Correlation Analysis**: Identified a strong positive correlation between `body_mass_g` and `flipper_length_mm` ($r = 0.87$). `bill_depth_mm` shows negative correlations with all other physical traits.



### 2. Principal Component Analysis (PCA)

* **Eigenvalue Decomposition**: Evaluated eigenvalues across 4 possible components:


* **PC1** ($\lambda_1 = 2.7536$): Explains **68.63%** of total variance. Represents an **overall body size index** (heavy positive loadings on flipper length, body mass, and bill length).


* **PC2** ($\lambda_2 = 0.7805$): Explains **19.45%** of total variance. Captures **bill shape/aspect ratio** (dominated by bill depth).


* **Cumulative Variance**: Retaining **2 components** captures **88.09%** of variance, well above the 80% selection threshold.




* **Supplementary Variables Projection**:
* *Gentoo* species clusters distinctly on the positive side of PC1 due to larger overall body size.


* *Adelie* and *Chinstrap* overlap on PC1 but separate cleanly along PC2 due to bill shape differences.


* Island distributions closely mirror species distributions (e.g., Gentoo exclusively on Biscoe Island).





### 3. Cluster Analysis

* **Distance Computation**: Constructed a Euclidean distance matrix on the standardized dataset.


* **Hierarchical Clustering**: Applied Ward’s minimum variance method and generated dendrograms and clustered heatmaps to inspect nested grouping structures.


* **Optimal Cluster Determination ($k$)**:
* **Elbow Method (WCSS)**: Identified a clear inflection point at $k = 3$.


* **Silhouette Analysis**: Peak score at $k = 2$ (0.5308), but $k = 3$ (0.4462) was chosen to preserve biological species granularity.




* **Non-Hierarchical Clustering (K-Means)**: Iteratively partitioned data into 3 clusters.



---

## 📈 Key Results & Clustering Characterization

### Cluster Morphological Profiles

| Cluster | Count | Main Species | Characteristics |
| --- | --- | --- | --- |
| **Cluster 0** | 129 | 124 Adelie, 5 Chinstrap | **Small size / Deep bills**: Short bills ($\mu = 38.28\text{ mm}$), deep bills ($\mu = 18.12\text{ mm}$), short flippers ($\mu = 188.63\text{ mm}$), lowest mass ($\mu = 3,593.80\text{ g}$). |
| **Cluster 1** | 119 | 119 Gentoo (100% Pure) | **Large size / Long flippers**: Long bills ($\mu = 47.57\text{ mm}$), shallow bills ($\mu = 15.00\text{ mm}$), long flippers ($\mu = 217.24\text{ mm}$), highest mass ($\mu = 5,092.44\text{ g}$). |
| **Cluster 2** | 85 | 63 Chinstrap, 22 Adelie | **Intermediate size / Long & deep bills**: Long bills ($\mu = 47.66\text{ mm}$), deep bills ($\mu = 18.75\text{ mm}$), intermediate flippers ($\mu = 196.92\text{ mm}$), moderate mass ($\mu = 3,898.24\text{ g}$). |

* **Classification Accuracy**: K-Means clustering correctly groups **306 of 333 penguins (~91.9% accuracy)** relative to true species labels without using species during training.


* **Silhouette Validation**: Cluster 1 (Gentoo) displays near-perfect isolation, whereas minor negative silhouette values in Cluster 2 reflect morphological overlap between Adelie and Chinstrap species.


---

## 🚀 Getting Started

### Prerequisites

Ensure Python 3.9+ is installed along with the necessary scientific libraries.

```bash
# Clone the repository
git clone https://github.com/your-username/pca-clustering-penguins.git
cd pca-clustering-penguins

# Install dependencies
pip install numpy pandas matplotlib seaborn scikit-learn

```

---

## 👤 Author & Academic Context

* **Author**: Carlos San Román Cazorla


* **Institution**: Universidad Complutense de Madrid (UCM)


* **Degree**: Master's in Artificial Intelligence, Big Data & Data Science


* **Date**: June 2026


* **Version**: 1.0.0
