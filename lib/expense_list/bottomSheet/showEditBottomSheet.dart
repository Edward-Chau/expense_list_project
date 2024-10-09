import 'package:expense_list_project/expense_list/bottomSheet/editBottomSheet.dart';
import 'package:expense_list_project/model/BottomSheetBar.dart';
import 'package:expense_list_project/model/expenModel.dart';
import 'package:flutter/material.dart';

class ShowEditBottomSheetWidget extends StatefulWidget {
  const ShowEditBottomSheetWidget(
      {required this.saveEditExpanse,
      required this.index,
      required this.deledExpense,
      super.key});

  final Function(ExpenModel expense, int index) saveEditExpanse;
  final int index;
  final Function(int index) deledExpense;

  @override
  State<ShowEditBottomSheetWidget> createState() => _ShowEditBottomSheetState();
}

class _ShowEditBottomSheetState extends State<ShowEditBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: BottomSheetBar(
            height: 8,
            width: 120,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text(
            "Edit",
          ),
          onTap: () {
            showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Editbottomsheet(
                  index: widget.index,
                  saveEditExpanse: widget.saveEditExpanse,
                );
              },
            );
          },
        ),
        ListTile(
          iconColor: Colors.red[900],
          leading: const Icon(Icons.delete),
          title: Text(
            "Delete",
            style: TextStyle(color: Colors.red[900]),
          ),
          onTap: () {
            widget.deledExpense(widget.index);
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
