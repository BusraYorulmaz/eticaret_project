import 'package:flutter/material.dart'; 
import 'package:get/get.dart';

import '../../constants/app_color.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("favorites_".tr),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.location_on))
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.78,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoriteView())),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 4),
                            child: Banner(
                              message: "80,99 ₺",
                              location: BannerLocation.bottomEnd,
                              color: AppColor.primary,
                              textStyle: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  "assets/images/ayakkabı1.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 2, bottom: 4),
                          child: Text(
                            "product".tr,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                maximumSize: const Size(double.infinity, 36),
                                minimumSize: const Size(double.infinity, 32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            icon: const Icon(Icons.add),
                            label: Text("add_to_Basket".tr),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -8,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white54,
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
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}