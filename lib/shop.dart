import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopWidget extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  ShopWidget(this.sharedPreferences);
  @override
  Widget build(BuildContext context) {
    var tabs = ["Products", "Calendar"];
    var tabWidgets = [ProductWidget(this.sharedPreferences), CalendarWidget(this.sharedPreferences)];

    return Theme(
        data: ThemeData(
          primaryColor: Colors.green[900],
          colorScheme: ColorScheme.dark(
              secondary: Colors.amberAccent,
              surface: Colors.amber
          ),
        ),
        child: DefaultTabController(

          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Shop Management"),
              bottom: TabBar(
                isScrollable: false,
                tabs: [
                  for (final label in tabs) Tab(text: label),
                ],
              ),
            ),
            body: TabBarView(children: [
              for (final widget in tabWidgets) Center(child: widget),
            ]),
          ),
        ));
  }
}

class ProductWidget extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  ProductWidget(this.sharedPreferences);
  @override
  State<StatefulWidget> createState() => _ProductState();
}

class _ProductState extends State<ProductWidget> {
  List<Product> products = [];

  void addProduct(Product p) {
    products.add(p);
    this.setState(() {});//reload
    widget.sharedPreferences.setString("products", json.encode(products));
  }

  Future<void> promptAddProduct() async {
    await showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text("Add a new product"),
            content: ProductForm(

            ),
          ),
      barrierDismissible: true,
    ).then((product) => addProduct(product));
  }


  @override
  Widget build(BuildContext context) {
    var productString = widget.sharedPreferences.getString("products");
    print(productString);
    var l = (json.decode(productString) as List ?? []);
    products = [];
    for (Map data in l) {
      if (data != null && data.isNotEmpty) {
        print(data.entries);
        products.add(Product.fromJson(data));
      }
    }
    for (final product in products) {
      print(product.name + " " + product.price.toString() + " " + product.timeToComplete.toString());
    }


    return Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (final product in products)
              Card(
                child: Column(children: <Widget>[
                  Text(product.name),
                  Text(product.price.toString()),
                  Text(product.timeToComplete.toString()),
                ]),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: promptAddProduct,
          child: Icon(Icons.add),
        ));
  }
}

class ProductForm extends StatefulWidget {
  ProductForm({Key key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  Product addedProduct = Product();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Product Name',
            ),
            onSaved: (name) {
              addedProduct.name = name;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Product Price',
            ),
            keyboardType: TextInputType.number,
            onSaved: (price) {
              addedProduct.price = double.parse(price);
            },
            validator: (value) {
              if (!(double.parse(value) is double)) {
                return 'Please enter a number';
              }
              return null;
            },
          ),

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Appointment Length',
            ),
            keyboardType: TextInputType.number,
            onSaved: (time) {
              addedProduct.timeToComplete = int.parse(time);
            },
            validator: (value) {
              if (!(int.parse(value) is int)) {
                return 'Please enter the number of minutes the appointment will need';
              }
              return null;
            },
          ),


          RaisedButton(onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              Navigator.pop(context, addedProduct);
            }
          },
            child: Text("Submit"),
          )

        ],

      ),
    );
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
      {
        'name': name,
        'price': price,
        'timeToComplete': timeToComplete
      };
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
