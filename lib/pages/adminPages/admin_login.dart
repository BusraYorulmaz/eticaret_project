import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eticaret_project/pages/adminPages/adminPage.dart';
import 'package:eticaret_project/pages/splashPages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';

class AdminUserPages extends StatefulWidget {
  const AdminUserPages({Key? key}) : super(key: key);

  @override
  State<AdminUserPages> createState() => _AdminUserPagesState();
}

class _AdminUserPagesState extends State<AdminUserPages> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool sifre_gozukme = true;

//giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    await FirebaseFirestore.instance
        .collection("Admin")
        .doc("adminLogin")
        .snapshots()
        .forEach((element) {
      if (element.data()?['adminEmail'] == _emailController.text &&
          element.data()?['adminPassword'] == _passwordController.text) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => AdminPage())),
            (route) => false);
      } else {
        debugPrint("\n email yada şifre hatali");
        warningPopup(hataMetni: "hatali".tr); // Navigator.pushAndRemoveUntil(

      }
    });
  }

  Future warningPopup({required String hataMetni}) => showDialog(
        context: context,
        builder: ((context) => SimpleDialog(
              title: Text(
                'hata'.tr,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              children: <Widget>[
                Text(
                  hataMetni //'Email address is already in use by another account.\n Try again with another email address.'
                  ,
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'okey'.tr,
                      style: const TextStyle(color: Colors.red),
                    )),
              ],
            )),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              //appbar ikon ve yönlendirme
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreenWidget(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back),
            );
          }),
          title: Text('adminPanel'.tr),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'adminLogin'.tr,
                      style: const TextStyle(
                          color: Colors.deepPurple, fontSize: 32),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController, //email kontrolü
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                        labelText: 'eposta'.tr,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: sifre_gozukme,
                            controller: _passwordController, //şifre kontrolü

                            cursorColor: Colors.pink,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.key),
                              border: const OutlineInputBorder(),
                              labelText: 'password'.tr,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              sifre_gozukme = !sifre_gozukme;
                            });
                          },
                          icon: Icon(sifre_gozukme
                              ? Icons.remove_red_eye
                              : Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      child: Text(
                        'enter'.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        signIn(_emailController.text, _passwordController.text)
                            .then((value) {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
