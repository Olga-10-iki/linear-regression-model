from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import joblib
import os

app = FastAPI(
    title="Receiver Balance Prediction API",
    description="API that predicts receiver balance after a transaction",
    version="1.0"
)

# Load model and scaler
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

MODEL_PATH = os.path.join(BASE_DIR, "best_model.pkl")
SCALER_PATH = os.path.join(BASE_DIR, "scaler.pkl")

model = joblib.load(MODEL_PATH)
scaler = joblib.load(SCALER_PATH)

print("Model and scaler loaded successfully")


# Input structure
class Transaction(BaseModel):

    amount: float

    sender_balance_before: float

    sender_balance_after: float

    receiver_balance_before: float

    transaction_type: int

    hour: int

    month_2026: int

    day_of_week: int

    device_type: int

    region: int

    is_fraud: int = 0



@app.get("/")
def home():

    return {
        "message": "Receiver Balance Prediction API is running"
    }




@app.post("/predict")
def predict(transaction: Transaction):


    # Convert request into dataframe

    data = pd.DataFrame(
        [transaction.dict()]
    )


    # Keep same training order

    data = data[
        [
            "amount",
            "sender_balance_before",
            "sender_balance_after",
            "receiver_balance_before",
            "transaction_type",
            "hour",
            "month_2026",
            "day_of_week",
            "device_type",
            "region",
            "is_fraud"
        ]
    ]



    # Scale data

    scaled_data = scaler.transform(data)



    # Prediction

    prediction = model.predict(
        scaled_data
    )


    predicted_balance = round(
        float(prediction[0]),
        2
    )


    # Fraud result

    if transaction.is_fraud == 0:

        fraud_status = "Safe"

        risk_level = "Low Risk"

    else:

        fraud_status = "Fraud Detected"

        risk_level = "High Risk"



    return {

        "predicted_receiver_balance_after": predicted_balance,

        "fraud_status": fraud_status,

        "risk_level": risk_level

    }