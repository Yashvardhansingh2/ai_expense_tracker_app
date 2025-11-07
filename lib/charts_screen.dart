import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'models/expense_model.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  String getShortLabel(String name) {
    List<String> words = name.trim().split(' ');
    if (words.length == 1) {
      return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
    } else {
      return words.take(2).map((w) => w[0].toUpperCase()).join();
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseBox = Hive.box<Expense>('expenses');

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Charts')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF654ea3), Color(0xFFeaafc8)], // purple → pink
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: expenseBox.listenable(),
          builder: (context, Box<Expense> box, _) {
            final expenses = box.values.toList();

            if (expenses.isEmpty) {
              return const Center(
                child: Text(
                  'No expenses to display.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            // Group expenses by category
            final categoryTotals = <String, double>{};
            for (final expense in expenses) {
              categoryTotals[expense.category] =
                  (categoryTotals[expense.category] ?? 0) + expense.amount;
            }

            final sections = categoryTotals.entries.map((entry) {
              final color = _getCategoryColor(entry.key);
              return PieChartSectionData(
                color: color,
                value: entry.value,
                title: getShortLabel(entry.key),
                radius: 100,
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList();

            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'All Saved Expenses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...expenses.asMap().entries.map((entry) {
                        final index = entry.key;
                        final expense = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  expense.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Text(
                                '₹${expense.amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _showDeleteConfirmation(
                                    context,
                                    expenseBox,
                                    index,
                                  );
                                },
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    // Use a more diverse color palette for better differentiation
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
      Colors.lime,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.lightGreen,
    ];

    // Generate a consistent color based on category name
    int hash = category.hashCode;
    return colors[hash.abs() % colors.length];
  }

  void _showDeleteConfirmation(
    BuildContext context,
    Box<Expense> expenseBox,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense'),
          content: const Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                expenseBox.deleteAt(index);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Expense deleted successfully')),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
