import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/screens/login_screen.dart';
import 'package:drivers_companionn/screens/search_civil_id_screen.dart';
import 'package:drivers_companionn/ui/PVOutlinedButton.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:solar_icons/solar_icons.dart';

class RegisterLoginScreen extends StatefulWidget {
  const RegisterLoginScreen({super.key});

  @override
  State<RegisterLoginScreen> createState() => _RegisterLoginScreenState();
}

class _RegisterLoginScreenState extends State<RegisterLoginScreen> {
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
                    Text('Welcome Back',
                        textAlign: TextAlign.center, style: boldLargeTextStyle),
                    30.height,
                    Text('Please login or\nregister to continue',
                        textAlign: TextAlign.center, style: mediumTextStyle),
                    75.height,
                    PVSolidButton(
                      title: register,
                      icon: BootstrapIcons.list,
                      onPressed: () {
                        SearchCivilIdScreen().launch(context, isNewTask: false);
                      },
                    ),
                    16.height,
                    PVOutlinedButton(
                      title: login,
                      icon: SolarIconsOutline.lock,
                      onPressed: () {
                        LoginScreen().launch(context);
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
        bottomSheet: Text(
          copyrightBy,
          style: bottomSheetStyle,
        ),
      ),
    );
  }
}
