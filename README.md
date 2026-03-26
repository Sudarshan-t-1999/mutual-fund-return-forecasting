# Mutual Fund Performance Prediction System

## Overview

This project builds a machine learning system to predict long-term returns of mutual funds and compare them against a benchmark index.

The system focuses on two funds:

- Motilal Oswal Midcap Fund
- Edelweiss Midcap Fund

and compares them with:

- Nifty Midcap 150 Index

The goal is to help an investor decide:

> Which fund is a better investment option based on predicted future returns?

---

## Problem Statement

Most investment comparisons rely on:

- past returns
- static metrics

These approaches ignore **future expectations** and **market conditions**.

This project reframes the problem as:

> Given historical NAV data, can we predict future returns and use them to guide investment decisions?

---

## User & Decision

**Target user:**
- Individual investor comparing mutual funds

**Decision supported:**
- Which fund to invest in (Motilal Oswal Midcap Fund vs Edelweiss Midcap Fund)

---

## Dataset

- Source:
  - Mutual fund NAV values from fund websites
  - Nifty Midcap 150 index values from NSE

- Duration:
  - ~1230 trading days

- Assets:
  - Fund A: Motilal Oswal Midcap Fund
  - Fund B: Edelweiss Midcap Fund
  - Benchmark: Nifty Midcap 150

---

## Feature Engineering

Current features include:

- Moving averages:
  - 7-day
  - 30-day
  - 60-day
  - 90-day

Planned features:

- Date-based features:
  - day / month / year
  - quarter

Future improvements:

- rolling volatility
- drawdown
- relative performance vs index

---

## Target Variable

The model predicts:

**Forward Rolling Return (1-year horizon)**

Definition:

Return from time *t* to *t + 1 year*

Motivation:

- Total return only considers start and end
- Annual return is not available per row
- Forward return allows **supervised learning on each time step**

---

## Modeling Approach

Planned models:

- Linear Regression
- Random Forest
- XGBoost

Approach:

- Compare multiple algorithms
- Understand their behavior and trade-offs
- Select the best-performing model

---

## System Architecture

Data → EDA → Feature Engineering → Model Training → Docker → API → Dashboard → Monitoring → Retraining


### Inference Flow (Per Prediction Request)

When a user provides a date, the system performs the following steps:

date  
↓  
filter historical data ≤ date  
↓  
feature generation  
↓  
model prediction (per fund)  
↓  
comparison logic  
↓  
final output (recommended fund)

---

## API Design (Planned)

Endpoint:
POST /predict


Input:

{
  "date": "2023-01-01"
}

Output:

{
  "fund_A": {
    "name": "Motilal Oswal Midcap Fund",
    "predicted_return": 0.12
  },
  "fund_B": {
    "name": "Edelweiss Midcap Fund",
    "predicted_return": 0.08
  },
  "benchmark": {
    "name": "Nifty Midcap 150",
    "predicted_return": 0.06
  },
  "comparison": {
    "best_fund": "Motilal Oswal Midcap Fund",
    "excess_return_vs_benchmark": 0.06
  }
}

---

## Dashboard (Planned)

The dashboard will display:

- NAV trends for both funds and benchmark
- model predictions
- comparison between funds
- recommendation based on predictions

---

## Tech Stack

- Python
- Pandas / NumPy
- scikit-learn
- FastAPI (planned)
- Docker (planned)
- Azure (planned deployment)
- CI/CD tool (planned)

---

## MLOps (Planned)

- Model versioning
- Model monitoring
- Retraining pipeline

Future additions:

- data drift detection
- experiment tracking (MLflow)

---

## Challenges Faced

- Defining the correct target variable
- Deciding which EDA metrics are meaningful
- Translating financial intuition into ML features

---

## Future Improvements

- Add risk prediction (drawdown probability)
- Incorporate live data (if cost-effective)
- Improve feature engineering
- Expand to more funds

---

## Dataset Summary

- ~1230 rows
- Columns:
  - Date
  - NAV / Index values

---

## Key Differentiation

This project is built **end-to-end independently**, covering:

- data collection
- analysis
- feature engineering
- model design
- deployment planning
- MLOps considerations

Unlike tutorial-based projects, this focuses on:

> building a real-world ML system for financial decision-making

---

## Next Steps

- Complete feature engineering
- Train baseline models
- evaluate performance
- build API
- deploy system
