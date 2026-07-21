import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendingAnalyticsScreen extends StatelessWidget {
  const SpendingAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          "Spending Analytics",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                Text(
                  "This Month",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  "₹24,650",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Weekly Spending",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          "Mon",
                          "Tue",
                          "Wed",
                          "Thu",
                          "Fri",
                          "Sat",
                          "Sun",
                        ];
                        return Text(days[value.toInt()]);
                      },
                    ),
                  ),
                ),
                barGroups: [
                  _bar(0, 4),
                  _bar(1, 6),
                  _bar(2, 5),
                  _bar(3, 8),
                  _bar(4, 3),
                  _bar(5, 9),
                  _bar(6, 7),
                ],
              ),
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            "Expense Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 20),

          _category(Icons.restaurant, "Food & Dining", "₹8,450", Colors.orange),
          _category(Icons.shopping_bag, "Shopping", "₹5,620", Colors.purple),
          _category(Icons.directions_car, "Transport", "₹3,850", Colors.blue),
          _category(Icons.movie, "Entertainment", "₹2,960", Colors.red),
          _category(Icons.home, "Utilities", "₹3,770", Colors.green),
        ],
      ),
    );
  }

  static BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 20,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }

  static Widget _category(
    IconData icon,
    String title,
    String amount,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
