# 📱 M-Pesa Receiver Balance Prediction System

## Author

**IKIREZI Olga**  
Bachelor of Software Engineering  
African Leadership University (ALU)

---

# Mission

To support the monitoring and analysis of M-Pesa transactions by helping identify unusual transaction patterns and improving financial oversight.

---

# Project Overview

This project predicts the expected receiver account balance after an M-Pesa transaction using historical transaction data. The solution includes a trained prediction model a REST API built with FastAPI and a Flutter application that allows users to enter transaction details and receive predictions in real time.

---

# Target Users

This solution is designed for organizations that monitor and analyse M-Pesa transaction data, including:

- Financial Institutions
- Fraud Detection Teams
- Transaction Monitoring Teams
- Auditors
- Financial Analysts

---

# Dataset

## Dataset Description

The project uses a synthetic M-Pesa transaction dataset containing transaction records with financial and transaction-related information.

### Features

- Amount
- Sender Balance Before
- Sender Balance After
- Receiver Balance Before
- Transaction Type
- Hour
- Month
- Day of Week
- Device Type
- Region
- Fraud Indicator

### Target Variable

- Receiver Balance After Transaction

**Dataset Location**

```
linear_regression/data/mpesa_synthetic.csv
```

---

# Exploratory Data Analysis

The dataset was explored before training the models to better understand the relationships between variables.

Visualizations included:

- Correlation Heatmap
- Feature Distribution Histogram

---

# Data Preprocessing

The following preprocessing techniques were applied:

- Data inspection
- Missing value checking
- Duplicate value checking
- Label Encoding
- Feature Scaling using StandardScaler
- Train-Test Split

---

# Machine Learning Models

Three regression algorithms were trained and compared.

### Linear Regression

Used as the baseline prediction model.

### Decision Tree Regressor

Used to capture non-linear relationships within the dataset.

### Random Forest Regressor

Used as an ensemble model to improve prediction accuracy.

The best-performing model was selected and saved for deployment.

Saved files:

```
API/best_model.pkl
API/scaler.pkl
```

---

# Model Evaluation

Models were evaluated using:

- Mean Absolute Error (MAE)
- Mean Squared Error (MSE)
- Root Mean Squared Error (RMSE)
- R² Score

The model with the best evaluation metrics was selected for deployment.

---

# REST API

The trained model is deployed using FastAPI.

### Base URL

https://receiver-balance-api.onrender.com/

### Swagger Documentation

https://receiver-balance-api.onrender.com/docs

---

# Prediction Endpoint

### POST

```
/predict
```

Example Request

```json
{
  "amount": 2000,
  "sender_balance_before": 10000,
  "sender_balance_after": 8000,
  "receiver_balance_before": 4000,
  "transaction_type": 1,
  "hour": 14,
  "month_2026": 7,
  "day_of_week": 3,
  "device_type": 1,
  "region": 1,
  "is_fraud": 0
}
```

Example Response

```json
{
  "predicted_receiver_balance_after": 6000,
  "fraud_status": "Safe",
  "risk_level": "Low Risk"
}
```

---

# CORS Configuration

The API implements FastAPI CORS Middleware with specific allowed origins.

Allowed Origins:

- http://localhost:8080
- http://127.0.0.1:8080
- https://receiver-balance-api.onrender.com

This allows secure communication between the Flutter web application and the deployed API.

---

# Flutter Mobile Application

The Flutter application enables users to:

- Enter transaction details
- Select transaction type
- Select device type
- Select region
- Predict receiver balance
- View fraud status
- View risk level

Supported platforms:

- Android
- Flutter Web

---

# Demo Video

**Project Demonstration**

```
https://youtu.be/your-video-link
```

---

# Project Structure

```
SUMMATIVE/
│
├── README.md
│
├── API/
│   ├── prediction.py
│   ├── best_model.pkl
│   ├── scaler.pkl
│   ├── requirements.txt
│   └── test_api.py
│
├── flutter_app/
│   ├── android/
│   ├── lib/
│   ├── test/
│   ├── pubspec.yaml
│   └── README.md
│
└── linear_regression/
    ├── data/
    │   └── mpesa_synthetic.csv
    │
    └── mpesa_regression.ipynb
```

---

# Technologies Used

### Programming Languages

- Python
- Dart

### Machine Learning

- Pandas
- NumPy
- Scikit-learn
- Matplotlib

### API Development

- FastAPI
- Pydantic
- Uvicorn

### Mobile Development

- Flutter

### Deployment

- Render

---

# Future Improvements

Future versions of this project could include:

- Automatic model retraining when new transaction data is available.
- More advanced fraud detection.
- Additional transaction categories.
- Transaction analytics dashboard.
- User authentication and access management.

---


This project was developed for academic purposes as part of the Machine Learning course at the African Leadership University.
