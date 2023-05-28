import 'package:flutter/material.dart';

class ProfileMenuModel {
  IconData leading;
  String text;
  Function() onTap;
  
  ProfileMenuModel({
    required this.leading,
    required this.text,
    required this.onTap,
  });
}
