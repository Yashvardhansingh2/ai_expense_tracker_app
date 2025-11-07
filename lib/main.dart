import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/expense_model.dart';
import 'models/budget_model.dart';
import 'charts_screen.dart';
import 'dashboard_screen.dart';
import 'screens/insights_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(BudgetAdapter());
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox<Budget>('budgets');
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const ExpenseHomePage(),
    );
  }
}

class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({super.key});

  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _prediction = '';
  bool _isLoading = false;
  final expenseBox = Hive.box<Expense>('expenses');
  final String backendUrl =
      'https://ai-expense-tracker-backend-xms7.onrender.com/predict';

  Color categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
        return Colors.orange;
      case 'transportation':
        return Colors.blueAccent;
      case 'entertainment':
        return Colors.pink;
      case 'health & fitness':
        return Colors.green;
      case 'housing & utilities':
        return Colors.purple;
      case 'shopping':
        return Colors.teal;
      case 'education':
        return Colors.indigo;
      case 'travel':
        return Colors.cyan;
      case 'financial':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  Future<void> _predictCategory() async {
    final expenseText = _descController.text.trim();

    if (expenseText.isEmpty) {
      setState(() => _prediction = 'Please enter an expense description.');
      return;
    }

    setState(() {
      _isLoading = true;
      _prediction = '';
    });

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': expenseText}),
      );

      debugPrint('Response code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _prediction = data['category'] ?? 'Uncategorized';
        });
      } else {
        setState(() {
          _prediction = 'Server Error (${response.statusCode})';
        });
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _prediction = 'Connection Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveExpense() {
    if (_prediction.isEmpty || _amountController.text.isEmpty) return;

    final newExpense = Expense(
      description: _descController.text,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      category: _prediction,
      date: DateTime.now(),
    );

    expenseBox.add(newExpense);

    _descController.clear();
    _amountController.clear();
    setState(() => _prediction = '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Expense Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChartsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InsightsScreen()),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6D83F2), // blue
              Color(0xFFB664E6), // purple
              Color(0xFFF6C1D3)  // pinkish
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _descController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Expense Description',
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        foregroundColor: Colors.teal[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _isLoading ? null : _predictCategory,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.teal)
                          : const Text('Predict Category'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (_prediction.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'Predicted Category: $_prediction',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        foregroundColor: Colors.teal[700],
                      ),
                      onPressed: _saveExpense,
                      child: const Text('Save Expense'),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: expenseBox.listenable(),
                  builder: (context, Box<Expense> box, _) {
                    if (box.isEmpty) {
                      return const Center(
                        child: Text(
                          'No expenses yet.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final expense = box.getAt(index)!;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:
                                categoryColor(expense.category).withOpacity(0.9),
                          ),
                          child: ListTile(
                            leading:
                                const Icon(Icons.category, color: Colors.white),
                            title: Text(
                              expense.description,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              '${expense.category} • ₹${expense.amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Text(
                              '${expense.date.day}/${expense.date.month}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}