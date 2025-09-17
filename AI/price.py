from flask import Flask, request, jsonify, render_template
import requests
import pandas as pd
import time
<<<<<<< HEAD
from datetime import datetime
=======
from datetime import datetime, timedelta
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4

app = Flask(__name__)

# ----------------------------
# Configuration
# ----------------------------
API_URL = "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070"
API_KEY = "579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b"

# Seasonal multipliers
season_factors = {
<<<<<<< HEAD
    "winter": 0.05,   # 5% increase
    "summer": 0.10,   # 10% increase
    "rainy": 0.15,    # 15% increase
    "autumn": 0.03,   # 3% increase
=======
    "winter": 0.05,
    "summer": 0.10,
    "rainy": 0.15,
    "autumn": 0.03,
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
}

# ----------------------------
# Helpers
# ----------------------------
def get_current_season() -> str:
<<<<<<< HEAD
    """Return current Indian season based on calendar month."""
=======
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
    month = datetime.now().month
    if month in [12, 1, 2]:
        return "winter"
    elif month in [3, 4, 5]:
        return "summer"
    elif month in [6, 7, 8, 9]:
        return "rainy"
    return "autumn"

<<<<<<< HEAD

def fetch_price(commodity: str, state: str = None):
    """Fetch modal prices from API and filter by state locally."""
=======
def fetch_price(commodity: str, state: str = None):
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
    all_records = []
    offset, limit = 0, 100

    while True:
        params = {
            "api-key": API_KEY,
            "format": "json",
            "filters[commodity]": commodity,
            "limit": limit,
            "offset": offset,
        }
<<<<<<< HEAD

        # Filter by state in API if supported
=======
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
        if state:
            params["filters[state.keyword]"] = state

        try:
            response = requests.get(API_URL, params=params, timeout=10)
            response.raise_for_status()
<<<<<<< HEAD
        except requests.RequestException as e:
=======
        except requests.RequestException:
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
            return None

        data = response.json()
        records = data.get("records", [])
        if not records:
            break

        all_records.extend(records)
        offset += limit
        time.sleep(0.1)

<<<<<<< HEAD
        if offset > 500:  # safety limit
=======
        if offset > 500:
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
            break

    if not all_records:
        return None

    df = pd.DataFrame(all_records)
    if "modal_price" not in df.columns:
        return None

    df["modal_price"] = pd.to_numeric(df["modal_price"], errors="coerce")
    df["arrival_date"] = pd.to_datetime(df.get("arrival_date"), errors="coerce", dayfirst=True)
    df = df.dropna(subset=["modal_price", "arrival_date"])

<<<<<<< HEAD
    # Filter by state locally (case-insensitive)
=======
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
    if state:
        df = df[df["state"].str.strip().str.lower() == state.strip().lower()]

    if df.empty:
        return None

<<<<<<< HEAD
    # Average of latest 10 days
    latest_dates = sorted(df["arrival_date"].unique())[-10:]
    df = df[df["arrival_date"].isin(latest_dates)]

    return df["modal_price"].mean() if not df.empty else None

=======
    prices = []
    for i in range(3):
        date_i = datetime.now().date() - timedelta(days=i)
        day_df = df[df["arrival_date"].dt.date == date_i]
        if not day_df.empty:
            prices.append(day_df["modal_price"].mean())

    if not prices:
        return None

    return sum(prices) / len(prices)
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4

# ----------------------------
# Routes
# ----------------------------
@app.route("/")
def home():
<<<<<<< HEAD
    return render_template("index.html")

=======
    return render_template("price.html")
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4

@app.route("/get_price", methods=["GET"])
def get_price():
    commodity = request.args.get("commodity")
    state = request.args.get("state")
    season = request.args.get("season")

    if not commodity:
        return jsonify({"error": "Commodity is required"}), 400

<<<<<<< HEAD
    
=======
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
    if not season or season.lower() not in season_factors:
        season = get_current_season()
    else:
        season = season.lower()

    base_price = fetch_price(commodity, state)
<<<<<<< HEAD
    if base_price is None:
        return jsonify({
            "commodity": commodity.title(),
            "state": state or "India",
            "error": "No price data found for this commodity in the selected state."
        }), 404

    factor = season_factors[season]
    final_price = base_price * (1 + factor)
    price_per_kg = round(final_price / 100, 2)  # 1 quintal = 100 kg

    return jsonify({
    "commodity": commodity.title(),
    "state": state or "India",
    "season": season,
    "season_factor_applied": f"{int(factor*100)}%",
    "base_price_per_quintal": int(round(base_price)),
    "suggested_price_per_kg": int(price_per_kg),
    "message": f"Suggested Price in {state or 'India'} for {season}: ₹{int(price_per_kg)}/kg"
})



if __name__ == "__main__":
    app.run(debug=True)
=======
    factor = season_factors[season]

    if base_price is None:
        # Indicate to frontend that user input is needed
        return jsonify({
            "commodity": commodity.title(),
            "state": state or "India",
            "season": season,
            "require_user_input": True,
            "message": "No API data found. Please provide your recent price per kg."
        })

    final_price = base_price * (1 + factor)
    price_per_kg = round(final_price / 100, 2)

    return jsonify({
        "commodity": commodity.title(),
        "state": state or "India",
        "season": season,
        "season_factor_applied": f"{int(factor*100)}%",
        "base_price_per_quintal": int(round(base_price)),
        "suggested_price_per_kg": int(price_per_kg),
        "message": f"Suggested Price in {state or 'India'} for {season}: ₹{int(price_per_kg)}/kg"
    })

@app.route("/calculate_custom_price", methods=["POST"])
def calculate_custom_price():
    data = request.get_json()
    user_price = float(data.get("user_price"))  # price per kg provided by user
    season = data.get("season")
    factor = season_factors.get(season, 0)

    final_price = user_price * (1 + factor)
    return jsonify({
        "suggested_price_per_kg": round(final_price, 2),
        "message": f"Suggested Price based on your input for {season}: ₹{round(final_price, 2)}/kg"
    })

if __name__ == "__main__":
    app.run(debug=True)
>>>>>>> be56940ccc9ddef264120439cf640a09ac3350b4
