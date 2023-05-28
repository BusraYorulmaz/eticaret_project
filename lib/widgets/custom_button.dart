import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final MaterialColor? color;
  const CustomButton({super.key, this.text, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Text(text ?? "Button"),
    );
  }
}
