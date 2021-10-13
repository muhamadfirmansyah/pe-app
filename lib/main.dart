import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './widgets/cart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          errorColor: Colors.redAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '1',
    //   title: 'New Shoes',
    //   amount: 50.00,
    //   date: DateTime.now().subtract(Duration(days: 1)),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'New Books',
    //   amount: 15.00,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTx);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(10),
        content: Text("Successfully to create it"),
      ),
    );
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => (element.id == id));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(10),
        content: Text("You delete it"),
      ),
    );
  }

  void _startAddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text("Personal Expenses"),
      actions: [
        IconButton(
            onPressed: () => _startAddnewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );

    return Scaffold(
      appBar: appbar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddnewTransaction(context),
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: ((MediaQuery.of(context).size.height - appbar.preferredSize.height) - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: ((MediaQuery.of(context).size.height - appbar.preferredSize.height) - MediaQuery.of(context).padding.top) * 0.7,
              child: TransactionList(_userTransactions, _removeTransaction),
            ),
          ],
        ),
      ),
    );
  }
}
