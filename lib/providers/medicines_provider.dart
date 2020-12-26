import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../models/medicine.dart';

class MedicinesProvider extends ChangeNotifier {
  List<Medicine> _items = [];
  List<Medicine> get items {
    return [..._items];
  }

  Medicine findById(String id) {
    return _items.firstWhere((medicine) => medicine.id == id);
  }

  Future<void> addMedicine(Map<String, dynamic> data) async {
    try {
      final medicineId = await FirebaseFirestore.instance
          .collection(Medicine.kMedicine)
          .add(data);

      data['id'] = medicineId.id;

      _items.add(Medicine.fromMap(data));

      notifyListeners();
    } catch (err) {
      print('An error occred $err');
    }
  }
}
