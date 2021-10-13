import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              height: constraint.maxHeight * 0.1,
              child: Text(
                label,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.025,
            ),
            Container(
              height: constraint.maxHeight * 0.75,
              width: 12,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: constraint.maxHeight * 0.75,
                    width: 12,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.025,
            ),
            Container(
              height: constraint.maxHeight * 0.1,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  '\$${spendingAmount.toStringAsFixed((0))}',
                  style: TextStyle(
                    color: spendingAmount > 0 ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 6,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
