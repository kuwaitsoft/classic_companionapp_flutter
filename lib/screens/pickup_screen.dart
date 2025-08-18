import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/apis/api_methods.dart';
import 'package:drivers_companionn/models/retrieveCarforPickupModel.dart';
import 'package:drivers_companionn/ui/CustomUI.dart';
import 'package:drivers_companionn/ui/PVButtonIcon.dart';
import 'package:drivers_companionn/ui/PVDialog.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/PVTextFormFieldPrefix.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:drivers_companionn/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:solar_icons/solar_icons.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  late String barcodeValue;
  bool isScanClicked = false;
  bool isBarcodeDetected = false;
  String staffName = "";
  late final TextEditingController codeController;
  RetrieveCarforPickupModel? retrieveCarPickupModel;
  Map? response;

  Future<void> scanQR() async {
    String? barcodeScanRes;

    barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Scan Barcode',
        centerTitle: false,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      //delayMillis: 2000,
      cameraFace: CameraFace.back,
    );
    if (barcodeScanRes!.endsWith("#")) {
      barcodeScanRes = barcodeScanRes.substring(0, barcodeScanRes.length - 1);
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    //       themeColor.toHex(), 'Cancel', true, ScanMode.DEFAULT);
    //   print(barcodeScanRes);
    //   if (barcodeScanRes.endsWith("#")) {
    //     barcodeScanRes = barcodeScanRes.substring(0, barcodeScanRes.length - 1);
    //   }
    // } on PlatformException {
    //   barcodeScanRes = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      barcodeValue = barcodeScanRes ?? '';
      codeController.text = barcodeValue;
      isBarcodeDetected = true;
      retrieveCarforPickup();
    });
  }

  retrieveCarforPickup() async {
    CustomUI.showProgress(context);
    retrieveCarPickupModel =
        await retrieveCarforPickupData(codeController.text);
    if (mounted) CustomUI.hideProgress(context);
    if (retrieveCarPickupModel != null) {
      if (retrieveCarPickupModel!.success == 1) {
        // SelectParkinglotScreen(retrieveCarInfo: retrieveCarInfo)
        //     .launch(context);
        setState(() {});
      } else {
        String msg = retrieveCarPickupModel!.msg!;
        barcodeValue = "";
        codeController.text = barcodeValue;
        isScanClicked = false;
        isBarcodeDetected = false;
        _showWarningPopup(context, msg);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = TextEditingController();
    // commentController = TextEditingController();
    staffName = getStringAsync(Constant.STAFF);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pickup.toUpperCase(), style: boldLargeTextStype),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            RichText(
              text: TextSpan(
                style: smallTextStyle,
                children: [
                  TextSpan(text: welcomeBack, style: boldSmallTextStype),
                  TextSpan(text: ' $staffName'),
                ],
              ),
            ),
            24.height,
            Text(keyTag, style: smallTextStyle),
            4.height,
            PVTextFormFieldPrefix(
                controller: codeController,
                hintText: '',
                prefixIcon: BootstrapIcons.hash,
                readOnly: true),
            16.height,
            PVButtonIcon(
                title: scan,
                icon: SolarIconsOutline.codeScan,
                onPressed: () async {
                  scanQR();
                }),
            16.height,
            //Text(onceClickScanned, style: smallTextStyle),
            if (retrieveCarPickupModel != null)
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
                    RichText(
                      text: TextSpan(
                        //style: smallTextStyle,
                        children: [
                          TextSpan(
                              text: parkingLocation, style: boldSmallTextStype),
                          TextSpan(
                              text:
                                  ' ${retrieveCarPickupModel?.car?.parkingIp ?? ''}',
                              style: mediumTextStyle),
                        ],
                      ),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                        //style: smallTextStyle,
                        children: [
                          TextSpan(text: admittime, style: boldSmallTextStype),
                          TextSpan(
                              text:
                                  ' ${retrieveCarPickupModel?.car?.admittime ?? ''}',
                              style: mediumTextStyle),
                        ],
                      ),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                        //style: smallTextStyle,
                        children: [
                          TextSpan(text: barcode, style: boldSmallTextStype),
                          TextSpan(
                              text:
                                  ' ${retrieveCarPickupModel?.car?.barcode ?? ''}',
                              style: mediumTextStyle),
                        ],
                      ),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                        //style: smallTextStyle,
                        children: [
                          TextSpan(
                              text: '$keyTag :', style: boldSmallTextStype),
                          TextSpan(
                              text: ' ${codeController.text}',
                              style: mediumTextStyle),
                        ],
                      ),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                        //style: smallTextStyle,
                        children: [
                          TextSpan(
                              text: parkedByStaff, style: boldSmallTextStype),
                          TextSpan(
                              text:
                                  ' ${retrieveCarPickupModel?.car?.parkedByStaff ?? ''}',
                              style: mediumTextStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (retrieveCarPickupModel != null) 16.height,
            if (retrieveCarPickupModel != null)
              PVSolidButton(
                title: confirm,
                onPressed: () {
                  submitAPICall();
                },
              )
          ],
        ),
      ),
    );
  }

  resetFields() {
    isScanClicked = false;
    isBarcodeDetected = false;
    codeController.text = "";
    retrieveCarPickupModel = null;
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

    resetFields();
    setState(() {});
    // if (r is String) {
    //   if (r == 'Continue') {
    //     log('Go To New Screen');
    //     //SignupScreen().launch(context);
    //   }
    // }
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

  submitAPICall() async {
    CustomUI.showProgress(context);
    final staff_id = getIntAsync(Constant.ID);
    response = await updatePickupData(
        retrieveCarPickupModel?.car?.barcode ?? '',
        staff_id,
        retrieveCarPickupModel?.car?.parkingIp ?? '');
    if (mounted) CustomUI.hideProgress(context);
    if (response != null) {
      if (response!["success"] == 1) {
        String msg = response!["msg"];
        if (mounted) _showSuccessPopup(context, msg);
      } else if (response!["success"] == 0) {
        String msg = response!["msg"];
        if (mounted) _showWarningPopup(context, msg);
      }
    }
    // response = await staffAppUpdateParkingData(
    //     retrieveCarInfo?.car?.barcode ?? '',
    //     id,
    //     level1Selected ?? '',
    //     level2Selected ?? '',
    //     level3Selected ?? '',
    //     commentController.text);
    // if (mounted) CustomUI.hideProgress(context);
    // if (response != null) {
    //   if (response!["success"] == 1) {
    //     String msg = response!["msg"];
    //     if (mounted) _showSuccessPopup(context, msg);
    //   } else if (response!["success"] == 0) {
    //     String msg = response!["msg"];
    //     if (mounted) _showWarningPopup(context, msg);
    //   }
    // }
  }
}
