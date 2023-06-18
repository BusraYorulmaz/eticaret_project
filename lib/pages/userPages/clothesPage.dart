import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ClothesPage extends StatefulWidget {
  const ClothesPage({super.key});

  @override
  State<ClothesPage> createState() => _ClothesPageState();
}

class _ClothesPageState extends State<ClothesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF8E8EE),
        appBar: AppBar(
          title: const Text("Kıyafetler"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('urun').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final documents = snapshot.data!.docs;
              final kiyafetDocuments = documents
                  .where((document) => document['kategori'] == 'Kıyafetler')
                  .toList();

              return ListView(
                children: [
                  _buildCategoryList('Kıyafet', kiyafetDocuments),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Widget _buildCategoryList(
    String category, List<QueryDocumentSnapshot> documents) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          category,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.78,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final document = documents[index];
          final adet = document['adet'];
          final fiyat = document['fiyat'];
          final image = document['image'];
          final kategori = document['kategori'];
          final size = document['size1'];
          final isim = document['isim'];

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 4),
                        child: Banner(
                          message: fiyat + " ₺",
                          location: BannerLocation.bottomStart,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(image, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 2, bottom: 0),
                      child: Column(
                        children: [
                          Text(isim),
                          Text("Size: " + size),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text("Sepete Ekle"),
                        style: ElevatedButton.styleFrom(
                            maximumSize: const Size(double.infinity, 36),
                            minimumSize: const Size(double.infinity, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: -10,
                right: -8,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ]),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white70,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    ],
  );
}
