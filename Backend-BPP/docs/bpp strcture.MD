Beckn-Protocol-BPP/
│
├── 📁 config/                # Configuration (DB, env, etc.)
│   └── db.js                # DB connection (PostgreSQL)
│
├── 📁 controllers/          # Handles logic for each Beckn callback
│   ├── onSearchController.js
│   ├── onSelectController.js
│   ├── onConfirmController.js
│   ├── onStatusController.js
│   ├── onCancelController.js
│   ├── onBillController.js
│   └── onRatingController.js
│
├── 📁 models/               # Sequelize/Knex/Raw SQL Models
│   ├── productModel.js
│   ├── priceListModel.js
│   ├── fulfillmentModel.js
│   ├── inventoryLogModel.js
│   ├── logisticsProviderModel.js
│   └── ratingModel.js
│
├── 📁 routes/               # API route definitions
│   ├── becknRoutes.js       # All /on_* routes
│   └── index.js             # Aggregates all route files
│
├── 📁 services/             # Business logic layer (validation, stock checks, etc.)
│   ├── inventoryService.js
│   ├── logisticsService.js
│   └── pricingService.js
│
├── 📁 utils/                # Utility functions (logging, formatting, etc.)
│   └── responseBuilder.js   # Create Beckn-compliant responses
│
├── 📁 middlewares/         # Middlewares (auth, error handling, logging)
│   └── errorHandler.js
│
├── 📁 sql/                  # Raw SQL Scripts or mock data (PostgreSQL)
│   └── insert_mock_data.sql
│
├── 📄 app.js                # Main app entry point
├── 📄 package.json
├── 📄 .env                  # Environment variables
└── 📄 README.md
