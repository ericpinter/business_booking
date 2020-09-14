import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:business_booking/storage.dart';


class CustomerWidget extends StatefulWidget {
  CustomerWidget({Key key}) : super(key: key);

  @override
  _CustomerWidgetState createState() => _CustomerWidgetState();
}

class _CustomerWidgetState extends State<CustomerWidget> {
  void reload() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var tabs = ["Example Store"];


    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text("Open Appointment Times"),
          for (final timeRange in ShopState.openAppointments)
            Card(
                child: InkWell(
                  child:Text(timeRange.toString(),textScaleFactor: 2.0,),
                  onTap: () {
                    if (ShopState.products.length > 0)
                      promptBookAppointment(timeRange);
                  },
                )
            ),

        ],
      ),);
  }



  Future<void> promptBookAppointment(time) async {
    await showDialog(
      context: context,
      builder: (_) => BookAppointmentDialog(time:time),
      barrierDismissible: true,
    ).then((appointment) {
      print(appointment.runtimeType);
    if (appointment != null) {
      print(appointment.toString());
        ShopState.state.saveBookingFor(appointment);
        reload();
    }
    });
  }

}

class BookAppointmentDialog extends StatefulWidget {
  DateTime time;
  BookAppointmentDialog({this.time});


  @override
  State<StatefulWidget> createState() => _BookAppointmentState(start: this.time);
}

class _BookAppointmentState extends State<BookAppointmentDialog> {
  void reload() {
    this.setState(() {});
  }

  DateTime start;
  _BookAppointmentState({this.start});
  final _formKey = GlobalKey<FormState>();
  Product activeProduct = ShopState.products.first;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Book this appointment"),
        content: Form(
          key: _formKey,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              DropdownButton(
                  value: activeProduct,
                  icon: Icon(Icons.arrow_downward),
                  items: ShopState.products.map<DropdownMenuItem<Product>>((prod) => DropdownMenuItem<Product>(child: Text(prod.name), value:prod)).toList(),
                  onChanged: (Product product) {
                    activeProduct = product;
                    reload();
                  }
              ),
              Text(activeProduct.toString())
            ],
          ),
        ),
        actions:
        [RaisedButton(onPressed: () {
          if (_formKey.currentState.validate()) {
            var addedAppointment = Appointment(this.start,
                                               this.start.add(Duration(minutes: activeProduct.timeToComplete)),
                                               activeProduct);
            _formKey.currentState.save();
            Navigator.pop(context, addedAppointment);
          }
        },
          child: Text("Submit"),
        )
        ]
    );
  }

}
