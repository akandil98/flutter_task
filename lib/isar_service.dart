import 'dart:developer';
import 'dart:math' show Random;
import 'package:flutter_task/collections/expense.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/domain/entities/response.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  late final Future<Isar> db;

  factory IsarService() {
    return _instance;
  }

  IsarService._internal() {
    db = openDB();
  }

  final List<String> expenseTypes = [
    AppConstants.shopping,
    AppConstants.wellness,
    AppConstants.transport,
    AppConstants.barsAndRestaurant,
    AppConstants.subscriptions,
  ];
  final List<double> possibleAmounts = [10.0, 20.0, 30.0, 40.0, 50.0];
  final int minExpensesPerDay = 1;
  final int maxExpensesPerDay = 30;

  List<Expense> generateExpenses({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final List<Expense> expenses = [];

    DateTime currentDate = startDate;
    final Random random = Random();

    while (currentDate.isBefore(endDate)) {
      final int numExpenses = minExpensesPerDay +
          random.nextInt(maxExpensesPerDay - minExpensesPerDay + 1);

      for (int i = 0; i < numExpenses; i++) {
        final String type = expenseTypes[random.nextInt(expenseTypes.length)];
        final double amount =
            possibleAmounts[random.nextInt(possibleAmounts.length)];

        final Expense expense = Expense(
          type: type,
          amount: amount.toString(),
          date: currentDate,
        );
        expenses.add(expense);
      }

      // Move to the next day
      currentDate = currentDate.add(const Duration(days: 1));
    }

    // Shuffle the expenses list to make types and amounts random for each day
    expenses.shuffle();

    return expenses;
  }

  Future<void> addExpenses() async {
    final isar = await db;
    List<Expense> newExpenses = generateExpenses(
      startDate: AppConstants.initialDate,
      endDate: DateTime.now(),
    );
    isar.writeTxn(() => isar.expenses.putAll(newExpenses));
  }

  double calculateTotalExpense(List<Expense> expenses) {
    double totalExpense = 0.0;

    for (var expense in expenses) {
      try {
        // Parse the amount from string to double
        double amount = double.parse(expense.amount!);

        // Add the parsed amount to the totalExpense
        totalExpense += amount;
      } catch (e) {
        // Handle parsing errors here if needed
        log('Error parsing amount for expense: ${expense.amount}');
      }
    }

    return totalExpense;
  }

  Future<Response?> calculateExpensesBetween(
    DateTime lower,
    DateTime upper,
  ) async {
    final isar = await db;
    //! total expense
    List<Expense> expenses =
        await isar.expenses.filter().dateBetween(lower, upper).findAll();
    double totalSpent = calculateTotalExpense(expenses);

    //! shopping
    List<Expense> shoppingExpenses = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.shopping)
        .findAll();
    double shoppingTotal = calculateTotalExpense(shoppingExpenses);
    int shoppingTransactions = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.shopping)
        .count();
    double shoppingPct = 0;
    if (shoppingTotal != 0) {
      shoppingPct = (shoppingTotal / totalSpent) * 100.0;
    }

    //! wellness
    List<Expense> wellnessExpenses = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.wellness)
        .findAll();
    double wellnessTotal = calculateTotalExpense(wellnessExpenses);
    int wellnessTransactions = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.wellness)
        .count();

    double wellnessPct = 0;

    if (wellnessTotal != 0) {
      wellnessPct = (wellnessTotal / totalSpent) * 100.0;
    }

    //! transport
    List<Expense> transportExpenses = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.transport)
        .findAll();
    double transportTotal = calculateTotalExpense(transportExpenses);
    int transportTransactions = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.transport)
        .count();
    double transportPct = 0;
    if (transportTotal != 0) {
      transportPct = (transportTotal / totalSpent) * 100.0;
    }

    //! bars
    List<Expense> barsAndResturantExpenses = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.barsAndRestaurant)
        .findAll();
    double barsAndResturantTotal =
        calculateTotalExpense(barsAndResturantExpenses);
    int barsAndResturantTransactions = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.barsAndRestaurant)
        .count();
    double barsAndResturantPct = 0;
    if (barsAndResturantTotal != 0) {
      barsAndResturantPct = (barsAndResturantTotal / totalSpent) * 100.0;
    }

    //! subscriptions
    List<Expense> subscriptionsExpenses = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.subscriptions)
        .findAll();
    double subscriptionsTotal = calculateTotalExpense(subscriptionsExpenses);
    int subscriptionsTransactions = await isar.expenses
        .filter()
        .dateBetween(lower, upper)
        .and()
        .typeEqualTo(AppConstants.subscriptions)
        .count();
    double subscriptionsPct = 0;
    if (subscriptionsTotal != 0) {
      subscriptionsPct = (subscriptionsTotal / totalSpent) * 100.0;
    }

    return Response(
      totalSpent: totalSpent,
      shoppingTotal: shoppingTotal,
      shoppingPct: shoppingPct,
      shoppingTransactions: shoppingTransactions,
      wellnessTotal: wellnessTotal,
      wellnessTransactions: wellnessTransactions,
      wellnessPct: wellnessPct,
      transportTotal: transportTotal,
      transportTransactions: transportTransactions,
      transportPct: transportPct,
      barsAndResturantTotal: barsAndResturantTotal,
      barsAndResturantTransactions: barsAndResturantTransactions,
      barsAndResturantPct: barsAndResturantPct,
      subscriptionsTotal: subscriptionsTotal,
      subscriptionsTransactions: subscriptionsTransactions,
      subscriptionsPct: subscriptionsPct,
    );
  }

  //! clean db
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  //! open db
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          ExpenseSchema,
        ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
