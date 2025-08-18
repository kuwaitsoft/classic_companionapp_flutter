import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/apis/api_methods.dart';
import 'package:drivers_companionn/screens/login_screen.dart';
import 'package:drivers_companionn/screens/otp_verification_screen.dart';
import 'package:drivers_companionn/ui/CustomUI.dart';
import 'package:drivers_companionn/ui/PVDialog.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/PVTextFormFieldPrefix.dart';
import 'package:drivers_companionn/ui/PVTextFormFieldPrefixSuffix.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:solar_icons/solar_icons.dart';

class SignupScreen extends StatefulWidget {
  String civilId;
  SignupScreen({super.key, required this.civilId});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obsecurePassword = true;
  bool obsecureConfirmPassword = true;

  TextEditingController? mobileController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  Map? response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  submitAPICall() async {
    CustomUI.showProgress(context);
    response = await staffAppUpdateRecord(
        widget.civilId, mobileController!.text, passwordController!.text);
    if (mounted) CustomUI.hideProgress(context);
    if (response != null) {
      if (response!["success"] == 1) {
        String msg = response!["msg"];
        _showSuccessPopup(context, msg);
      } else if (response!["success"] == 0) {
        String msg = response!["msg"];
        _showWarningPopup(context, msg);
        // String msg = response!["msg"];
        // if (msg.contains('Staff already registered')) {
        //   //Go to Login
        // } else {
        //   //Show Error
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // appBar: AppBar(
      //   title: Text(signUp),
      // ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      Text(welcome, style: boldSmallTextStype),
                      24.height,
                      Text(yourMobileNo, style: smallTextStyle),
                      4.height,
                      PVTextFormFieldPrefix(
                          controller: mobileController,
                          hintText: yourMobileNo,
                          prefixIcon: BootstrapIcons.phone),
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
                      16.height,
                      Text(confirmPassword, style: smallTextStyle),
                      4.height,
                      PVTextFormFieldPrefixSuffix(
                        controller: confirmPasswordController,
                        hintText: confirmPassword,
                        prefixIcon: SolarIconsOutline.lockPassword,
                        sufixIcon: obsecureConfirmPassword
                            ? BootstrapIcons.eye_slash
                            : BootstrapIcons.eye,
                        obscureText: obsecureConfirmPassword,
                        onSuffixTap: () {
                          setState(() {
                            obsecureConfirmPassword = !obsecureConfirmPassword;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              PVSolidButton(
                  title: submit,
                  onPressed: () {
                    submitAPICall();
                    //OTPVerificationnScreen().launch(context);
                  }),
              20.height
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
        LoginScreen().launch(context);
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
