import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PVButtonIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const PVButtonIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: themeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: appBackgroundColor, // Text color
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            icon,
            color: appBackgroundColor, // Icon color
          ),
        ],
      ),
    );
  }
}
