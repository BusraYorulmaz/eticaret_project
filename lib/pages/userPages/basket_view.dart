import 'package:eticaret_project/constants/app_color.dart';
import 'package:eticaret_project/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: Text("basket".tr),
        centerTitle: true,
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.location_on))
        // ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        children: [
          Text(
            "products_in_the_basket".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          urunListe(
              aciklama: "Kıyafet",
              adet: "2",
              fiyat: "400",
              isim: "Oduncu Gömleği",
              url: "assets/images/gomlek1.jpg"),
          urunListe(
              aciklama: "Ayakkabı",
              adet: "3",
              fiyat: "1050",
              isim: "Converse",
              url: "assets/images/converse.jpg"),
          urunListe(
              aciklama: "Kıyafetler",
              adet: "3",
              fiyat: "350",
              isim: "Gömlek",
              url: "assets/images/gomlek3.jpg"),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "total_amount".tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "1800 ₺",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: CustomButton(
                text: "complete_the_order".tr,
                onTap: () {},
              )),
            ],
          ),
        ],
      ),
    );
  }
}

Widget urunListe(
    {required String isim,
    required String aciklama,
    required String url,
    required String fiyat,
    required String adet}) {
  return ListView.separated(
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemCount: 1,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      final size = MediaQuery.of(context).size;
      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BasketView()));
        },
        child: Card(
          elevation: 10,
          shadowColor: Colors.black26,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    url,
                    width: size.width * 0.2,
                    height: size.width * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isim,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        aciklama,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fiyat + "₺",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Column(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         print("Arttır");
                //       },
                //       child: Container(
                //         padding: const EdgeInsets.all(6),
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           border: Border.all(
                //             color: Colors.green,
                //           ),
                //         ),
                //         child: const Icon(
                //           Icons.add,
                //           size: 18,
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 4),
                //       child: Text(
                //         adet,
                //         style: const TextStyle(
                //           fontWeight: FontWeight.w600,
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         print("Azalt");
                //       },
                //       child: Container(
                //         padding: const EdgeInsets.all(6),
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           border: Border.all(
                //             color: Colors.red,
                //           ),
                //         ),
                //         child: const Icon(
                //           Icons.remove,
                //           size: 18,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
