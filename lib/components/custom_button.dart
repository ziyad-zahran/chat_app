import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.onTap,required this.text});
  String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
