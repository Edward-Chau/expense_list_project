import 'package:flutter/material.dart';

enum ExpenseCategory { food, travel, medical, transportation, personal }

final categoryIcon = {
  ExpenseCategory.food: const Icon(Icons.fastfood),
  ExpenseCategory.travel: const Icon(Icons.flight_takeoff),
  ExpenseCategory.medical: const Icon(Icons.medical_services),
  ExpenseCategory.transportation: const Icon(Icons.directions_transit),
  ExpenseCategory.personal: const Icon(Icons.person)
};

class ExpenModel {
  ExpenModel(
      {required this.title,
      required this.amount,
      required this.category,
      required this.expenseDate,
      required this.remark});

  String title;
  double amount;
  ExpenseCategory category;
  DateTime expenseDate;
  String remark;
}
