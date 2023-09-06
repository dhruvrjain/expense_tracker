import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key,required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get lsExpenseBuckets{
    return [
      ExpenseBucket.forCategory(expenses,Category.leisure),
      ExpenseBucket.forCategory(expenses,Category.food),
      ExpenseBucket.forCategory(expenses,Category.work),
      ExpenseBucket.forCategory(expenses,Category.travel),
    ];
  }

  double get maxExpense{
    double max=0.0;
    for(final bucket in lsExpenseBuckets){
      var t=bucket.totalExpenses;
      if(t>max){
        max=t;
      }
    }
    return max;
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark= MediaQuery.of(context).platformBrightness==Brightness.dark;
    final totalExpenses= maxExpense;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            if(!isDark)
            const Color.fromARGB(0, 255, 255, 255)
            else
            const Color.fromARGB(0, 33, 33, 33)
            ,
            Theme.of(context).cardTheme.color!,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        for(final bucket in lsExpenseBuckets)
        ChartBar(fill: bucket.totalExpenses/totalExpenses, category: bucket.category),
      ],),
    );
  }
}
