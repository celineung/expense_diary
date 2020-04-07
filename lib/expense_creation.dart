import 'package:flutter/material.dart';

class ExpenseCreation extends StatefulWidget {
  ExpenseCreation({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExpenseCreationState createState() => _ExpenseCreationState();
}

class _ExpenseCreationState extends State<ExpenseCreation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Nouvelle page')
        )
    );
  }
}
