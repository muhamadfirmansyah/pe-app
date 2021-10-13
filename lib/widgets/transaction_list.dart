import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 45.0,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "You have no data!",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColorLight,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY)
                          .format((transactions[index].date)),
                    ),
                    // trailing: IconButton(
                    //   icon: Icon(Icons.delete),
                    //   onPressed: () => deleteTransaction(transactions[index].id),
                    //   color: Theme.of(context).errorColor,
                    // ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'delete') {
                          deleteTransaction(transactions[index].id);
                        }
                        return;
                      },
                      itemBuilder: (context) => <PopupMenuItem<String>>[
                        PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            horizontalTitleGap: 2,
                            leading: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            title: Text("Delete Item"),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            horizontalTitleGap: 2,
                            leading: Icon(
                              Icons.edit,
                              color: Theme.of(context).accentColor,
                            ),
                            title: Text("Edit Item"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
