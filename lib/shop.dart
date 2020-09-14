import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:business_booking/storage.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ShopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tabs = ["Products", "Calendar"];
    var tabWidgets = [ProductWidget(), CalendarWidget()];

    return Theme(
        data: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.orange[300],
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
  @override
  State<StatefulWidget> createState() => _ProductState();
}

class _ProductState extends State<ProductWidget> {

  void reload() {
    this.setState(() {});
  }

  Future<void> promptAddProduct() async {
    await showDialog(
      context: context,
      builder: (_) => AddProductDialog(),
      barrierDismissible: true,
    ).then((product) => {if (product != null) ShopState.state.saveNewProduct(product)});
    reload();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (final product in ShopState.products)
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

class AddProductDialog extends StatefulWidget {
  AddProductDialog({Key key}) : super(key: key);

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  Product addedProduct = Product();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Add a new product"),
        content: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

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
                  if (value.isEmpty || !(double.parse(value) is double)) {
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
                  if (value.isEmpty || !(int.parse(value) is int)) {
                    return 'Please enter the length in minutes';
                  }
                  return null;
                },
              ),


            ],

          ),

        ),
        actions:
        [RaisedButton(onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            Navigator.pop(context, addedProduct);
          }
        },
          child: Text("Submit"),
        )
        ]
    );
  }
}


class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarState();
}

class CalendarState extends State<CalendarWidget> {
  void reload() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text("Booked Appointments"),
            for (final appointment in ShopState.bookedAppointments)
              Card(
                child: Column(children: <Widget>[
                  Text(appointment.toString()),
                ]),
              ),
            Text("Open Appointment Times"),
            for (final timeRange in ShopState.openAppointments)
              Card(
                child: Column(children: <Widget>[
                  Text(timeRange.toString())
                ]),
              ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                minTime: DateTime(2018, 3, 5),
                maxTime: DateTime(2021, 1, 1),
                onChanged: (_) {},
                onConfirm: (dateTime) {
                  print(dateTime.toString());
                  ShopState.state.saveNewOpenAppointment(dateTime);
                  reload();
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en
            )
          },
          child: Icon(Icons.add),
        ));
  }
}
