import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_model.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  final String backendUrl =
      'https://ai-expense-tracker-backend-xms7.onrender.com';
  String? summaryText;
  Map<String, double>? percentages;
  List<Map<String, dynamic>>? anomalies;
  double? forecast;

  Future<void> _summarize() async {
    var box = Hive.box<Expense>('expenses'); // Access local expenses
    List<Map<String, dynamic>> expenses = [];

    for (var e in box.values) {
      expenses.add({"category": e.category, "amount": e.amount});
    }

    final url = Uri.parse('$backendUrl/summarize');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"expenses": expenses}),
    );

    final data = jsonDecode(response.body);
    setState(() {
      summaryText = data['summary'];
      percentages = Map<String, double>.from(data['percentages']);
    });
  }

  Future<void> _detectAnomalies() async {
    var box = Hive.box<Expense>('expenses'); // Access local expenses
    List<Map<String, dynamic>> expenses = [];

    for (var e in box.values) {
      expenses.add({"amount": e.amount, "category": e.category});
    }

    final url = Uri.parse('$backendUrl/detect_anomalies');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"expenses": expenses}),
    );

    final data = jsonDecode(response.body);
    setState(() {
      anomalies = List<Map<String, dynamic>>.from(data['anomalies']);
    });
  }

  Future<void> _forecast() async {
    var box = Hive.box<Expense>('expenses'); // Access local expenses
    List<Map<String, dynamic>> expenses = [];

    for (var e in box.values) {
      expenses.add({"amount": e.amount, "category": e.category});
    }

    final url = Uri.parse('$backendUrl/forecast');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"expenses": expenses}),
    );

    final data = jsonDecode(response.body);
    setState(() {
      forecast = data['forecast'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Insights"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF654ea3), Color(0xFFeaafc8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: DecorationImage(
            image: AssetImage('assets/overlay.png'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "AI-Powered Insights",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Get intelligent analysis of your spending patterns",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _summarize,
                        icon: const Icon(Icons.analytics),
                        label: const Text("Summarize\nMy Month"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.9),
                          foregroundColor: Colors.teal[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _detectAnomalies,
                        icon: const Icon(Icons.warning),
                        label: const Text("Detect\nAnomalies"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.9),
                          foregroundColor: Colors.deepPurple[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _forecast,
                        icon: const Icon(Icons.trending_up),
                        label: const Text("Forecast\nNext Month"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.9),
                          foregroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (summaryText != null || percentages != null)
                  Card(
                    color: Colors.white.withValues(alpha: 0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Total Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (summaryText != null)
                            Text(
                              summaryText!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          const SizedBox(height: 20),
                          const Text(
                            'Expense % by Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (percentages != null)
                            SizedBox(
                              height: 200,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 60,
                                  sections: percentages!.entries.map((e) {
                                    return PieChartSectionData(
                                      value: e.value,
                                      title: '${e.key}\n${e.value}%',
                                      color:
                                          Colors.primaries[(percentages!.keys
                                                      .toList()
                                                      .indexOf(e.key) *
                                                  2) %
                                              Colors.primaries.length],
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    );
                                  }).toList(),
                                  borderData: FlBorderData(show: false),
                                  startDegreeOffset: -90,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                if (anomalies != null)
                  Card(
                    color: Colors.white.withValues(alpha: 0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Anomaly List',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...anomalies!.map(
                            (a) => Text(
                              '${a['category']}: ${a['amount']}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (forecast != null)
                  Card(
                    color: Colors.white.withValues(alpha: 0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Next Month Budget Prediction',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Predicted: ₹${forecast!.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
