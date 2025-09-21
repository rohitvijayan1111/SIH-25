# 🚜 FairAgri Supply Chain – SIH 2025

[![Made with Node.js](https://img.shields.io/badge/Backend-Node.js-blue)](https://nodejs.org/) 
[![Flutter](https://img.shields.io/badge/Frontend-Flutter-blueviolet)](https://flutter.dev/) 
[![Hyperledger Fabric](https://img.shields.io/badge/Blockchain-Hyperledger-lightgrey)](https://www.hyperledger.org/use/fabric)
[![ONDC](https://img.shields.io/badge/ONDC-Open%20Network%20Digital%20Commerce-orange)](https://ondc.org/)

---


## 📌 Table of Contents
- [Problem Statement](#-problem-statement)
- [Solution Overview](#-solution-overview)
- [Fraud Detection Logic](#-fraud-detection-logic)
- [Key Benefits](#-key-benefits)
- [Technologies Used](#-technologies-used)
- [Getting Started](#-getting-started)
- [Future Enhancements](#-future-enhancements)
- [Contributors](#-contributors)
- [License](#-license)

---

## 🚜 Problem Statement
Millions of farmers across India work tirelessly, yet struggle to get a fair price for their produce.  

Middlemen controlling storage and logistics often exploit loopholes, leaving farmers underpaid. Removing middlemen isn’t simple due to the importance of warehousing and transport.  

Customers also lack visibility into the journey of their food, creating distrust and perpetuating an opaque system.

---

## 💡 Solution Overview
**FairAgri** leverages **ONDC** and **Hyperledger Fabric** to restore transparency, fairness, and trust in the agricultural supply chain.

### ONDC (Open Network for Digital Commerce)
- Government-backed network connecting farmers, middlemen, logistics providers, and customers.  
- Promotes open competition, preventing monopolistic practices.  
- Ensures fair bidding and transparent transactions.

### Hyperledger Fabric
- **Permissioned blockchain**: only verified participants can join.  
- Records every sale, bid, and purchase on a tamper-proof ledger.  
- Guarantees accountability and traceability for farmers, middlemen, and customers.

---

## 🛡 Fraud Detection Logic
1. **Overpriced in system but underhand deals**  
   - ONDC ensures fair bidding among middlemen, exposing discrepancies.  

2. **Underpriced in system but paid more underhand**  
   - Blockchain enforces ledger consistency and automatically detects mismatches.

---

## ✅ Key Benefits
- **Transparency:** Tamper-proof transaction records.  
- **Fair Pricing:** Honest and competitive pricing for farmers.  
- **Traceability:** Full tracking of produce from farm to fork.  
- **Open Network:** ONDC prevents monopolies and encourages competition.  
- **Fraud Prevention:** Automatic detection of discrepancies via blockchain ledger.

---

## 🛠 Technologies Used
- **ONDC API:** Digital commerce network integration  
- **Hyperledger Fabric:** Permissioned blockchain for traceability  
- **Node.js / Express:** Backend services  
- **Flutter / React:** Mobile and web apps  
- **PostgreSQL / MySQL:** Off-chain metadata storage  
- **IPFS / Cloud Storage:** Secure batch data storage  

---

## 🚀 Getting Started

### Clone Repository
```bash
git clone https://github.com/rohitvijayan1111/SIH-25
cd FairAgri-SIH2025
```

### Backend Setup
```bash
cd backend
npm install
npm start
```
- Backend runs at `http://localhost:5000`  
- Connect to Hyperledger Fabric network for blockchain operations.

### Frontend Setup (Flutter)
```bash
cd ../frontend
flutter pub get
flutter run
```
- Mobile/Web app connects to backend and blockchain.

---

## 🔮 Future Enhancements
- IoT-based real-time produce tracking  
- Dynamic bidding system for farmers  
- Mobile notifications for price updates and transactions  
- AI-driven demand forecasting for better pricing  

---

## 👥 Contributors
- **Rohit Vijayan** – Blockchain Development  
- **Ajith Kumar** – ONDC Backend Development  
- **Shriram** – Flutter Mobile App Development  
- **Kamali** – Flutter Mobile App Development  
- **Kaviyarasu** – Flutter Mobile App & AI Integration  
- **Boomika** – Flutter Mobile App & AI Integration  

---

## 📄 License
This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.
