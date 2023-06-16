import 'package:eticaret_project/constants/constant.dart';
import 'package:eticaret_project/pages/userPages/base_view.dart';
import 'package:eticaret_project/pages/userPages/userLoginRegister.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../adminPages/admin_login.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _backgroundImageAssets(size),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            child: const Icon(Icons.language),
                            onPressed: () {
                              Get.updateLocale(
                                Get.locale == const Locale('tr', 'TR')
                                    ? const Locale('en', 'US')
                                    : const Locale('tr', 'TR'),
                              );
                            },
                          ),
                          _skipButton(TextConstants().skipButtonText, context),
                        ],
                      ),
                      const SizedBox(height: 40),
                      _splashTitleText(),
                      const SizedBox(height: 10),
                      _splashSubTitleText(size),
                    ],
                  ),
                ),
                _bottomContainer(size, context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _splashTitleText() {
    return const Text(
      "HAPPY SHOP",
      style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 60),
    );
  }

  Image _backgroundImageAssets(Size size) {
    return Image.asset(
      AssetPathConstant().loginAssethPath,
      height: size.height,
      width: size.width,
      fit: BoxFit.cover, //ekranın tamamına sığsın
    );
  }

  _bottomContainer(Size size, BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: size.width,
          height: size.height * 0.40,
          decoration: const BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              _userLoginButton(size, context),
              const SizedBox(height: 10),
              _adminLoginButton(size, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userLoginButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const WidgetUserAndRegister()),
            (route) => false);
      },
      child: Card(
        elevation: 50,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          width: 250,
          child: Center(
            child: Text(
              'user_login'.tr,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _adminLoginButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AdminUserPages()),
            (route) => false);
      },
      child: Card(
        elevation: 50,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          width: 250,
          child: Center(
            child: Text(
              'admin_login'.tr,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Align _skipButton(String text, BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          openInformationPopup();
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'skip'.tr,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }

  String? value;
  openInformationPopup() => showDialog(
        context: context,
        builder: ((context) => SimpleDialog(
              title: Text(
                'your_informaiton'.tr,
                textAlign: TextAlign.center,
              ),
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      hintText: 'bodySize'.tr,
                      icon: const Icon(Icons.boy_rounded)),
                ),
                TextField(
                  onChanged: (text) {
                    value = text;
                  },
                  decoration: InputDecoration(
                      hintText: 'shoeSize'.tr,
                      icon: const Icon(Icons.snowshoeing)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BaseView(),
                        ),
                      );
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (_) => const BaseView()),
                      //     (route) => false);
                    },
                    child: Text('okey'.tr)),
              ],
            )),
      );

  _splashSubTitleText(Size size) {
    return Container(
      constraints: BoxConstraints(maxWidth: size.width * 0.9),
      child: Text(
        'explanation'.tr,
        style: const TextStyle(color: Colors.black, fontSize: 26),
      ),
    );
  }
}
