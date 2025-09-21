import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const Expanded(
                      child: Text(
                        "Earnings",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                    ),
                  ],
                ),
              ),

/// Green Top Card
Container(
  width: double.infinity, // make it stretch full width
  margin: const EdgeInsets.symmetric(horizontal: 16),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        "Monthly Earnings",
        style: TextStyle(color: Colors.white70, fontSize: 14),
      ),
      const SizedBox(height: 8),
      const Text(
        "₹15,670",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 16),
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all( // 👈 instead of color fill, use border
            color: Colors.white,
            width: 4,
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Your Share\n12.5%",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, // 👈 keep text white
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
),

const SizedBox(height:16),

              /// Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Expanded(
                      child: _StatCard(
                        title: "This Month",
                        value: "₹15,670",
                        change: "+12.5%",
                        changeColor: Colors.green,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: "Last Month",
                        value: "₹14,490",
                        change: "-8.2%",
                        changeColor: Colors.red,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: "Total Earned",
                        value: "₹1,85,240",
                        change: "+5.6%",
                        changeColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Balance + Payout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Available Balance",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "₹8,450",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.account_balance_wallet,
                              color: Colors.green.shade700),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: () {},
                        child: const Text("Request Payout"),
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      const Text("Bank Account",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 6),
                      const Text(
                        "HDFC Bank *****1234",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // TODO: Replace with asset icons for VISA/Bank
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue.shade100,
                            ),
                            child: const Icon(Icons.credit_card, color: Colors.blue),
                          ),
                          const SizedBox(width: 8),
                          const Text("Only"),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Recent Transactions
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Recent Transactions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              const _TransactionTile(
                batchId: "Batch #2024-001",
                date: "15 Jan 2024",
                amount: "₹2,340",
                status: "Paid",
                statusColor: Colors.green,
              ),
              const _TransactionTile(
                batchId: "Batch #2024-002",
                date: "12 Jan 2024",
                amount: "₹1,890",
                status: "Pending",
                statusColor: Colors.orange,
              ),
              const _TransactionTile(
                batchId: "Batch #2024-003",
                date: "10 Jan 2024",
                amount: "₹3,120",
                status: "Failed",
                statusColor: Colors.red,
              ),

              const SizedBox(height: 20),

              /// Earnings Trend
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Earnings Trend",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              spreadRadius: 2)
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("6 Months")),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("1 Year")),
                              const SizedBox(width: 8),
                            ],
                          ),
                          Expanded(
                            child: Center(
                              // ✅ Replace with your bar chart image asset
                              child: Image.asset(
                                'assets/CustomerUIAssets/images/bar_chart.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Actions
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 2),
                  ],
                ),
                child: Column(
                  children: const [
                    _ActionTile(title: "View Payout History"),
                    Divider(height: 0),
                    _ActionTile(title: "Update Bank Details"),
                    Divider(height: 0),
                    _ActionTile(title: "Download Statement"),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---- Widgets ----

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final Color changeColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 6),
          Text(change, style: TextStyle(color: changeColor, fontSize: 12)),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String batchId;
  final String date;
  final String amount;
  final String status;
  final Color statusColor;

  const _TransactionTile({
    required this.batchId,
    required this.date,
    required this.amount,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(batchId, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(date),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 10, color: statusColor),
              const SizedBox(width: 4),
              Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String title;
  const _ActionTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
