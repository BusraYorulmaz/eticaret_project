import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../controllers/product_controller.dart';
import '../../model/product_model.dart';
import 'add_or_edit_product.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
    required CollectionReference<Object?> urun,
  })  : _urun = urun,
        super(key: key);

  final CollectionReference<Object?> _urun;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey.shade100,
            height: height,
            child: StreamBuilder(
              stream: widget._urun.snapshots(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot records =
                          snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  final product = product_model(
                                    id: records.id,
                                    isim: records["isim"],
                                    fiyat: records["fiyat"],
                                    adet: records["adet"],
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (((context) => ManageProduct(
                                                product: product,
                                                index: index,
                                              )))));
                                },
                                icon: Icons.edit_note,
                                backgroundColor: Colors.blue,
                              )
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  product_controller().delete_product(
                                      product_model(id: records.id));
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 10,
                              child: ListTile(
                                tileColor: Colors.transparent,
                                title: Text(
                                  "Urun Adı: " + records["isim"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Resim
                                        CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(records['image']),
                                          radius: height * 0.06,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Fiyat: " + records["fiyat"] + "₺"),
                                        Text(records["size1"] +
                                            " - " +
                                            records["adet"].toString() +
                                            " Adet"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(records["kategori"] +
                                            " Kategorisi"),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (records["sizes"] == null ||
                                                records["sizes"].isEmpty)
                                              const Text("Tek beden mevcuttur.")
                                            else
                                              Column(
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          records["sizes"]
                                                              .length;
                                                      i++)
                                                    Text(
                                                      records["sizes"][i]
                                                              ["size1"] +
                                                          " - " +
                                                          records["sizes"][i]
                                                                  ["adet"]
                                                              .toString() +
                                                          " Adet",
                                                    ),
                                                ],
                                              ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
