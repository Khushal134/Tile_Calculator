import 'package:flutter/material.dart';
import 'package:tile_calculator/calculate.dart';
import 'package:tile_calculator/logout.dart';
import 'package:tile_calculator/room.dart';
import 'package:tile_calculator/update.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: home(),
      ),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _selected = 0;

  List<Widget> _list = [
    room(),
    calculate(),
    ProfileUpdatePage(),
    logout(),
  ];

  void _tapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selected,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calculate,
              ),
              label: 'Tiles Calculation',
              tooltip: 'Tiles Calculation'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
              tooltip: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: 'Logout',
            tooltip: 'Logout',
          ),
        ],
        currentIndex: _selected,
        onTap: _tapped,
      ),
    );
  }
}
