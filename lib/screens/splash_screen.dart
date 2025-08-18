import 'package:drivers_companionn/screens/home_screen.dart';
import 'package:drivers_companionn/screens/register_login_screen.dart';
import 'package:drivers_companionn/screens/scan_screen.dart';
import 'package:drivers_companionn/ui/PVButtonIcon.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:drivers_companionn/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png'),
                      Text(
                        'Parking Tracking App',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: appGreyColor),
                      )
                    ],
                  ),
                ),
                PVButtonIcon(
                  title: start,
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    final staff = getStringAsync(Constant.STAFF);
                    if (staff.isNotEmpty) {
                      HomeScreen().launch(context, isNewTask: true);
                    } else {
                      RegisterLoginScreen().launch(context, isNewTask: false);
                    }
                  },
                ),
                20.height
              ],
            ),
          ),
        ),
        bottomSheet: Text(
          copyrightBy,
          style: bottomSheetStyle,
        ),
      ),
    );
  }
}
