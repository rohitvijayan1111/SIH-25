# FairAgri Supply Chain – SIH 2025

## 🚜 Problem Statement

Every day, millions of farmers across India toil tirelessly in their fields. Yet, when it comes time to sell their produce, they often struggle to get a **fair price**.  

Middlemen — who control storage and transport — exploit loopholes with inflated deals and underhand payments, leaving farmers underpaid and vulnerable. Removing middlemen isn’t simple either, because logistics and warehousing are essential.  

Customers, meanwhile, lack visibility into the journey of their food. They see only a price tag — not the true value. **Trust is missing**, and the supply chain remains opaque and unfair.

---

## 💡 Solution Overview

Our solution restores **transparency, fairness, and trust** to the agricultural supply chain using **ONDC + Hyperledger Fabric**.

- **ONDC (Open Network for Digital Commerce)**  
  A government-backed network that connects farmers, middlemen, logistics providers, and customers. Ensures open competition and prevents monopolistic practices.

- **Hyperledger Fabric**  
  A permissioned blockchain where **only verified participants** can join. Every sale, bid, or purchase is recorded in a **tamper-proof ledger**, ensuring accountability and traceability. Farmers get fair prices, middlemen remain accountable, and customers can track produce from farm to plate.

---

## 🛡 Fraud Detection Logic

- **Overpriced in system but underhand deals**  
  ONDC ensures competing middlemen can bid fairly, exposing discrepancies and enforcing transparency.

- **Underpriced in system but paid more underhand**  
  Blockchain ensures ledger consistency. Any mismatch is automatically detected, preventing fraud.

---

## ✅ Key Benefits

- **Transparency:** Tamper-proof transaction records.  
- **Fair Pricing:** Competitive, honest pricing for farmers.  
- **Traceability:** Track produce from farm to fork.  
- **Open Network:** ONDC prevents monopolies, encourages fair competition.  
- **Fraud Prevention:** Ledger consistency detects discrepancies automatically.

---

## 🛠 Technologies Used

- **ONDC API** – Open network commerce integration  
- **Hyperledger Fabric** – Permissioned blockchain for trust  
- **Node.js / Express** – Backend services  
- **Flutter / React** – Frontend mobile & web apps  
- **PostgreSQL / MySQL** – Database for off-chain metadata  
- **IPFS / Cloud Storage** – Secure batch metadata storage

---

## 🚀 Getting Started

1. **Clone the repository:**  
```bash
git clone https://github.com/rohitvijayan1111/SIH-25
cd FairAgri-SIH2025
```

2. **Setup Backend (ONDC + Node.js):**  
```bash
cd backend
npm install
npm start
```
The backend server will run at `http://localhost:5000` (or your configured port). Connect it to the **Hyperledger Fabric** network for blockchain operations.

3. **Setup Flutter Frontend (Mobile & Web App):**  
```bash
cd ../frontend
flutter pub get
flutter run
```
This will launch the mobile/web app connected to the backend.

4. **Verify Integration:**  
- Ensure the backend is running before starting the Flutter app.  
- Test blockchain interactions, batch tracking, and ONDC API calls through the app.


## 🔮 Future Enhancements

- IoT-based real-time produce tracking  
- Dynamic bidding system for farmers  
- Mobile notifications for price updates and transactions  
- AI-driven demand forecasting for better pricing

---

## 👥 Contributors

- **Rohit Vijayan** – Blockchain Development   
- **Ajith Kumar S** – ONDC Backend Development  
- **Shriram** – Flutter Mobile App Development  
- **Kamali** – Flutter Mobile App Development  
- **Kaviyarasan** – Flutter Mobile App & AI Integration  
- **Boomika** – Flutter Mobile App & AI Integration


---

## 📄 License

This project is licensed under the **MIT License** – see the LICENSE file for details.
