import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/screens/pickup_screen.dart';
import 'package:drivers_companionn/screens/scan_screen.dart';
import 'package:drivers_companionn/screens/splash_screen.dart';
import 'package:drivers_companionn/ui/PVOutlinedButton.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:drivers_companionn/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String staffName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    staffName = getStringAsync(Constant.STAFF);
  }

  logoutFromApp() async {
    await clearSharedPref();
    SplashScreen().launch(context, isNewTask: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        //style: boldLargeTextStyle,
                        children: [
                          TextSpan(
                              text: welcomeBack, style: boldLargeTextStype),
                          TextSpan(text: ' $staffName', style: mediumTextStyle),
                        ],
                      ),
                    ),
                    // Text('Welcome Back',
                    //     textAlign: TextAlign.center, style: boldLargeTextStyle),
                    60.height,
                    Text(plzChoosePickupDrop,
                        textAlign: TextAlign.center, style: boldLargeTextStype),
                    30.height,
                    PVSolidButton(
                      title: drop,
                      //icon: BootstrapIcons.list,
                      onPressed: () {
                        ScanScreen().launch(context);
                      },
                    ),
                    16.height,
                    PVOutlinedButton(
                      title: pickup,
                      //icon: SolarIconsOutline.lock,
                      onPressed: () {
                        PickupScreen().launch(context);
                      },
                    ),
                    24.height,
                    // Text(
                    //   copyrightBy,
                    //   style: bottomSheetStyle,
                    // ),
                    // 16.height,
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: themeColor,
          foregroundColor: appTextColor,
          onPressed: () {
            logoutFromApp();
          },
          icon: const Icon(Icons.logout),
          label: const Text(
            logout,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
