import 'package:flutter/material.dart';
import 'expensespage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue, foregroundColor: Colors.white),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.blue),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (ctx) => const ExpensesHomePage(),
        Routes.add: (ctx) => const AddExpenses(),
      },
    );
  }
}

class Routes {
  static const home = '/';
  static const add = '/add';
}

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddExpensePage();
  }
}
