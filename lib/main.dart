import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer.dart';
import 'shop.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences =
      await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  // This widget is the root of your application.

  MyApp(this.sharedPreferences);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.redAccent,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShopOrCustomerWidget(this.sharedPreferences),
    );
  }
}

class ShopOrCustomerWidget extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  ShopOrCustomerWidget(this.sharedPreferences);
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
                  child: Text("Business Owner"),
                  onPressed: () {
                    redirectTo(context, ShopWidget(this.sharedPreferences));
                  }),
              RaisedButton(
                  child: Text("Customer"),
                  onPressed: () {
                    redirectTo(context, CustomerWidget(this.sharedPreferences));
                  })
            ],
          ),
        ])));
  }
}
