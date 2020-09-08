import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Representing the connection to server (or in this demo the phone storage)
class ShopState {
  SharedPreferences sharedPreferences;
  static ShopState _state;
  List<Product> _products;

  //TODO add appointment dates

  factory ShopState(sharedPreferences) {
    if (_state == null) {
      _state = ShopState._internal(sharedPreferences);
    }

    _state.reloadProducts();

    return _state;
  }

  static ShopState get state {
    return _state;
  }

  static List<Product> get products {
    return _state._products;
  }


  ShopState._internal(this.sharedPreferences);

  void reloadProducts() {
    var productString = sharedPreferences.getString("products") ?? "[]";
    var productMap = (json.decode(productString) as List);
    _products = productMap
        .where((data) => data != null && data.isNotEmpty)
        .map((data) => Product.fromJson(data))
        .toList();
  }

  void saveNewProduct(Product p) {
    _products.add(p);
    sharedPreferences.setString("products", json.encode(_products));
  }
}

class Product {
  String name;
  double price;
  int timeToComplete;

  Product({this.name, this.price, this.timeToComplete});

  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        timeToComplete = json['timeToComplete'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'price': price, 'timeToComplete': timeToComplete};
}

class CalendarWidget extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  CalendarWidget(this.sharedPreferences);

  @override
  State<StatefulWidget> createState() => CalendarState();
}

class CalendarState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("hi");
  }
}
