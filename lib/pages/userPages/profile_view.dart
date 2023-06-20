import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../constants/app_color.dart';
import '../../model/profile_menu_model.dart';
import '../splashPages/splash_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<ProfileMenuModel> menuItems = [];
  //File? selectedImage;
  final String kvkk =
      'Lorem ipsum dolor sit amet.  Sed sed risus pretium quam vulputate dignissim suspendisse in. Nunc vel risus commodo viverra maecenas accumsan lacus. Non consectetur a erat nam at lectus urna duis. Nam at lectus urna duis convallis convallis.';

  void initialize() {
    menuItems.addAll([
      ProfileMenuModel(
          leading: Icons.text_fields_rounded,
          text: "kvkk_and_terms_of_use".tr,
          onTap: () {
            contractsPopup();
          }),
      ProfileMenuModel(
        leading: Icons.exit_to_app_rounded,
        text: "sign_out".tr,
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SplashScreenWidget()),
            (route) => false,
          );
        },
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Stack(
        children: [
          Positioned(
            top: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColor.pink.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.yellow.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColor.orange.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "AYARLAR",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        left: 20, bottom: 20, right: 20, top: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menuItems.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return _profileMenu(item);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void contractsPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "KVKK",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  kvkk,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Divider(),
                Text(
                  "Mesafeli Satış Sözleşmesi",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  kvkk * 2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _profileMenu(ProfileMenuModel model) {
    return GestureDetector(
      onTap: () => model.onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        color: Colors.grey.shade100,
        child: Row(
          children: [
            Icon(model.leading, color: Colors.blueGrey),
            const SizedBox(
              width: 12,
            ),
            Text(
              model.text,
              style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
