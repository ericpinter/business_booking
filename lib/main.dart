import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'customer.dart';
import 'shop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShopOrCustomerWidget(),
    );
  }
}

class ShopOrCustomerWidget extends StatelessWidget {
  void redirectTo(context, Widget w) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text("I am a"),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                  child: Text("Business"),
                  onPressed: () {
                    redirectTo(context, ShopWidget());
                  }),
              RaisedButton(
                  child: Text("Customer"),
                  onPressed: () {
                    redirectTo(context, CustomerWidget());
                  })
            ],
          ),
        ])));
  }
}
