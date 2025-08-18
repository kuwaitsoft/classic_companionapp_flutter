import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PVTextFormFieldPrefix extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? textInputType;
  final IconData prefixIcon;
  final bool readOnly;

  const PVTextFormFieldPrefix({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.textInputType,
    required this.prefixIcon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: appTextColor),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: appGreyColor),
        hintText: hintText,
        hintStyle: const TextStyle(color: appGreyColor),
        filled: true,
        fillColor: appDarkGreyColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: appGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: appGreyColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          ''; //return 'Please enter Civil ID';
        } else if (!RegExp(r'^\d{12}$').hasMatch(value)) {
          ''; //return 'Civil ID must be exactly 12 digits';
        }
        return null;
      },
    );
  }
}
