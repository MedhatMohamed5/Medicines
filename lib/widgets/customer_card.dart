import 'package:Medicines/providers/customers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerCard extends StatelessWidget {
  final Key key;
  final String customerId;
  CustomerCard({this.key, this.customerId});
  @override
  Widget build(BuildContext context) {
    final customer =
        Provider.of<CustomersProvider>(context).findById(customerId);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customerName('${customer.name} - ${customer.phone}'),
                const SizedBox(
                  height: 8,
                ),
                _customerBalance(context, '${customer.balanceAmt}'),
              ],
            ),
          ),
        ),
        elevation: 2,
      ),
    );
  }

  Text _customerName(String name) {
    return Text(
      '$name',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  _customerBalance(BuildContext context, String balance) {
    return Text(
      'Balance: $balance',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: double.parse(balance) < 0
            ? Colors.red
            : Theme.of(context).primaryColor,
      ),
    );
  }
}
