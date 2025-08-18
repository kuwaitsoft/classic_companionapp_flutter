import 'package:drivers_companionn/apis/api_methods.dart';
import 'package:drivers_companionn/screens/login_screen.dart';
import 'package:drivers_companionn/screens/signup_screen.dart';
import 'package:drivers_companionn/ui/CustomUI.dart';
import 'package:drivers_companionn/ui/PVDialog.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/PVTextFormField.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchCivilIdScreen extends StatefulWidget {
  const SearchCivilIdScreen({super.key});

  @override
  State<SearchCivilIdScreen> createState() => _SearchCivilIdScreenState();
}

class _SearchCivilIdScreenState extends State<SearchCivilIdScreen> {
  final _formKey = GlobalKey<FormState>();
  String _dialogResult = '';
  late final FocusNode focusNode;
  TextEditingController? civilIdCtrl;
  Map? response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    civilIdCtrl = TextEditingController();
    focusNode = FocusNode();
    // civilIdCtrl!.text = "288100906489";
    //civilIdCtrl!.text = "284072005983";
    //civilIdCtrl!.text = "288100906411";
  }

  void searchCivilId() async {
    CustomUI.showProgress(context);
    response = await staffAppRegister(civilIdCtrl!.text);
    if (mounted) CustomUI.hideProgress(context);
    if (response != null) {
      if (response!["success"] == 1) {
        //Go to Registration
        SignupScreen(
          civilId: civilIdCtrl!.text,
        ).launch(context);
      } else if (response!["success"] == 0) {
        String msg = response!["msg"];
        if (msg.contains('Staff already registered')) {
          //Go to Login
          LoginScreen().launch(context);
        } else {
          //Show Error
          _showWarningPopup(context, msg);
        }
      }
    }
    // itemRes = await getItemsByCusine(cat!['cuisine_id'].toString());

    // if (itemRes != null && itemRes!.containsKey('success')) {
    //   if (itemRes!['success'] == 1) {
    //     itemList = itemRes!['data'];
    //   }
    // }
    // _cal();
    //if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text(register.toUpperCase(), style: boldLargeTextStype),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //     flex: 1,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [Image.asset('assets/images/logo.png')],
              //     )),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        enterYourCivilID,
                        style: boldLargeTextStyle,
                      ),
                      30.height,
                      PVTextFormField(
                        hintText: enterYourCivilID,
                        controller: civilIdCtrl,
                        textInputType: TextInputType.number,
                      ),
                      16.height,
                      PVSolidButton(
                        title: search,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Valid 12-digit Civil ID
                            log('CIVIL ID: ${civilIdCtrl?.text}');
                            searchCivilId();
                          } else {
                            //_showCustomPopup(context);
                          }
                        },
                      ),
                      30.height,
                      Text(
                        weUseYourCivilID,
                        textAlign: TextAlign.center,
                        style: boldLargeTextStype,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomSheet: Text(
        copyrightBy,
        style: bottomSheetStyle,
      ),
      // ),
    );
  }

  _showCustomPopup(BuildContext context) async {
    dynamic r = await showDialog<String>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return PVDialog(
            imageName: 'warning.png',
            message: civilIdDoesNotExist,
            btnTitle: continueTxt);
      },
    );
    if (r is String) {
      if (r == 'Continue') {
        log('Go To New Screen');
        //SignupScreen().launch(context);
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
