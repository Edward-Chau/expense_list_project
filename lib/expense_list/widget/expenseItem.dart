import 'package:expense_list_project/expense_list/expense_list.dart';
import 'package:expense_list_project/expense_list/bottomSheet/remakeBottomSheet.dart';
import 'package:expense_list_project/expense_list/bottomSheet/showEditBottomSheet.dart';

import 'package:expense_list_project/model/expenModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var formate = DateFormat.yMd();

class Expenseitem extends StatefulWidget {
  const Expenseitem(
      {required this.saveEditExpanse,
      required this.registeredExpenseList,
      required this.deledExpense,
      super.key});
  final Function(ExpenModel expense, int index) saveEditExpanse;
  final List<ExpenModel> registeredExpenseList;
  final Function(int index) deledExpense;
  @override
  State<Expenseitem> createState() => _ExpenseitemState();
}

class _ExpenseitemState extends State<Expenseitem> {
  showRemake(int index) {
    Widget showRemakeWidget = Text(
      widget.registeredExpenseList[index].remark,
    );

    if (widget.registeredExpenseList[index].remark.isEmpty) {
      showRemakeWidget = const Center(
        child: Text(
          "/ DO NOT HAVE REMAKE /",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Remakebottomsheet(
          registeredExpenseList: registeredExpenseList,
          index: index,
          showRemakeWidget: showRemakeWidget,
        );
      },
    );
  }

  showEditBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return ShowEditBottomSheetWidget(
          index: index,
          deledExpense: widget.deledExpense,
          saveEditExpanse: widget.saveEditExpanse,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.registeredExpenseList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          "Do Not Have Any Expanse",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: widget.registeredExpenseList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                decoration: const BoxDecoration(color: Colors.deepOrange),
                child: const Icon(Icons.cancel),
              ),
              key: ValueKey(registeredExpenseList[index]),
              onDismissed: (direction) {
                widget.deledExpense(index);
              },
              child: Card(
                child: ListTile(
                  leading: categoryIcon[
                      widget.registeredExpenseList[index].category],
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      widget.registeredExpenseList[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Row(
                        children: [
                          const Text("\$ "),
                          Text(
                            (widget.registeredExpenseList[index].amount)
                                .toString(),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        formate
                            .format(
                                widget.registeredExpenseList[index].expenseDate)
                            .toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showEditBottomSheet(index);
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                  onTap: () {
                    showRemake(index);
                  },
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
