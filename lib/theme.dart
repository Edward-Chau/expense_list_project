import 'package:expense_list_project/expense_list/expense_list.dart';
import 'package:expense_list_project/model/ETAcolors.dart';
import 'package:expense_list_project/navigationBar.dart';
import 'package:flutter/material.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark().copyWith(),
      theme: ThemeData().copyWith(
        appBarTheme: AppBarTheme(
          color: Etacolors.backGroundColor_1,
          foregroundColor: Colors.purple[50],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Etacolors.backGroundColor_1,
            backgroundColor: Colors.grey[300],
          ),
        ),
        textTheme: const TextTheme().copyWith(
          bodyMedium: const TextStyle(
            color: Colors.black,
          ),
          titleLarge: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: const ExpenseList(),
    );
  }
}
