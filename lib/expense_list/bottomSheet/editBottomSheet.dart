import 'package:expense_list_project/expense_list/expense_list.dart';
import 'package:expense_list_project/expense_list/widget/expenseItem.dart';
import 'package:expense_list_project/model/BottomSheetBar.dart';
import 'package:expense_list_project/model/expenModel.dart';
import 'package:flutter/material.dart';

class Editbottomsheet extends StatefulWidget {
  const Editbottomsheet(
      {required this.saveEditExpanse, required this.index, super.key});
  final Function(ExpenModel, int) saveEditExpanse;
  final int index;
  @override
  State<Editbottomsheet> createState() => _EditbottomsheetState();
}

class _EditbottomsheetState extends State<Editbottomsheet> {
  var inputTitle = TextEditingController();
  var inputAmount = TextEditingController();
  var inputRemark = TextEditingController();
  ExpenseCategory? selectedCategory;
  DateTime? selectedDate;

  @override
  void dispose() {
    inputTitle.dispose();
    inputAmount.dispose();
    inputRemark.dispose();
    super.dispose();
  }

  saveExpense() {
    var saveAmount = double.tryParse(inputAmount.text);
   

    if (inputTitle.text.trim().isEmpty ||
        saveAmount == null ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // icon: const Icon(Icons.error),
            title: Row(
              children: [
                const Icon(Icons.error_outline),
                const SizedBox(width: 8),
                Text(
                  "Invalid Value",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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
      widget.saveEditExpanse(
          ExpenModel(
              title: inputTitle.text,
              amount: saveAmount,
              category: selectedCategory!,
              expenseDate: selectedDate!,
              remark: inputRemark.text),
          widget.index);
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
  void initState() {
    super.initState();
    selectedCategory = registeredExpenseList[widget.index].category;
    selectedDate = registeredExpenseList[widget.index].expenseDate;
    inputTitle.text = registeredExpenseList[widget.index].title;
    inputAmount.text = registeredExpenseList[widget.index].amount.toString();
    inputRemark.text = registeredExpenseList[widget.index].remark;
  }

  @override
  Widget build(BuildContext context) {
     final  KeyboardSpace=MediaQuery.of(context).viewInsets.bottom;
    // inputTitle.text = registeredExpenseList[widget.index].title;
    // inputAmount.text = registeredExpenseList[widget.index].amount.toString();
    // inputRemark.text = registeredExpenseList[widget.index].remark;
    // selectedCategory = registeredExpenseList[widget.index].category;
    // selectedDate = registeredExpenseList[widget.index].expenseDate;

    String dateText;
    if (selectedDate == null) {
      dateText = "No Date selected";
    } else {
      dateText = formate.format(selectedDate!);
    }

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 30),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(bottom: KeyboardSpace),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 50),
                child: BottomSheetBar(height: 8, width: 100),
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
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
                      style: const TextStyle(color: Colors.black),
                      controller: inputAmount,
                      keyboardType: TextInputType.number,
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
                        Text(dateText),
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
                    ).toList(),
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
                    maxLines: 8,
                    maxLength: 350,
                    controller: inputRemark,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
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
                      child: const Text("Save Expense"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
