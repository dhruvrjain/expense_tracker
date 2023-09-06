import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill, required this.category});

  final double fill;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 120,
          width: 70,
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: fill,
            child: DecoratedBox(
              decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Icon(categoryIcons[category])
      ],
    );
  }
}
