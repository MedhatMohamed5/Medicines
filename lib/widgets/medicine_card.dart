import 'package:Medicines/models/medicine.dart';
import 'package:Medicines/providers/medicines_provider.dart';
import 'package:Medicines/screens/medicine_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineCard extends StatelessWidget {
  final Key key;
  final String medicineId;
  MedicineCard({this.key, this.medicineId});
  @override
  Widget build(BuildContext context) {
    final Medicine medicine =
        Provider.of<MedicinesProvider>(context).findById(medicineId);
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              MedicineDetailsScreen.routeName,
              arguments: medicine.id,
            );
          },
          splashColor: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // child: Text('${medicine.name} - ${medicine.id}'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: _medicineImage(medicine.imageUrl),
                  flex: 2,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _medicineName(medicine.name),
                      const SizedBox(
                        height: 8,
                      ),
                      _medicinePriceQty(context, medicine),
                    ],
                  ),
                  flex: 7,
                ),
              ],
            ),
          ),
        ),
        elevation: 2,
      ),
    );
  }

  Widget _medicinePriceQty(BuildContext context, Medicine medicine) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Price: ${medicine.consumerPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            'Av. Qty: ${medicine.qty.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              color: medicine.qty <= 4
                  ? Colors.red
                  : Theme.of(context).primaryColorDark,
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }

  Text _medicineName(String name) {
    return Text(
      '$name',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Container _medicineImage(String imageUrl) {
    return Container(
      height: 64,
      child: imageUrl != ''
          ? Center(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (ctx, _, __) => _placeholderImage(),
                progressIndicatorBuilder: (ctx, _, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress != null ? progress.progress : 1,
                    ),
                  );
                },
              ),
            )
          : _placeholderImage(),
    );
  }

  Widget _placeholderImage() => Image.asset(
        'assets/images/medical.png',
        frameBuilder: (_, child, ___, __) {
          return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: child));
        },
      );
}
