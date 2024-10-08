import 'package:flutter/material.dart';

class Totalexpense extends StatelessWidget {
  const Totalexpense(this.tolotaExpense, {super.key});

  final Function() tolotaExpense;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.yellow[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tolotaExpense(),
          ],
        ),
      ),
    );
  }
}
