// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    timeToComplete: json['timeToComplete'] as int,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'timeToComplete': instance.timeToComplete,
    };

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    DateTime.parse(json['start'] as String),
    DateTime.parse(json['end'] as String),
    Product.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'product': instance.product,
    };
