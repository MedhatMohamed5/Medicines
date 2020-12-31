import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../models/medicine.dart';

class MedicinesProvider extends ChangeNotifier {
  List<Medicine> _items = [];

  List<Medicine> get items {
    return [..._items];
  }

  void setItems(List<Medicine> medicines) {
    _items = [...medicines];
    notifyListeners();
  }

  void addToItems(Map<String, dynamic> medicine) {
    try {
      if (_items.indexWhere((item) => item.id == medicine['id']) < 0) {
        _items.add(Medicine.fromJson(medicine));
        _items.sort(
            (medicine1, medicine2) => medicine1.name.compareTo(medicine2.name));
        // notifyListeners();
      }
      /*_items.forEach((element) {
        print('${element.id} - ${element.name}');
      });*/
    } catch (e) {
      print(e);
    }
  }

  Medicine findById(String id) {
    return _items.firstWhere((medicine) => medicine.id == id);
  }

  Stream<QuerySnapshot> fetchMedicines([bool filterByUser = false]) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final response = filterByUser
        ? FirebaseFirestore.instance
            .collection(Medicine.kMedicine)
            .where('createdById', isEqualTo: currentUser.uid)
            .orderBy('name')
            .snapshots()
        : FirebaseFirestore.instance
            .collection(Medicine.kMedicine)
            .orderBy('name')
            .snapshots();

    return response;
  }

  /*void addItemToList(Medicine medicine) {
    _items.add(medicine);
  }*/

  Future<void> addMedicine(Map<String, dynamic> data) async {
    try {
      final medicineId = await FirebaseFirestore.instance
          .collection(Medicine.kMedicine)
          .add(data);

      data['id'] = medicineId.id;

      /*_items.add(Medicine.fromMap(data));

      _items.sort(
          (medicine1, medicine2) => medicine1.name.compareTo(medicine2.name));*/

      notifyListeners();
    } catch (err) {
      print('An error occred $err');
    }
  }

  Future<void> editMedicine(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection(Medicine.kMedicine)
          .doc(id)
          .set(data);

      var medicine = _items.firstWhere((item) => item.id == id);
      _items.removeWhere((item) => item.id == id);

      medicine = medicine.copyWith(
        name: data['name'],
        description: data['description'],
        consumerPrice: data['consumerPrice'],
        listPrice: data['listPrice'],
        modifiedAt: data['modifiedAt'],
        modifiedById: data['modifiedById'],
        modifiedByName: data['modifiedByName'],
        qty: data['qty'],
        imageUrl: data['imageUrl'],
      );
      _items.add(medicine);
      _items.sort(
          (medicine1, medicine2) => medicine1.name.compareTo(medicine2.name));
      //_items.sort()
      notifyListeners();
    } catch (err) {
      print('An error occred $err');
    }
  }
}
