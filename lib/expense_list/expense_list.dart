import 'package:expense_list_project/expense_list/bottomSheet/ExpenseOverlay.dart';
import 'package:expense_list_project/expense_list/widget/expenseItem.dart';
import 'package:expense_list_project/expense_list/widget/totalExpense.dart';
import 'package:expense_list_project/model/expenModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

List<ExpenModel> registeredExpenseList = [
  ExpenModel(
      title: "sushi",
      amount: 80,
      category: ExpenseCategory.food,
      expenseDate: DateTime(2020, 7, 20),
      remark: ""),
  ExpenModel(
      title: "Japan",
      amount: 2000,
      category: ExpenseCategory.travel,
      expenseDate: DateTime(2022, 12, 7),
      remark: "osaka"),
  ExpenModel(
      title: "Bus",
      amount: 10.0,
      category: ExpenseCategory.transportation,
      expenseDate: DateTime(2023, 1, 2),
      remark: "KMB Bus"),
];

class _ExpenseListState extends State<ExpenseList> {
  Widget tolotaExpense() {
    double totalExpense = 0;
    for (var i = 0; i < registeredExpenseList.length; i++) {
      totalExpense = totalExpense + registeredExpenseList[i].amount;
    }
    return Text(
      "Total Expense: \$${totalExpense.toStringAsFixed(0)}",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  expenseOverlay() {


    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Expenseoverlay(
          addExpense: addExpense,
        );
      },
    );
  }

  addExpense(ExpenModel addToList) {
    setState(
      () {
        registeredExpenseList.add(addToList);
      },
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Icon(Icons.bookmark_add, color: Colors.white),
            SizedBox(width: 8),
            Text("Expense Added"),
          ],
        ),
      ),
    );
  }

  deledExpense(int index) {
    ExpenModel saveExpenseWigdet = registeredExpenseList[index];
    setState(
      () {
        registeredExpenseList.removeAt(index);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                registeredExpenseList.insert(index, saveExpenseWigdet);
              },
            );
          },
        ),
        duration: const Duration(seconds: 3),
        content: const Row(
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text("Item Deleted"),
          ],
        ),
      ),
    );
  }

  saveEditExpanse(ExpenModel item, int index) {
    setState(
      () {
        registeredExpenseList[index] = item;
      },
    );
    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Icon(Icons.save_alt, color: Colors.white),
            SizedBox(width: 8),
            Text("Save Edit"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // print(height);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.my_library_add),
        title: const Text("ExpenseTracker"),
        actions: [
          IconButton(
            onPressed: expenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.red, Colors.purple],
          ),
        ),
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          child: height > 800
              ? Column(
                  children: [
                    Totalexpense(tolotaExpense),
                    Expenseitem(
                      registeredExpenseList: registeredExpenseList,
                      deledExpense: deledExpense,
                      saveEditExpanse: saveEditExpanse,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expenseitem(
                      registeredExpenseList: registeredExpenseList,
                      deledExpense: deledExpense,
                      saveEditExpanse: saveEditExpanse,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
