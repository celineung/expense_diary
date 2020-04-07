import 'package:flutter/material.dart';

enum NavigationPage {
  Homepage,
  ExpenseCreation
}

class Navigation extends StatelessWidget {

  final NavigationPage currentPage;

  Navigation({ this.currentPage });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            title(),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            )
          ],
        )
    );
  }


  Widget title() {
    return Container(
        decoration: BoxDecoration(color: Colors.blue),
        constraints: BoxConstraints.tightForFinite(height: 100),
        child: DrawerHeader(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.import_contacts,
                  color: Colors.white,
                  size: 32,
                )
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Expense diary',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                        )
                    ),
                    Text(
                        'Daily expense tracker',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        )
                    )
                  ]
              ),
            ],
          ),
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.only(left: 20),
        )
    );
  }
}
