import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.addExpense});

  final Function(Expense) addExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _expenseDate;
  Category _selectedCategory = Category.leisure;

  _openDatePicker() async {
    final now = DateTime.now();
    final oneYearBack = DateTime(now.year - 1, now.month, now.day);

    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: oneYearBack,
      lastDate: now,
    );
    setState(() {
      _expenseDate = pickedDate;
    });
  }

  _submitForm() {
    if (_titleController.text.trim().isEmpty ||
        double.tryParse(_amountController.text) == null ||
        double.tryParse(_amountController.text)! <= 0 ||
        _expenseDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure that you have entered appropriate values for Title, Amount, Date.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    Expense e=Expense(amount: double.tryParse(_amountController.text)!, date: _expenseDate!, title: _titleController.text.trim(), category: _selectedCategory);
    widget.addExpense(e);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text(
                'Title',
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text(
                      'Amount',
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _expenseDate == null
                          ? 'No date Selected'
                          : formatter.format(_expenseDate!),
                    ),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name[0].toUpperCase() + e.name.substring(1),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = val;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
