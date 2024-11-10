import 'package:flutter/material.dart';

class SupplierResponse {
  final String id;
  final String name;
  final TypeOfSupplier type;
  final String? cif;
  final String? tel;
  final String? contactName;
  final String? phone;

  SupplierResponse({
    required this.id,
    required this.name,
    required this.type,
    this.cif,
    this.tel,
    this.contactName,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'tel': tel,
      'contactName': contactName,
      'phone': phone,
    };
  }

  factory SupplierResponse.fromMap(Map<String, dynamic> map) {
    return SupplierResponse(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: TypeOfSupplier.values.byName(map['type'] ?? 'consumer'),
      cif: map['cif'],
      tel: map['tel'],
      contactName: map['contactName'],
      phone: map['phone'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupplierResponse &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  SupplierResponse copyWith({
    String? id,
    String? name,
    TypeOfSupplier? type,
    String? cif,
    String? tel,
    String? contactName,
    String? phone,
  }) {
    return SupplierResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      cif: cif ?? this.cif,
      tel: tel ?? this.tel,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
    );
  }
}

enum TypeOfSupplier {
  consumer,
  food,
  drink,
  taxes,
  meats,
  ice_cream,
  utilities,
  services;

  IconData get getIconData => switch (this) {
        consumer => Icons.miscellaneous_services_outlined,
        food => Icons.fastfood_outlined,
        drink => Icons.liquor_outlined,
        taxes => Icons.attach_money,
        meats => Icons.food_bank_outlined,
        ice_cream => Icons.icecream_outlined,
        utilities => Icons.lightbulb_outline,
        services => Icons.room_service_outlined,
      };
}
