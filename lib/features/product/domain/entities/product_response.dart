import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/di/inject.dart';
import '../../../../core/data/db_services/firebase_services.dart';
import '../../../suplier/domain/entities/suplier_response.dart';

class ProductResponse {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double packaging;
  final String measure;
  final double pricePacking;
  final double priceUnit;
  final double iva;
  final double pricePlusIVA;
  final DocumentReference<SupplierResponse>? lastSupplier;

  ProductResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.packaging,
    required this.measure,
    required this.pricePacking,
    required this.priceUnit,
    required this.iva,
    required this.pricePlusIVA,
    this.lastSupplier,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'packaging': packaging,
      'measure': measure,
      'pricePacking': pricePacking,
      'priceUnit': priceUnit,
      'iva': iva,
      'pricePlusIVA': pricePlusIVA,
      'lastSupplier': lastSupplier,
    };
  }

  factory ProductResponse.fromMap(Map<String, dynamic> map) {
    return ProductResponse(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      packaging: (map['packaging'] ?? 0).toDouble(),
      measure: map['measure'] ?? '',
      pricePacking: (map['pricePacking'] ?? 0).toDouble(),
      priceUnit: (map['priceUnit'] ?? 0).toDouble(),
      iva: (map['iva'] ?? 0).toDouble(),
      pricePlusIVA: (map['pricePlusIVA'] ?? 0).toDouble(),
      lastSupplier: map['lastSupplier'] != null
          ? getIt<FirebaseServices>().suppliers.doc(map['lastSupplier'].id)
          : null,
    );
  }

  ProductResponse copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? packaging,
    String? measure,
    double? pricePacking,
    double? priceUnit,
    double? iva,
    double? pricePlusIVA,
    DocumentReference<SupplierResponse>? lastSupplier,
  }) {
    return ProductResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      packaging: packaging ?? this.packaging,
      measure: measure ?? this.measure,
      pricePacking: pricePacking ?? this.pricePacking,
      priceUnit: priceUnit ?? this.priceUnit,
      iva: iva ?? this.iva,
      pricePlusIVA: pricePlusIVA ?? this.pricePlusIVA,
      lastSupplier: lastSupplier ?? this.lastSupplier,
    );
  }
}
