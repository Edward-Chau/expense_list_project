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
      child: PhysicalModel(
        elevation: 5,
        color: const Color.fromARGB(255, 250, 237, 119),
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tolotaExpense(),
            ],
          ),
        ),
      ),
    );
  }
}
