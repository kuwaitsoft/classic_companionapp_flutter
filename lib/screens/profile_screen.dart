import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/screens/splash_screen.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:drivers_companionn/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late int venueId;
  late String civilid, venueName, staff;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    venueId = getIntAsync(Constant.VENUEID);
    civilid = getStringAsync(Constant.CIVILID);
    venueName = getStringAsync(Constant.VENUENAME);
    staff = getStringAsync(Constant.STAFF);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.toUpperCase(), style: boldLargeTextStype),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: appDarkGreyColor,
                border: Border.all(
                  color: appGreyColor, // border color
                  width: 1.0, // border width
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.height,
                  RichText(
                    text: TextSpan(
                      //style: smallTextStyle,
                      children: [
                        TextSpan(text: name, style: mediumTextStyle),
                        TextSpan(text: staff, style: boldSmallTextStype),
                      ],
                    ),
                  ).paddingBottom(8),
                  Divider(),
                  RichText(
                    text: TextSpan(
                      //style: smallTextStyle,
                      children: [
                        TextSpan(text: civilID, style: mediumTextStyle),
                        TextSpan(
                            text: civilid.toString(),
                            style: boldSmallTextStype),
                      ],
                    ),
                  ).paddingSymmetric(vertical: 8),
                  Divider(),
                  RichText(
                    text: TextSpan(
                      //style: smallTextStyle,
                      children: [
                        TextSpan(text: venue, style: mediumTextStyle),
                        TextSpan(
                            text: venueName.toString(),
                            style: boldSmallTextStype),
                      ],
                    ),
                  ).paddingSymmetric(vertical: 8),
                  //Divider(),
                ],
              ),
            ),
            20.height,
            FloatingActionButton.extended(
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
          ],
        ),
      ),
    );
  }

  logoutFromApp() async {
    await clearSharedPref();
    SplashScreen().launch(context, isNewTask: true);
  }
}
