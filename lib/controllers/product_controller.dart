import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eticaret_project/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final CollectionReference _product =
    FirebaseFirestore.instance.collection("urun");
final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

class product_controller {
  String? mediaUrl;

  //isim kontrolü
  Future<bool> checkIfDataExists(String isim) async {
    bool exists = false;
    var querySnapShot = await _product.where('isim', isEqualTo: isim).get();
    if (querySnapShot.docs.isNotEmpty) {
      exists = true;
    }
    return exists;
  }
  //isim var ise adet i artır.
  Future<void> increaseAdetIfExists(String isim, int adetArtis) async{
    var querySnapshot = await _product.where('isim', isEqualTo: isim).get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      var existingAdet = documentSnapshot['adet'] ?? '0' ;
      var edit= int.parse(existingAdet);
      var updateAdet = (edit +adetArtis).toString();
      await documentSnapshot.reference.update({'adet':updateAdet});
    }
  }

  Map<String, dynamic> add_data(product_model model) {
    return {
      "isim": model.isim,
      "kategori": model.kategori,
      "size1": model.size,
      "adet": model.adet,
      "fiyat": model.fiyat,
      "image": mediaUrl
    };
  }

  // add data to firebase
  Future add_product(product_model product, PickedFile pickedFile, int adetMik) async {
    bool exists = await checkIfDataExists(product.isim);
    if (exists) {
      print("var olan kayıt");
    await increaseAdetIfExists(product.isim,adetMik);
    } else {
      if (pickedFile == null) {
        mediaUrl = '';
      } else {
        mediaUrl = await uploadMedia(File(pickedFile.path));
      }
      await _product.doc().set(add_data(product));
    }
  }

  //Resim Ekleme
  uploadMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().microsecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    var storageRef = await uploadTask.whenComplete(() => null);
    return await storageRef.ref.getDownloadURL();
  }

  //update data
  Future update_product(product_model product, PickedFile pickedFile) async {
    if (pickedFile == null) {
      mediaUrl = '';
    } else {
      mediaUrl = await uploadMedia(File(pickedFile.path));
    }
    await _product.doc(product.id).update(add_data(product));
  }

  //delete data
  Future delete_product(product_model product) async {
    await _product.doc(product.id).delete();
  }
}
