import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/screens/login_screen.dart';
import 'package:drivers_companionn/ui/PVDialog.dart';
import 'package:drivers_companionn/ui/PVDialogWithTitle.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/PVTextFormFieldPrefix.dart';
import 'package:drivers_companionn/ui/PVTextFormFieldPrefixSuffix.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:solar_icons/solar_icons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool obsecurePassword = true;
  bool obsecureConfirmPassword = true;

  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
                    _showCustomPopup(context);
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

  _showCustomPopup(BuildContext context) async {
    dynamic r = await showDialog<String>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return PVDialog(
            imageName: 'success_tick.png',
            // title: alert,
            message: passwordChangesSuccesfully,
            btnTitle: continueTxt);
      },
    );
    if (r is String) {
      if (r == 'Continue') {
        log('Go To New Screen');
        LoginScreen().launch(context, isNewTask: true);
      }
    }
  }
}
