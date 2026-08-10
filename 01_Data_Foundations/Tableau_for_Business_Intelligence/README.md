# Easy Loans 2023 — Business Intelligence & Dashboard Analysis (Tableau)

This repository contains the final practical assignment for the **Business Intelligence con Tableau** module, part of the **Master's Degree in Big Data, Data Science, and AI** (Universidad Complutense de Madrid / NTIC Master) taught by Prof. Juan Fernando Sánchez Martínez.

---

## 📌 Project Overview

**Easy Loans** is a financial services company that provides loans for purchasing products across various commercial establishments. The primary objective of this project is to analyze operational data from the **2023 fiscal year** using **Tableau Desktop**, extracting actionable business insights regarding loan quality, customer behavior, and merchant performance to support strategic decision-making.

---

## 📊 Dataset & Data Modeling

The analysis is based on the dataset provided in `Easy Loans Operaciones 2023.xlsx`.

### Source Tables

1. **`Orders`**: Contains core loan transaction data (`order_id`, `created_at`, `status`, `amount`, `merchant_id`, `country`).
2. **`Merchant`**: Contains merchant details (`merchant_id`, `name`).
3. **`Refunds`**: Contains refund details (`order_id`, `refunded_at`, `amount`).

### Data Pipeline & Modeling Setup

* **Relational Schema**: Established logical relationships between `Orders`, `Merchant` (via `merchant_id`), and `Refunds` (via `order_id`) within Tableau's Data Source layer.
* **Geographic Scope**: Filtered at the Data Source level to include **European operations only**, strictly excluding records from Morocco.
* **File Format**: Packaged as a Tableau Packaged Workbook (`.twbx`) to preserve data extracts, connections, and custom branding assets.

---

## 🧮 Calculated Fields & Business Metrics

The analysis utilizes custom calculated fields to evaluate overall performance and deviation against baseline metrics:

| Calculated Field | Calculation Logic / Tableau Expression | Business Purpose |
| --- | --- | --- |
| **Promedio Préstamos** | `AVG([amount])` | Measures average loan amount for filtered selections. |
| **Sumatorio Préstamos** | `SUM([amount])` | Total aggregated loan volume. |
| **Máximo** | `MAX([amount])` | Maximum individual loan issued. |
| **Mínimo** | `MIN([amount])` | Minimum individual loan issued. |
| **Total Comercios** | `COUNTD([merchant_id])` | Count of unique participating merchants. |
| **Total Operaciones** | `COUNT([order_id])` | Total transaction count. |
| **Total Reembolsos** | `COUNT([Refunds].[order_id])` | Total count of refund operations. |
| **Valor Acumulado** | `RUNNING_SUM(SUM([amount]))` | Daily cumulative sales volume. |
| **Promedio Total** | `{FIXED : AVG([amount])}` | Benchmark overall average loan amount (ignores view filtering). |
| **Desviación Promedio** | `(AVG([amount]) - [Promedio Total]) / [Promedio Total]` | Percentage deviation of active selection vs global baseline. |
| **Leyenda Promedio** | Custom dynamic string for deviation color coding | Used for dynamic color legends on KPI cards. |

---

## 📉 Visualizations & Interactive Components

1. **Main KPI Card**: Displays selected average loan amount alongside its percentage deviation against global benchmark (`Promedio Total`).
2. **Secondary KPI Panel**: Highlights core operational KPIs — *Total Operations*, *Total Merchants*, *Max Loan Amount*, *Min Loan Amount*, and *Total Refunds*.
3. **Country Heatmap**: Geographic map colored by average loan amount using a gradient palette to spot regional spend variations.
4. **Cumulative Sales Line**: Line chart plotting daily cumulative revenue (`Valor Acumulado`), colored by cumulative total.
5. **Dynamic Top N Merchant Treemap**:
* **Parameter `Top N**`: Integer control (Range: 1–37, Default: 10, Step: 1) allowing users to dynamically adjust merchant view limits.
* **Set `Top Comercios**`: Dynamic set on `Merchant (Name)` conditioned by the `Top N` parameter based on total loan amount.


6. **Status Breakdown Chart**: Donut chart displaying transaction distribution across loan statuses (`CLOSED`, `ACTIVE`, `DELINQUENT`, `CANCELLED`).

---

## 🎛️ Global Filters & Navigation Actions

* **Global Context Filters**: Applied across **all worksheets**:
* `Country` (Single Select)
* `Status` (Single Select)
* `Created At` (Date Range Slider)


* **Map Filter Action**: Clicking any country on the European heatmap dynamically filters all adjacent visualizations in the dashboard.

---

## 🎨 User Experience (UX) & Advanced Features

To exceed standard requirements and deliver executive-grade usability:

* **Custom Layout**: Formatted following UCM visual layout standards with branded corporate headers, rounded containers, and consistent typography.
* **Collapsible Filter Drawers**: Integrated hidden filter menus to keep the main view clean while maintaining drill-down capabilities.
* **Dynamic Metric Switching**: Parameter controls enabling seamless toggling between total loan volume and transaction counts.

---

## ☁️ Deployment & Bonus Submissions

* **Tableau Cloud / Public**: Published workbook accessible with appropriate permissions for academic evaluation.
* **TableSAW Challenge**: Completed the 4-level BI escape room challenge.

---

## 👨‍💻 Author & Institutional Context

* **Program**: Master's in Big Data, Data Science, and AI


* **Institution**: Universidad Complutense de Madrid (UCM) / NTIC Master


* **Module**: Business Intelligence con Tableau


* **Professor**: Juan Fernando Sánchez Martínez



---

*For any questions regarding calculated field logic or workbook replication, please refer to the comments embedded inside the Tableau `.twbx` workbook.*
