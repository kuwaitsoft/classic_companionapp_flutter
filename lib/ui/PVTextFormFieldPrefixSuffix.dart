import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PVTextFormFieldPrefixSuffix extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? textInputType;
  final IconData prefixIcon;
  final IconData sufixIcon;
  final VoidCallback? onSuffixTap;

  const PVTextFormFieldPrefixSuffix({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.textInputType,
    required this.prefixIcon,
    required this.sufixIcon,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      style: const TextStyle(color: appTextColor),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: appGreyColor),
        suffixIcon: GestureDetector(
          onTap: onSuffixTap,
          child: Icon(sufixIcon, color: appGreyColor),
        ),
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
          return '';
        } else if (!RegExp(r'^\d{12}$').hasMatch(value)) {
          return '';
        }
        return null;
      },
    );
  }
}
