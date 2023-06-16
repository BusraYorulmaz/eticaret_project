import 'package:flutter/cupertino.dart';

class product_model {
  final id, isim, kategori,
  adet,size, fiyat, image;
  final List<SizeData>? sizes;

  product_model(
      {this.id, 
      this.isim, 
      this.kategori,
      this.adet, 
      this.size,  
      this.sizes, 
      this.fiyat, 
      this.image});
}

class SizeData {
  final String size1;
  final int adet;

  SizeData(this.size1, this.adet);
}
