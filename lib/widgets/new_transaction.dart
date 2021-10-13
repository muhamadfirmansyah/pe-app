import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amoutnController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amoutnController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amoutnController.text);
    final enteredDate = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      enteredDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate as DateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              onSubmitted: (_) => _submitData(),
              controller: _titleController,
              autofocus: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              controller: _amoutnController,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date choosen'
                        : 'Date: ${DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(_selectedDate!)}'),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text("Add Transaction"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
