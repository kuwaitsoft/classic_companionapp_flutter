import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/apis/api_methods.dart';
import 'package:drivers_companionn/screens/ChangeForgotPassword/password_recovery_screen.dart';
import 'package:drivers_companionn/screens/home_screen.dart';
import 'package:drivers_companionn/screens/scan_screen.dart';
import 'package:drivers_companionn/ui/CustomUI.dart';
import 'package:drivers_companionn/ui/PVDialog.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/PVTextFormFieldPrefix.dart';
import 'package:drivers_companionn/ui/PVTextFormFieldPrefixSuffix.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:drivers_companionn/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:solar_icons/solar_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecurePassword = true;
  TextEditingController? mobileController;
  TextEditingController? passwordController;
  Map? response;

  loginAPICall() async {
    CustomUI.showProgress(context);
    response =
        await staffAppLogin(mobileController!.text, passwordController!.text);
    if (mounted) CustomUI.hideProgress(context);

    if (response != null) {
      if (response!["success"] == 1) {
        await setValue(Constant.ID, response![Constant.ID]);
        await setValue(Constant.STAFF, response![Constant.STAFF]);
        await setValue(Constant.VENUEID, response![Constant.VENUEID]);
        await setValue(Constant.VENUENAME, response![Constant.VENUENAME]);

        //_showSuccessPopup(context, msg);
        //ScanScreen().launch(context, isNewTask: true);
        HomeScreen().launch(context, isNewTask: true);
      } else if (response!["success"] == 0) {
        String msg = response!["msg"];
        _showWarningPopup(context, msg);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text(login.toUpperCase(), style: boldLargeTextStype),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            20.height,
            //Text(login, style: boldLargeTextStype),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    24.height,
                    Text(yourMobileNo, style: smallTextStyle),
                    4.height,
                    PVTextFormFieldPrefix(
                      controller: mobileController,
                      hintText: yourMobileNo,
                      prefixIcon: BootstrapIcons.phone,
                      textInputType: TextInputType.phone,
                    ),
                    16.height,
                    Text(yourPassword, style: smallTextStyle),
                    4.height,
                    PVTextFormFieldPrefixSuffix(
                      controller: passwordController,
                      hintText: yourPassword,
                      prefixIcon: SolarIconsOutline.lockPassword,
                      sufixIcon: obsecurePassword
                          ? BootstrapIcons.eye_slash
                          : BootstrapIcons.eye,
                      obscureText: obsecurePassword,
                      onSuffixTap: () {
                        setState(() {
                          obsecurePassword = !obsecurePassword;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          child: Text(
                            forgotPassword,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat',
                              color: appTextColor,
                              decorationColor: appTextColor,
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            PasswordRecoveryScreen().launch(context);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            PVSolidButton(
                title: submit,
                onPressed: () {
                  //OTPVerificationnScreen().launch(context);
                  //ScanScreen().launch(context, isNewTask: true);
                  loginAPICall();
                }),
            20.height
          ],
        ),
      ),
      bottomSheet: Text(
        copyrightBy,
        style: bottomSheetStyle,
      ),
      //),
    );
  }

  _showSuccessPopup(BuildContext context, String message) async {
    dynamic r = await showDialog<String>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return PVDialog(
            imageName: 'success_tick.png',
            message: message,
            btnTitle: continueTxt);
      },
    );
    if (r is String) {
      if (r == 'Continue') {
        log('Go To New Screen');
        //SignupScreen().launch(context);
        //LoginScreen().launch(context);
      }
    }
  }

  _showWarningPopup(BuildContext context, String message) async {
    dynamic r = await showDialog<String>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return PVDialog(
            imageName: 'warning.png', message: message, btnTitle: continueTxt);
      },
    );
    // if (r is String) {
    //   if (r == 'Continue') {
    //     log('Go To New Screen');
    //     //SignupScreen().launch(context);
    //   }
    // }
  }
}
