import 'package:flutter/material.dart';
import 'package:library_app/widgets/left_drawer.dart';
import 'package:library_app/widgets/menu_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<MenuItem> menuItems = [
    MenuItem("Lihat Item", Icons.checklist, Colors.teal.shade700),
    MenuItem("Tambah Item", Icons.add_circle_outline, Colors.teal.shade800),
    MenuItem("Logout", Icons.logout, Colors.teal.shade900),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text(
          style: TextStyle(color: Colors.white),
          'Library Management System',
        ),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Bookshelf', // Text yang menandakan bookshelf
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: menuItems.map((MenuItem menuItem) {
                  // Iterasi untuk setiap MenuItem
                  return MenuCard(menuItem);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final IconData icon;
  final Color color;

  MenuItem(this.name, this.icon, this.color);
}
