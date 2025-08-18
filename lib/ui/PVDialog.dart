import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:flutter/material.dart';

class PVDialog extends StatefulWidget {
  final imageName;
  final message;
  final btnTitle;
  PVDialog(
      {super.key,
      required this.imageName,
      required this.message,
      required this.btnTitle});

  @override
  State<PVDialog> createState() => _PVDialogState();
}

class _PVDialogState extends State<PVDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Use Dialog for full customizability of shape and content
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Rounded corners for the dialog
      ),
      backgroundColor: appDarkGreyColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content vertically
          children: <Widget>[
            // Warning Icon
            Image.asset('assets/images/${widget.imageName}', height: 98),
            const SizedBox(height: 20.0),
            // Message Text
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(color: appTextColor, fontSize: 16.0),
            ),
            const SizedBox(height: 30.0),
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(widget.btnTitle);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: const Text(
                  continueTxt,
                  style: TextStyle(
                    color: appTextColor,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
