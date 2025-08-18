import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PVSolidButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onPressed;

  const PVSolidButton({
    super.key,
    required this.title,
    this.icon,
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
        //padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Expanded(flex: 1, child: Icon(icon, color: appTextColor, size: 24)),
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: appTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          if (icon != null) Expanded(flex: 1, child: 0.width),
        ],
      ),
    );
    // return ElevatedButton(
    //   onPressed: onPressed,
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: themeColor,
    //     foregroundColor: appBackgroundColor,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     padding: const EdgeInsets.symmetric(vertical: 14),
    //     elevation: 0,
    //   ),
    //   child: Text(
    //     title,
    //     style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    //   ),
    // );
  }
}
