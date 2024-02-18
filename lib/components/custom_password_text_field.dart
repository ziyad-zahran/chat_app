import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  CustomPasswordTextField({super.key, this.onChanged,this.hint,this.pIcon,this.sIcon,this.isSecure,this.onTap});
  String? hint;
  IconData? pIcon;
  IconData? sIcon;
  bool? isSecure;
  VoidCallback? onTap;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecure!,
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
            pIcon,
            color: Colors.white54,
        ),
        suffixIcon: IconButton(
          icon: Icon(sIcon),
          color: Colors.white54,
          onPressed:onTap,
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