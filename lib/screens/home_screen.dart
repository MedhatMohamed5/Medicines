import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  final String userId;

  HomeScreen(this.userId, this.userName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Provider.of<Auth>(context, listen: false).signOut();
        },
      ),
      appBar: AppBar(
        title: Text('Medicines - ${userName ?? "Medhat"}'),
        actions: [],
      ),
    );
  }
}
