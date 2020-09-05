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
    var tabs = ["White"];

    return DefaultTabController(
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
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}