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
      appBar: AppBar(
        title: Text("basket".tr),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.location_on))
        ],
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
              aciklama:
                  "When an unknown printer took a galley of type it to make a type specimen book",
              adet: "2",
              fiyat: "70,45",
              isim: "Kıyafet 1",
              url: "assets/images/gomlek1.jpg"),
          urunListe(
              aciklama:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
              adet: "3",
              fiyat: "30,50",
              isim: "Kıyafet 2",
              url: "assets/images/gomlek2.jpg"),
          urunListe(
              aciklama:
                  "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
              adet: "1",
              fiyat: "150",
              isim: "Kıyafet 3",
              url: "assets/images/gomlek3.jpg"),
          const SizedBox(height: 5),
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
                    "1456.99 ₺",
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
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const BasketView()),
                    (route) => false,
                  );
                },
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
            padding: const EdgeInsets.all(8.0),
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
                        fiyat + " ₺",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Arttır");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        adet,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Azalt");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.red,
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
