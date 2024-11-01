import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryResponse {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String creator;

  CategoryResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.creator,
  });

  CategoryResponse copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? creator,
  }) {
    return CategoryResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      creator: creator ?? this.creator,
    );
  }

  factory CategoryResponse.fromMap(Map<String, dynamic> map) {
    return CategoryResponse(
      id: map['id'] as String,
      name: map['name'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      creator: map['creator'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'creator': creator,
    };
  }
}
