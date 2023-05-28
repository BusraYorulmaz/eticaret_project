import 'package:flutter/material.dart';
import '../pages/adminPages/adminPage.dart';
import '../pages/adminPages/admin_login.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[buildHeader(context), buildMenuItems(context)],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Material(
        color: Colors.deepPurple,
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                  //resimler ve buradaki bilgiler veri tabanından çekilecek şuan tasarım yapıldı
                  'https://www.wpdurum.com/uploads/thumbs/anime-kiz-profil-resimleri-1.jpg',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Büşra Yorulmaz',
                style: TextStyle(fontSize: 28, color: Colors.amber),
              ),
              Text(
                'busrayorulmaz42@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.amberAccent),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16, //vertical sapcing
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title:const Text("Home"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AdminPage(),
                ));
              },
            ),
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back_sharp),
              title:const Text("out"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AdminUserPages(),
                ));
              },
            ),
          ],
        ),
      );
}
