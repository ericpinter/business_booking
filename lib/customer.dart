import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class CustomerWidget extends StatefulWidget {
  CustomerWidget({Key key}) : super(key: key);

  @override
  _CustomerWidgetState createState() => _CustomerWidgetState();
}

class _CustomerWidgetState extends State<CustomerWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    var tabs = ["Booking"];

    return Theme(
        data: ThemeData(
          primarySwatch: Colors.blue
        ),
        child: DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            isScrollable: false,
            tabs: [
              for (final tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (final tab in tabs)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'This will eventually be where the user can see the open time-slots',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    )
    );
  }
}