import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:ai_expense_tracker_app/main.dart';
import 'package:ai_expense_tracker_app/models/expense_model.dart';
import 'package:ai_expense_tracker_app/models/budget_model.dart';

class FakePathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsDirectory() async => '/tmp/test';

  @override
  Future<String?> getApplicationDocumentsPath() async => '/tmp/test';

  @override
  Future<String?> getApplicationSupportDirectory() async => '/tmp/test';
}

void main() {
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(BudgetAdapter());
    await Hive.openBox<Expense>('expenses');
    await Hive.openBox<Budget>('budgets');
  });

  tearDownAll(() async {
    await Hive.close();
  });

  testWidgets('App launches and shows main screen', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // Verify that the app title is shown
    expect(find.text('AI Expense Tracker'), findsOneWidget);

    // Verify that the input fields are present
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that the predict button is present
    expect(find.text('Predict Category'), findsOneWidget);
  });
}
