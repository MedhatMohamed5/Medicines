import 'package:Medicines/providers/medicines_provider.dart';
import 'package:Medicines/widgets/medicine_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<MedicinesProvider>(context).fetchMedicines(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasError)
          return Center(
            child: Text('Something went wrong! please try again later!'),
          );

        final medicineDocs = snapshot.data.docs;

        return ListView.builder(
          itemBuilder: (ctx, index) {
            Map<String, dynamic> medicineMap = medicineDocs[index].data();

            Provider.of<MedicinesProvider>(context, listen: false).addToItems(
              {
                'id': medicineDocs[index].id,
                'name': medicineMap['name'],
                'listPrice': medicineMap['listPrice'],
                'consumerPrice': medicineMap['consumerPrice'],
                'qty': medicineMap['qty'],
                'soldQty': medicineMap['soldQty'],
                'soldAmount': medicineMap['soldAmount'] ?? 0.0,
                'description': medicineMap['description'] ?? '',
                'imageUrl': medicineMap['imageUrl'] ?? '',
                'createdAt': medicineMap['createdAt'],
                'createdById': medicineMap['createdById'],
                'createdByName': medicineMap['createdByName'],
                'modifiedAt': medicineMap['modifiedAt'],
                'modifiedById': medicineMap['modifiedById'],
                'modifiedByName': medicineMap['modifiedByName'],
              },
            );
            final medicine =
                Provider.of<MedicinesProvider>(context, listen: false)
                    .items[index];

            return MedicineCard(
              key: ValueKey(medicine.id),
              medicine: medicine,
            );
          },
          itemCount: medicineDocs.length,
        );
      },
    );
  }
}
