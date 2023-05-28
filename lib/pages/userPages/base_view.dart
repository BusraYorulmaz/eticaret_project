import 'package:eticaret_project/constants/app_color.dart';
import 'package:eticaret_project/model/bottom_navigationbar_model.dart';
import 'package:eticaret_project/pages/userPages/home_view.dart';
import 'package:eticaret_project/pages/userPages/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'basket_view.dart';
import 'favorite_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  final group = AutoSizeGroup();
  // anasayfa, sepet, favoriler, profil
  List<BottomNavigationbarModel> bottomNavigationItems = [
    BottomNavigationbarModel(
        icon: Icons.home_filled,
        title: "mainPage".tr,
        body: const HomePage(),
        index: 0),
    BottomNavigationbarModel(
        icon: Icons.shopping_bag_rounded,
        title: "basket".tr,
        body: const BasketView(),
        index: 1),
    BottomNavigationbarModel(
        icon: Icons.shopping_bag_rounded,
        title: "favorites".tr,
        body: const FavoriteView(),
        index: 2),
    BottomNavigationbarModel(
        icon: Icons.shopping_bag_rounded,
        title: "profile".tr,
        body: const ProfileView(),
        index: 3),
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        height: 55,
        width: double.infinity,
        margin: EdgeInsets.only(left: 0, right: 0, bottom: bottomPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
            children: bottomNavigationItems.map((item) {
          return Expanded(
            child: IconButton(
              onPressed: () {
                setState(() {
                  activeIndex = item.index;
                });
              },
              icon: Column(
                children: [
                  Icon(
                    item.icon,
                    size: 20,
                    color: activeIndex == item.index
                        ? Colors.deepPurple
                        : Colors.grey.shade600,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      item.title,
                      group: group,
                      style: TextStyle(
                        fontSize: 14,
                        color: activeIndex == item.index
                            ? Colors.deepPurple
                            : Colors.grey.shade600,
                      ),
                      minFontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList()),
      ),
      body: bottomNavigationItems[activeIndex].body,
    );
  }
}
