import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/expense_model.dart';
import 'models/budget_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'ai_summary_helper.dart';
import 'theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseBox = Hive.box<Expense>('expenses');
    final budgetBox = Hive.box<Budget>('budgets');

    // Group expenses by category
    final Map<String, double> categoryTotals = {};
    for (var expense in expenseBox.values) {
      if (expense.date.month == DateTime.now().month) {
        categoryTotals.update(
          expense.category,
          (value) => value + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }
    }

    // Calculate total monthly spending
    final totalSpent = categoryTotals.values.fold(
      0.0,
      (sum, item) => sum + item,
    );

    // Find top spending category
    String topCategory = "";
    double topAmount = 0;
    categoryTotals.forEach((cat, amt) {
      if (amt > topAmount) {
        topCategory = cat;
        topAmount = amt;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Monthly Summary")),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "ai_summary",
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              final summary = AISummaryHelper.generateSummary(expenseBox);
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("AI Expense Summary"),
                  content: SingleChildScrollView(child: Text(summary)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(Icons.auto_awesome),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "add_budget",
            onPressed: () => _addBudgetDialog(context, budgetBox),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Spent: ₹${totalSpent.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: categoryTotals.entries.map((entry) {
                  final budget = budgetBox.values.firstWhere(
                    (b) => b.category == entry.key,
                    orElse: () => Budget(category: entry.key, limit: 0),
                  );

                  final spent = entry.value;
                  final limit = budget.limit;
                  final progress = limit > 0
                      ? (spent / limit).clamp(0.0, 1.0)
                      : 0.0;
                  final color = progress < 0.7
                      ? Colors.green
                      : (progress < 1.0 ? Colors.orange : Colors.red);

                  return Card(
                    child: ListTile(
                      title: Text(entry.key),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Spent: ₹${spent.toStringAsFixed(2)} / ₹${limit.toStringAsFixed(2)}",
                          ),
                          const SizedBox(height: 6),
                          LinearProgressIndicator(
                            value: progress,
                            color: color,
                            backgroundColor: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Spending Trend", style: TextStyle(fontSize: 18)),
            SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: List.generate(
                        categoryTotals.length,
                        (i) => FlSpot(
                          i.toDouble(),
                          categoryTotals.values.elementAt(i).toDouble(),
                        ),
                      ),
                      dotData: const FlDotData(show: false),
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: categoryTotals.isNotEmpty
          ? Container(
              color: AppColors.primary,
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "💡 Tip: Try limiting your ${topCategory.toLowerCase()} spending by 10% next month to save ₹${(topAmount * 0.1).toStringAsFixed(2)}.",
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          : null,
    );
  }

  void _addBudgetDialog(BuildContext context, Box<Budget> box) {
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController limitController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Budget"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Limit (₹)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final category = categoryController.text.trim();
              final limit = double.tryParse(limitController.text) ?? 0;
              if (category.isNotEmpty && limit > 0) {
                box.add(Budget(category: category, limit: limit));
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
