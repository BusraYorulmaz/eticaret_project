import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            child: Text(
              'Happy Shop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Ana Sayfa'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Kategoriler'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
