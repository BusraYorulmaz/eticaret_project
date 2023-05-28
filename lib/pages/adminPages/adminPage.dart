import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eticaret_project/pages/adminPages/add_or_edit_product.dart';
import 'package:eticaret_project/pages/adminPages/product_list.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final CollectionReference _urun =
      FirebaseFirestore.instance.collection("urun");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const ManageProduct())));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Ürün listesi"),
        centerTitle: true,
      ),
      body: ProductList(urun: _urun),
    );
  }
}
