import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, this.onChanged,this.hint,this.icon,this.isPassword});
  String? hint;
  IconData? icon;
  bool? isPassword = false;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data)
      {
        if(data!.isEmpty)
          {
            return 'field is required';
          }
        return null;
      },
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
            icon,
          color: Colors.white54,
        ),
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.white54,
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

