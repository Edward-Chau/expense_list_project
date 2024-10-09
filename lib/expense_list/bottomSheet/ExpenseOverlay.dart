import 'dart:io';
import 'package:expense_list_project/expense_list/widget/expenseItem.dart';
import 'package:expense_list_project/model/BottomSheetBar.dart';
import 'package:expense_list_project/model/expenModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Expenseoverlay extends StatefulWidget {
  const Expenseoverlay({required this.addExpense, super.key});
  final Function(ExpenModel) addExpense;
  @override
  State<Expenseoverlay> createState() => _ExpenseoverlayState();
}

class _ExpenseoverlayState extends State<Expenseoverlay> {
  // final _formKey = GlobalKey<FormState>();
  var inputTitle = TextEditingController();
  var inputAmount = TextEditingController();
  var inputRemark = TextEditingController();
  ExpenseCategory selectedCategory = ExpenseCategory.food;
  DateTime? selectedDate;

  @override
  void dispose() {
    inputTitle.dispose();
    inputAmount.dispose();
    inputRemark.dispose();
    super.dispose();
  }

  void deviceDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline),
                const SizedBox(width: 8),
                Text("Invalid Value",
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline),
                const SizedBox(width: 8),
                Text("Invalid Value",
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              )
            ],
          );
        },
      );
    }
  }

  saveExpense() {
    var saveAmount = double.tryParse(inputAmount.text);

    if (inputTitle.text.trim().isEmpty ||
        saveAmount == null ||
        selectedDate == null) {
      deviceDialog();
    } else {
      widget.addExpense(
        ExpenModel(
            title: inputTitle.text,
            amount: saveAmount,
            category: selectedCategory,
            expenseDate: selectedDate!,
            remark: inputRemark.text),
      );
    }
  }

  dateSelected() async {
    final DateTime currentDate = DateTime.now();
    DateTime? pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime(currentDate.year - 10),
        lastDate: currentDate);

    setState(
      () {
        selectedDate = pickDate;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final KeyBoardSpace = MediaQuery.of(context).viewInsets.bottom;

    // inputTitle.text = defaultTitleText;
    String dateText;
    if (selectedDate == null) {
      dateText = "No Date selected";
    } else {
      dateText = formate.format(selectedDate!);
    }

    return LayoutBuilder(builder: (ctx, boxConstraints) {
      final widght = boxConstraints.maxWidth;

      return Container(
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 30),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: KeyBoardSpace + 10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 50),
                  child: BottomSheetBar(height: 8, width: 100),
                ),
                if (widght > 500)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLength: 20,
                          controller: inputTitle,
                          decoration: const InputDecoration(
                            labelText: "Title",
                            hintText: "Input Expense titie",
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: widght / 10),
                      Expanded(
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          keyboardType: TextInputType.number,
                          controller: inputAmount,
                          decoration: const InputDecoration(
                            labelText: "\$ Amount",
                            hintText: "Input Amount",
                            prefixText: "\$ ",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    autofocus: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLength: 20,
                    controller: inputTitle,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      hintText: "Input Expense titie",
                      // border: OutlineInputBorder(),
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.number,
                        controller: inputAmount,
                        decoration: const InputDecoration(
                          labelText: "\$ Amount",
                          hintText: "Input Amount",
                          prefixText: "\$ ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          const Spacer(),
                          Text(
                            dateText,
                            style: const TextStyle(color: Colors.black),
                          ),
                          IconButton(
                            onPressed: dateSelected,
                            icon: const Icon(Icons.calendar_month_rounded),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    DropdownButton(
                      style: TextStyle(color: Colors.blue[900]),
                      value: selectedCategory,
                      items: ExpenseCategory.values.map(
                        (toElement) {
                          return DropdownMenuItem(
                            value: toElement,
                            child: Text(toElement.name.toUpperCase()),
                          );
                        },
                      ).toList(), //?
                      onChanged: (value) {
                        setState(
                          () {
                            selectedCategory = value!;
                          },
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Remake:"),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 8,
                      maxLength: 350,
                      controller: inputRemark,
                      decoration: const InputDecoration(
                        hintText: "take some remark..",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: saveExpense,
                        child: const Text("Add Expense"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
