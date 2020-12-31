import 'package:Medicines/providers/customers_provider.dart';
import 'package:Medicines/widgets/customer_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<CustomersProvider>(context).fetchCustomers(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasError)
          return Center(
            child: Text('Something went wrong! please try again later!'),
          );

        final customersDocs = snapshot.data.docs;

        return ListView.builder(
          itemBuilder: (ctx, index) {
            Map<String, dynamic> customerMap = customersDocs[index].data();

            Provider.of<CustomersProvider>(context, listen: false).addToItems(
              {
                'id': customersDocs[index].id,
                'name': customerMap['name'],
                'phone': customerMap['phone'],
                'balanceAmt': customerMap['balanceAmt'],
                'paidAmt': customerMap['paidAmt'],
                'purchasedAmt': customerMap['purchasedAmt'],
              },
            );

            return CustomerCard(
              key: ValueKey(customersDocs[index].id),
              customerId: customersDocs[index].id,
            );
          },
          itemCount: customersDocs.length,
        );
      },
    );
  }
}
