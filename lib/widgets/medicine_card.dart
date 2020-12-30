import 'package:Medicines/models/medicine.dart';
import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final Key key;
  MedicineCard({this.key, @required this.medicine});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: InkWell(
          onTap: () {},
          splashColor: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // child: Text('${medicine.name} - ${medicine.id}'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: _medicineImage(),
                  flex: 2,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _medicineName(),
                      const SizedBox(
                        height: 8,
                      ),
                      _medicinePriceQty(context),
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

  Widget _medicinePriceQty(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  Text _medicineName() {
    return Text(
      '${medicine.name}',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Container _medicineImage() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: medicine.imageUrl != ''
              ? NetworkImage(
                  medicine.imageUrl,
                  scale: .5,
                )
              : AssetImage(
                  'assets/images/medical.png',
                ),
          fit: BoxFit.cover,
        ),
      ),
      // child: Text('1'),
    );
  }
}
