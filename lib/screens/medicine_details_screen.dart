import 'package:Medicines/models/medicine.dart';
import 'package:Medicines/providers/medicines_provider.dart';
import 'package:Medicines/screens/edit_medicine_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineDetailsScreen extends StatelessWidget {
  static const routeName = '/medicine-details';

  @override
  Widget build(BuildContext context) {
    final medicineId = ModalRoute.of(context).settings.arguments as String;

    final loadedMedicine =
        Provider.of<MedicinesProvider>(context).findById(medicineId);

    return Scaffold(
      //appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(loadedMedicine, context),
          _buildSliverList(loadedMedicine),
        ],
      ),
    );
  }

  SliverList _buildSliverList(Medicine loadedMedicine) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              loadedMedicine.description,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 24,
              ),
            ),
          ),
          _detailRow(
            'Consumer Price',
            loadedMedicine.consumerPrice.toStringAsFixed(2),
          ),
          _detailRow(
            'List Price',
            loadedMedicine.listPrice.toStringAsFixed(2),
          ),
          _detailRow(
            'Available Quantity',
            loadedMedicine.qty.toStringAsFixed(2),
            loadedMedicine.qty <= 4 ? Colors.red : Colors.black,
          ),
          _detailRow(
            'Sold Amount',
            loadedMedicine.soldAmount.toStringAsFixed(2),
          ),
          _detailRow(
            'Sold Quantity',
            loadedMedicine.soldQty.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String title, String value, [Color color = Colors.black]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$title:',
              style: TextStyle(
                color: color,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '$value',
              softWrap: true,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(
      Medicine loadedMedicine, BuildContext context) {
    return SliverAppBar(
      pinned: true,
      // snap: true,
      // floating: true,
      centerTitle: true,
      title: Text(
        loadedMedicine.name,
        overflow: TextOverflow.ellipsis,
      ),
      expandedHeight: loadedMedicine.imageUrl != ''
          ? MediaQuery.of(context).size.height * 0.4
          : AppBar().preferredSize.height,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).pushNamed(
              EditMedicineScreen.routeName,
              arguments: loadedMedicine.id,
            );
          },
        ),
      ],
      flexibleSpace: loadedMedicine.imageUrl != ''
          ? FlexibleSpaceBar(
              background: Hero(
                tag: loadedMedicine.id,
                child: Image.network(
                  loadedMedicine.imageUrl,
                  fit: BoxFit.fitHeight,
                  scale: 0.5,
                  loadingBuilder: (ctx, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : 1,
                      ),
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}
