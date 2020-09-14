import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storage.g.dart'; // this is the destination file for json_serializable code-gen


const productString = "products";
const openAppointmentsString = "open_appointments";
const bookedAppointmentsString = "booked_appointments";

//Representing the connection to server (or in this demo the phone storage)
class ShopState {


  SharedPreferences sharedPreferences;
  static ShopState _state;
  List<Product> _products;
  List<DateTime> _openAppointments;
  List<Appointment> _bookedAppointments;

  factory ShopState(sharedPreferences) {
    if (_state == null) {
      _state = ShopState._internal(sharedPreferences);
    }

    _state.reloadProducts();
    _state.reloadAppointments();

    return _state;
  }

  static ShopState get state {
    return _state;
  }

  static List<Product> get products {
    return _state._products;
  }

  static List<DateTime> get openAppointments {
    return _state._openAppointments;
  }

  static List<Appointment> get bookedAppointments {
    return _state._bookedAppointments;
  }

  ShopState._internal(this.sharedPreferences);

  void reloadProducts() {
    var str = sharedPreferences.getString(productString) ?? "[]";
    var productMap = (json.decode(str) as List);
    _products = productMap
        .where((data) => data != null && data.isNotEmpty)
        .map((data) => Product.fromJson(data))
        .toList();
  }

  void reloadAppointments() {
    {
      var openString = sharedPreferences.getString(openAppointmentsString) ?? "[]";
      var openAppointments = (json.decode(openString) as List);
      _openAppointments = openAppointments
          .where((data) => data != null && data.isNotEmpty)
          .map((data) => DateTime.parse(data))
          .toList();
    }

    {
      var bookString = sharedPreferences.getString(bookedAppointmentsString) ?? "[]";
      var bookedAppointments = (json.decode(bookString) as List);
      _bookedAppointments = bookedAppointments
          .where((data) => data != null && data.isNotEmpty)
          .map((data) => Appointment.fromJson(data))
          .toList();
    }
  }

  void saveNewProduct(Product p) {
    _products.add(p);
    sharedPreferences.setString(productString, json.encode(_products));
  }

  void saveOpenAppointments(){
    var strList = _openAppointments.map((app) => app.toString()).toList();
    sharedPreferences.setString(openAppointmentsString, json.encode(strList));
  }


  void saveNewOpenAppointment(DateTime dt) {
    _openAppointments.add(dt);
    saveOpenAppointments();
  }

  void saveBookingFor(Appointment a) {
    print("remove successful ${_openAppointments.remove(a.start)}");
    _bookedAppointments.add(a);
    sharedPreferences.setString(bookedAppointmentsString, json.encode(_bookedAppointments));
  }
  
}

@JsonSerializable(nullable: false)
class Product {
  String name;
  double price;
  int timeToComplete;

  Product({this.name, this.price, this.timeToComplete});
  String toString(){
    return "$name \$$price ($timeToComplete minutes)";
  }
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

}

@JsonSerializable(nullable: false)
class Appointment {
  final DateTime start;
  final DateTime end;
  final Product product;
  //TODO add link back to user associated with an appointment
  Appointment(this.start, this.end, this.product);

  String toString() {
    return start.toString() + " - "+ end.toString() +" "+ product.toString();
  }
  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}