import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/splashPages/splash_screen.dart';
import '../pages/userPages/base_view.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BaseView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Kategoriler'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back),
            title: const Text("Out"),
            onTap: () {
              signOutUser();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreenWidget(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void signOutUser() async {
    await _auth.signOut();
    debugPrint("Log Out");
  }
}
