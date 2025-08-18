import 'package:drivers_companionn/screens/ChangeForgotPassword/change_password_screen.dart';
import 'package:drivers_companionn/screens/login_screen.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';

class OTPPasswordRecoveryScreen extends StatefulWidget {
  const OTPPasswordRecoveryScreen({super.key});

  @override
  State<OTPPasswordRecoveryScreen> createState() =>
      _OTPPasswordRecoveryScreenState();
}

class _OTPPasswordRecoveryScreenState extends State<OTPPasswordRecoveryScreen> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late String correctPin;
  bool otpCorrect = false;
  //Color focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  Color fillColor = Color.fromRGBO(243, 246, 249, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text(otpVerification, style: boldLargeTextStype),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // (otpCorrect == false)
            //     ?
            Expanded(
              child: Column(
                children: [
                  // 20.height,
                  // Text(otpVerification, style: boldLargeTextStype),
                  40.height,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: smallTextStyle,
                      children: [
                        TextSpan(text: 'To complete '),
                        TextSpan(
                          text: 'SIGNUP',
                          style: boldSmallTextStype,
                        ),
                        TextSpan(text: ', please enter the '),
                        TextSpan(
                          text: 'OTP',
                          style: boldSmallTextStype,
                        ),
                        TextSpan(text: ' we just sent to your mobile number.'),
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
                    validator: (value) {
                      return value == correctPin ? null : 'Pin is incorrect';
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                      if (pin == correctPin) {
                        //ProfileScreen().launch(context, isNewTask: true);
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
                  Text(dontReceiveOTP),
                  TextButton(
                    child: Text(
                      resendOTP,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                        color: appTextColor,
                        decorationColor: appTextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // : Expanded(
            //     child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Image.asset('assets/images/success_tick.png'),
            //       Text(
            //         congratulations,
            //         style: boldLargeTextStype,
            //       ),
            //       10.height,
            //       Text(
            //         signupComplete,
            //         style: smallTextStyle,
            //       )
            //     ],
            //   )),
            PVSolidButton(
                title: submit,
                onPressed: () {
                  if (otpCorrect == false) {
                    setState(() {
                      otpCorrect = true;
                    });
                  } else {
                    //LoginScreen().launch(context);
                    ChangePasswordScreen().launch(context);
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
      // ),
    );
  }
}
