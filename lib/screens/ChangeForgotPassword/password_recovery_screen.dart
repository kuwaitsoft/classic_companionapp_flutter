import 'dart:math';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/apis/api_methods.dart';
import 'package:drivers_companionn/screens/ChangeForgotPassword/otp_password_recovery_screen.dart';
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
import 'package:pinput/pinput.dart';
import 'package:solar_icons/solar_icons.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  TextEditingController? civicIdController;
  late final TextEditingController pinController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  late final FocusNode focusNode;
  bool isOTPSend = false;
  bool isOTPCorrect = false;

  bool obsecurePassword = true;
  bool obsecureConfirmPassword = true;
  late String correctPin;
  bool otpCorrect = false;
  //Color focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  Color fillColor = Color.fromRGBO(243, 246, 249, 0);

  Map? responseOTP, response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    civicIdController = TextEditingController();
    pinController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    focusNode = FocusNode();
  }

  sendOTPAPICall() async {
    correctPin = generateRandom4Digit();
    Constant.showLog(correctPin);
    CustomUI.showProgress(context);
    responseOTP =
        await forgotPasswordData(civicIdController?.text ?? '', correctPin);
    if (mounted) CustomUI.hideProgress(context);

    if (responseOTP != null) {
      if (responseOTP!["success"] == 1) {
        isOTPSend = true;
        //_showSuccessPopup(context, msg);
        //ScanScreen().launch(context, isNewTask: true);
        //HomeScreen().launch(context, isNewTask: true);
      } else if (responseOTP!["success"] == 0) {
        String msg = responseOTP!["msg"];
        _showWarningPopup(context, msg);
      }
    }
    setState(() {});
  }

  changePasswordAPICall() async {
    CustomUI.showProgress(context);
    response = await changePasswordData(
        civicIdController?.text ?? '', passwordController?.text ?? '');
    if (mounted) CustomUI.hideProgress(context);
    if (response != null) {
      if (response!["success"] == 1) {
        String msg = response!["msg"];
        _showSuccessPopup(context, msg);
        //ScanScreen().launch(context, isNewTask: true);
        //HomeScreen().launch(context, isNewTask: true);
      } else if (response!["success"] == 0) {
        String msg = response!["msg"];
        _showWarningPopup(context, msg);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text(passwordRecovery, style: boldLargeTextStype),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 20.height,
                  // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //   Text(passwordRecovery, style: boldLargeTextStype)
                  // ]),
                  40.height,
                  Text(enterCivilID, style: smallTextStyle),
                  16.height,
                  PVTextFormFieldPrefix(
                    controller: civicIdController,
                    hintText: enterCivilID,
                    prefixIcon: BootstrapIcons.phone,
                  ),
                  if (isOTPSend && isOTPCorrect == false)
                    Column(
                      children: [
                        40.height,
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: smallTextStyle,
                            children: [
                              TextSpan(text: 'Please enter the '),
                              TextSpan(
                                text: 'OTP',
                                style: boldSmallTextStype,
                              ),
                              TextSpan(
                                  text: ' we just sent to your mobile number.'),
                            ],
                          ),
                        ),
                        16.height,
                        Pinput(
                          //smsRetriever: smsRetriever,
                          controller: pinController,
                          focusNode: focusNode,
                          defaultPinTheme: pinTheme(),
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          // validator: (value) {
                          //   return value == correctPin
                          //       ? null
                          //       : 'Pin is incorrect';
                          // },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                            if (pin == correctPin) {
                              //ProfileScreen().launch(context, isNewTask: true);
                              //isOTPCorrect = true;
                            } else {
                              //isOTPCorrect = false;
                            }
                          },
                          // onChanged: (value) {
                          //   //debugPrint('onChanged: $value');
                          // },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: appTextColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: pinTheme().copyWith(
                            decoration: pinTheme().decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: appTextColor),
                                ),
                          ),
                          submittedPinTheme: pinTheme().copyWith(
                            decoration: pinTheme().decoration!.copyWith(
                                  color: fillColor,
                                  borderRadius: BorderRadius.circular(19),
                                  border: Border.all(color: appTextColor),
                                ),
                          ),
                          errorPinTheme: pinTheme().copyBorderWith(
                            border: Border.all(color: themeColor),
                          ),
                        ),
                        16.height,
                        PVSolidButton(
                            title: verifyOTP,
                            onPressed: () {
                              if (pinController.text.isEmpty) {
                                _showWarningPopup(context, enterOTP);
                                return;
                              }
                              if (pinController.text != correctPin) {
                                _showWarningPopup(
                                    context, enterPasswordConfirmPassword);
                                return;
                              }
                              if (pinController.text == correctPin) {
                                isOTPCorrect = true;
                                setState(() {});
                              }

                              // if (validateForm()) {
                              //   if (pinController.text == correctPin) {
                              //     isOTPCorrect = true;
                              //     setState(() {});
                              //   }
                              // }
                            }),
                      ],
                    ),
                  if (isOTPCorrect) 16.height,
                  if (isOTPCorrect) Text(yourPassword, style: smallTextStyle),
                  if (isOTPCorrect) 4.height,
                  if (isOTPCorrect)
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
                  if (isOTPCorrect) 16.height,
                  if (isOTPCorrect)
                    Text(confirmPassword, style: smallTextStyle),
                  if (isOTPCorrect) 4.height,
                  if (isOTPCorrect)
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
                  if (isOTPCorrect) 16.height,
                  if (isOTPCorrect)
                    PVSolidButton(
                        title: submit,
                        onPressed: () {
                          if (validateForm()) {
                            changePasswordAPICall();
                          }
                        }),
                ],
              ),
            ),
            if (isOTPSend == false)
              PVSolidButton(
                  title: submit,
                  onPressed: () {
                    if (validateForm()) {
                      sendOTPAPICall();
                    }
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

  bool validateForm() {
    if (isOTPSend == false) {
      if (civicIdController!.text.isEmpty) {
        _showWarningPopup(context, enterCivilID);
        return false;
      }
    }
    if (isOTPSend == true) {
      if (pinController.text.isEmpty) {
        _showWarningPopup(context, enterOTP);
        return false;
      }
    }

    // if (isOTPSend && isOTPCorrect == false) {
    //   _showWarningPopup(context, unableResetPassword);
    //   return false;
    // }
    if (isOTPSend && isOTPCorrect == true) {
      if (passwordController!.text.isEmpty ||
          confirmPasswordController!.text.isEmpty) {
        _showWarningPopup(context, enterPasswordConfirmPassword);
        return false;
      }
    }
    return true;
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
    Navigator.pop(context);
    // if (r is String) {
    //   if (r == 'Continue') {
    //     log('Go To New Screen');

    //     //SignupScreen().launch(context);
    //     //LoginScreen().launch(context);
    //   }
    // }
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

  String generateRandom4Digit() {
    final random = Random();
    return (1000 + random.nextInt(9000))
        .toString(); // ensures 4-digit (1000–9999)
  }
}
