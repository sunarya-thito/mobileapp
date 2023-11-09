import 'package:flutter/material.dart';
import 'package:mobileapp/theme.dart';

class GlassPaneTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  const GlassPaneTextField(
      {Key? key,
      required this.controller,
      required this.label,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: kSurfaceBorderColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: kSurfaceBorderColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: kSurfaceBorderColor,
            width: 2,
          ),
        ),
        label: Text(label),
        floatingLabelStyle: TextStyle(
          color: kSecondaryTextColor,
        ),
        labelStyle: TextStyle(
          color: kSecondaryTextColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        filled: true,
        fillColor: kSurfaceColor,
      ),
    );
  }
}
