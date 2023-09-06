import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  openExpenseAdder() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpense: addExpense),
    );
  }

  addExpense(Expense e) {
    setState(() {
      ls.add(e);
    });
  }

  removeExpense(Expense e) {
    final index = ls.indexOf(e);
    setState(() {
      ls.remove(e);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              ls.insert(index, e);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> ls = [
    Expense(
      amount: 8.99,
      date: DateTime.now(),
      title: 'Movie',
      category: Category.leisure,
    ),
    Expense(
      amount: 20,
      date: DateTime.now(),
      title: 'Haircut',
      category: Category.work,
    ),
    Expense(
      amount: 100,
      date: DateTime.now(),
      title: 'Cab',
      category: Category.travel,
    ),
    Expense(
      amount: 50.99,
      date: DateTime.now(),
      title: 'Junk Food',
      category: Category.food,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String mode=MediaQuery.of(context).platformBrightness==Brightness.dark? "Dark" : 'Light';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: openExpenseAdder, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          if (ls.isNotEmpty)
            Chart(
              expenses: ls,
            ),
          Expanded(
            child: ls.isNotEmpty
                ? ExpenseList(expenses: ls, removeExpense: removeExpense)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/noExpense$mode.png'),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text('No expenses added. Add some to continue.'),
                      ],
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: 
          FloatingActionButton(onPressed: openExpenseAdder,child: Icon(Icons.add),)
          ,)
        ],
      ),
    );
  }
}
