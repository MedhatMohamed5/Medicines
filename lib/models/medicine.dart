import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Medicine {
  static const kMedicine = 'medicines';

  final Timestamp createdAt, modifiedAt;
  final String createdById, createdByName;
  final String modifiedById, modifiedByName;

  final String id;
  final String name;
  final String description;
  final String imageUrl;

  final double listPrice, consumerPrice;
  final double qty, soldQty;
  final double soldAmount;

  const Medicine({
    @required this.id,
    @required this.name,
    @required this.listPrice,
    @required this.consumerPrice,
    @required this.qty,
    this.soldQty = 0.0,
    this.soldAmount = 0.0,
    this.description = '',
    this.imageUrl = '',
    this.createdAt,
    this.createdById = '',
    this.createdByName = '',
    this.modifiedAt,
    this.modifiedById = '',
    this.modifiedByName = '',
  });

  Medicine copyWith({
    String id,
    String name,
    double listPrice,
    double consumerPrice,
    double qty,
    double soldQty,
    double soldAmount,
    String description,
    String imageUrl,
    Timestamp createdAt,
    String createdById,
    String createdByName,
    Timestamp modifiedAt,
    String modifiedById,
    String modifiedByName,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      listPrice: listPrice ?? this.listPrice,
      consumerPrice: consumerPrice ?? this.consumerPrice,
      qty: qty ?? this.qty,
      soldQty: soldQty ?? this.soldQty,
      soldAmount: soldAmount ?? this.soldAmount,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      createdById: createdById ?? this.createdById,
      createdByName: createdByName ?? this.createdByName,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      modifiedById: modifiedById ?? this.modifiedById,
      modifiedByName: modifiedByName ?? this.modifiedByName,
    );
  }

  factory Medicine.fromMap(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] ?? '',
      name: json['name'],
      listPrice: double.parse(json['listPrice'].toString()),
      consumerPrice: double.parse(json['consumerPrice'].toString()),
      qty: double.parse(json['qty'].toString()),
      soldQty: double.parse(json['soldQty'].toString()),
      soldAmount: double.parse(json['soldAmount'].toString()) ?? 0.0,
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'],
      createdById: json['createdById'],
      createdByName: json['createdByName'],
      modifiedAt: json['modifiedAt'],
      modifiedById: json['modifiedById'],
      modifiedByName: json['modifiedByName'],
    );
  }
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] ?? '',
      name: json['name'],
      listPrice: json['listPrice'],
      consumerPrice: json['consumerPrice'],
      qty: json['qty'],
      soldQty: json['soldQty'],
      soldAmount: json['soldAmount'] ?? 0.0,
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'],
      createdById: json['createdById'],
      createdByName: json['createdByName'],
      modifiedAt: json['modifiedAt'],
      modifiedById: json['modifiedById'],
      modifiedByName: json['modifiedByName'],
    );
  }
}
