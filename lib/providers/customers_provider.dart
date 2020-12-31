import 'package:Medicines/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CustomersProvider extends ChangeNotifier {
  List<Customer> _customers = [];

  List<Customer> get customers {
    return [..._customers];
  }

  void addToItems(Map<String, dynamic> customer) {
    try {
      if (_customers.indexWhere((item) => item.id == customer['id']) < 0) {
        _customers.add(Customer.fromMap(customer));
        _customers.sort(
            (customer1, customer2) => customer1.name.compareTo(customer2.name));
        // notifyListeners();
      }

      _customers.forEach((element) {
        print('${element.id} - ${element.name}');
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> fetchCustomers() {
    return FirebaseFirestore.instance
        .collection(Customer.kCustomer)
        .orderBy('name')
        .snapshots();
  }

  Customer findById(String id) {
    return _customers.firstWhere((customer) => customer.id == id);
  }

  Future<void> addCustomer(Map<String, dynamic> data) async {
    try {
      final customerId = await FirebaseFirestore.instance
          .collection(Customer.kCustomer)
          .add(data);

      notifyListeners();
    } catch (err) {
      print('An error occred $err');
    }
  }
}
