import 'package:business_booking/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:business_booking/customer.dart';
import 'package:business_booking/shop.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences =
      await SharedPreferences.getInstance();

  ShopState(sharedPreferences);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.redAccent,
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
                  child: Text("Business Owner"),
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
