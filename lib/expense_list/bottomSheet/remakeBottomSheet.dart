import 'package:expense_list_project/expense_list/widget/expenseItem.dart';
import 'package:expense_list_project/model/BottomSheetBar.dart';
import 'package:expense_list_project/model/expenModel.dart';
import 'package:flutter/material.dart';

class Remakebottomsheet extends StatefulWidget {
  const Remakebottomsheet(
      {required this.registeredExpenseList,
      required this.index,
      required this.showRemakeWidget,
      super.key});

  final List<ExpenModel> registeredExpenseList;
  final int index;
  final Widget showRemakeWidget;

  @override
  State<Remakebottomsheet> createState() => _RemakebottomsheetState();
}

class _RemakebottomsheetState extends State<Remakebottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                const BottomSheetBar(
                  height: 8,
                  width: 120,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 208, 224),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.registeredExpenseList[widget.index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text("Remake:"),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.showRemakeWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    children: [
                      Text(
                          "\$ ${widget.registeredExpenseList[widget.index].amount}"),
                      const Spacer(),
                      Text(
                        formate.format(widget
                            .registeredExpenseList[widget.index].expenseDate),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
