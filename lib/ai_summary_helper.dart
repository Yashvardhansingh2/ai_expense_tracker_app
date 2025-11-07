import 'package:hive/hive.dart';
import 'models/expense_model.dart';

class AISummaryHelper {
  static String generateSummary(Box<Expense> expenseBox) {
    if (expenseBox.isEmpty) return "No expenses recorded yet.";

    double total = 0;
    Map<String, double> categoryTotals = {};

    for (var expense in expenseBox.values) {
      total += expense.amount;
      categoryTotals.update(
        expense.category,
        (val) => val + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    String topCategory = "";
    double topAmount = 0;

    categoryTotals.forEach((cat, amt) {
      if (amt > topAmount) {
        topCategory = cat;
        topAmount = amt;
      }
    });

    return """
This month, you’ve spent a total of ₹${total.toStringAsFixed(2)}.
Your highest spending category is **$topCategory**, with ₹${topAmount.toStringAsFixed(2)}.
Other key expenses include:
${categoryTotals.entries.map((e) => "- ${e.key}: ₹${e.value.toStringAsFixed(2)}").join("\n")}
You might consider reducing your spending in $topCategory to stay within budget next month.
""";
  }
}
