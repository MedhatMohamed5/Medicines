import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth.dart';
import '../widgets/app_drawer.dart';
import './customers_screen.dart';
import './medicines_screen.dart';
import './orders_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userId;

  HomeScreen(this.userId, this.userName);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'page': MedicinesScreen(),
      'title': 'Medicines',
    },
    {
      'page': CustomersScreen(),
      'title': 'Customers',
    },
    {
      'page': OrdersScreen(),
      'title': 'Orders',
    },
  ];

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Medicines - ${widget.userName.split(' ')[0]}',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.medical_services),
            label: 'Medicines',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person_pin_circle),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.album),
            label: 'Orders',
          ),
        ],
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
