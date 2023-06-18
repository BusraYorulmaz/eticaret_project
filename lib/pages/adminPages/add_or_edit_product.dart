import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eticaret_project/controllers/product_controller.dart';
import 'package:eticaret_project/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/mytextfield.dart';

class ManageProduct extends StatefulWidget {
  final product_model? product;
  final index;
  const ManageProduct({this.product, this.index});

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _form_key = GlobalKey<FormState>();
  bool iseditingmode = false;

  final TextEditingController id = TextEditingController();
  final TextEditingController isim = TextEditingController();
  final TextEditingController fiyat = TextEditingController();
  final TextEditingController adet = TextEditingController();

  final List<String> categories = ["Ayakkabılar", "Kıyafetler"];
  final List<String> shoeSized = [
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44'
  ];
  final List<String> bodySized = [
    'XSmall',
    'Small',
    'Medium',
    'Large',
    'XLarge',
    'XX Large'
  ];
  String? selectedBodyorShoe;
  String? selectedSize;
  List<String> size = [];

  /// resim
  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  PickedFile? productImage;

  imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (productImage != null) {
      return CircleAvatar(
        backgroundImage: FileImage(File(productImage!.path)),
        radius: height * 0.05,
      );
    } else {
      if (_pickImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage(_pickImage),
          radius: height * 0.05,
        );
      } else {
        return CircleAvatar(
          backgroundImage: const AssetImage("assets/images/happyShop.png"),
          radius: height * 0.05,
        );
      }
    }
  }

  @override
  void initState() {
    if (widget.index != null) {
      iseditingmode = true;
      id.text = widget.product?.id;
      isim.text = widget.product?.isim;
      fiyat.text = widget.product?.fiyat;
      adet.text = widget.product?.adet;
      selectedBodyorShoe = widget.product?.kategori;
      selectedSize = widget.product?.size;
    } else {
      iseditingmode = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8E8EE),
      appBar: AppBar(
          title: iseditingmode == true
              ? const Text("Editing Product")
              : const Text("Add products")),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
                child: iseditingmode == true
                    ? const Text(
                        "Edit Product",
                        style: TextStyle(fontSize: 28),
                      )
                    : const Text(
                        "Add Product",
                        style: TextStyle(fontSize: 28),
                      )),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _form_key,
                child: Column(children: [
                  MyTextField(
                      hintedtext: "product name",
                      labledtext: "Name",
                      mycontroller: isim),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintedtext: "product fiyat",
                      labledtext: "Fiyat",
                      mycontroller: fiyat),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintedtext: "product adet",
                      labledtext: "Adet",
                      mycontroller: adet),
                  const SizedBox(height: 15),

                  //Resim Ekleme
                  imagePlace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Resim Ekle"),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => _onImageButtonPress(ImageSource.gallery,
                            context: context),
                        child: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),

                  // kategori seçimi
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text("Kategori Seçiniz"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedBodyorShoe,
                      items: categories.map((e) {
                        return DropdownMenuItem<String>(
                            value: e, child: Text('$e'));
                      }).toList(),
                      onChanged: ((value) {
                        selectedSize = null;
                        size = value == "Kıyafetler" ? bodySized : shoeSized;
                        setState(() {
                          selectedBodyorShoe = value;
                        });
                      }),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Beden Seçiniz")),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedSize,
                      items: size.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text('$e'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSize = value;
                        });
                      },
                    ),
                  )
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_form_key.currentState!.validate()) {
                    if (iseditingmode == true) {
                      product_controller()
                          .update_product(
                              product_model(
                                  id: id.text,
                                  fiyat: fiyat.text,
                                  isim: isim.text,
                                  adet: adet.text,
                                  kategori: selectedBodyorShoe,
                                  size: selectedSize,
                                  image: productImage),
                              productImage!)
                          .then((value) {
                        Fluttertoast.showToast(msg: "Ürün Güncellendi");
                      });
                    } else {
                      product_controller()
                          .add_product(
                        product_model(
                          fiyat: fiyat.text,
                          isim: isim.text,
                          adet: adet.text,
                          kategori: selectedBodyorShoe,
                          size: selectedSize,
                          image: productImage,
                        ),
                        productImage!,
                        int.parse(adet.text),
                      )
                          .then((value) {
                        Fluttertoast.showToast(msg: "Ürün Eklendi");
                      });
                    }
                    Navigator.pop(context);
                  }
                },
                child: iseditingmode == true
                    ? const Text("Update")
                    : const Text("Save"))
          ],
        )),
      ),
    );
  }

  void _onImageButtonPress(ImageSource source, {BuildContext? context}) async {
    try {
      final PickedFile = await _pickerImage.getImage(source: source);
      setState(() {
        productImage = PickedFile;
        print("resim ekleme");
        if (productImage != null) {}
      });
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Hatamız" + _pickImage);
      });
    }
  }
}
