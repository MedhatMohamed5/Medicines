import 'package:Medicines/screens/edit_medicine_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Hello ${auth.userName}!',
              overflow: TextOverflow.ellipsis,
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.of(context).pushNamed(EditMedicineScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Sign out'),
            onTap: () {
              Navigator.of(context).pop();
              auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
