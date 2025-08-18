import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:flutter/material.dart';

class PVDialogWithTitle extends StatefulWidget {
  final title;
  final message;
  final btnTitle;
  PVDialogWithTitle({super.key, this.title, this.message, this.btnTitle});

  @override
  State<PVDialogWithTitle> createState() => _PVDialogWithTitleState();
}

class _PVDialogWithTitleState extends State<PVDialogWithTitle> {
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
            Image.asset('assets/images/warning.png', height: 98),
            const SizedBox(height: 20.0),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: boldSmallTextStype,
            ),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style:
                  smallTextStyle, //TextStyle(color: appTextColor, fontSize: 16.0),
            ),
            const SizedBox(height: 30.0),
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('Continue');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: Text(
                  widget.btnTitle,
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
