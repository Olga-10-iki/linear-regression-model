import requests


url = "http://127.0.0.1:8000/predict"


data = {
    "amount": 8000,
    "sender_balance_before": 60000,
    "sender_balance_after": 52000,
    "receiver_balance_before": 15000,
    "transaction_type": 1,
    "hour": 14,
    "month_2026": 7,
    "day_of_week": 3,
    "device_type": 1,
    "region": 2
}


response = requests.post(url, json=data)

print("Status Code:", response.status_code)
print("Response:")
print(response.text)
