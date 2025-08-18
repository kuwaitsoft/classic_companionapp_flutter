import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomUI {
  static showProgress(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: LoadingAnimationWidget.inkDrop(color: themeColor, size: 100),
          // child: CircularProgressIndicator(
          //     valueColor: AlwaysStoppedAnimation<Color>(
          //         Theme.of(context).colorScheme.secondary)),
        );
      },
    );
  }

  static hideProgress(BuildContext context) {
    Navigator.pop(context);
  }
}
