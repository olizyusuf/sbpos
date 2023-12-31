import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.textController,
      this.readOnly = false,
      this.obscureText = false,
      required this.labelText,
      this.prefIcon,
      required this.colorBorder,
      required this.widthBorder,
      required this.circuralBoder,
      this.maxLength,
      this.keyboardType});

  final TextEditingController textController;
  final bool readOnly;
  final String labelText;
  final bool obscureText;
  final Icon? prefIcon;
  final Color colorBorder;
  final double widthBorder;
  final double circuralBoder;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: widthBorder, color: colorBorder),
          borderRadius: BorderRadius.circular(circuralBoder),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: widthBorder, color: colorBorder),
          borderRadius: BorderRadius.circular(circuralBoder),
        ),
      ),
    );
  }
}
