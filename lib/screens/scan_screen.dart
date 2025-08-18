import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:drivers_companionn/apis/api_methods.dart';
import 'package:drivers_companionn/models/level2model.dart';
import 'package:drivers_companionn/models/level3model.dart';
import 'package:drivers_companionn/models/retrievecarinfo.dart';
import 'package:drivers_companionn/screens/select_parkinglot_screen.dart';
import 'package:drivers_companionn/ui/CustomUI.dart';
import 'package:drivers_companionn/ui/PVButtonIcon.dart';
import 'package:drivers_companionn/ui/PVDialog.dart';
import 'package:drivers_companionn/ui/PVDropdown.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/PVTextFormField.dart';
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
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:solar_icons/solar_icons.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late String barcodeValue;
  bool isScanClicked = false;
  bool isBarcodeDetected = false;
  late final TextEditingController codeController;
  String staffName = "";
  RetrieveCarInfo? retrieveCarInfo;
  String? level1Selected;
  String? level2Selected;
  String? level3Selected;

  Level2Model? level2Model;
  Level3Model? level3Model;
  late final TextEditingController commentController;
  Map? response;
  // final MobileScannerController controller = MobileScannerController(
  //   cameraResolution: size,
  //   detectionSpeed: detectionSpeed,
  //   detectionTimeoutMs: detectionTimeout,
  //   formats: selectedFormats,
  //   returnImage: returnImage,
  //   torchEnabled: true,
  //   invertImage: invertImage,
  //   autoZoom: autoZoom,
  // );

  // void _startScanning() {
  //   // Ensure any previous subscription is cancelled before starting a new one
  //   _barcodeSubscription?.cancel();

  //   // Start listening to the barcode stream
  //   _barcodeSubscription = SimpleBarcodeScanner.streamBarcode().listen(
  //     (barcode) {
  //       setState(() {
  //         barcodeValue = barcode;
  //       });
  //       // Optionally, if you only want to scan one barcode and then stop
  //       // you can cancel the subscription here.
  //       // _barcodeSubscription?.cancel();
  //     },
  //     onError: (error) {
  //       setState(() {
  //         //scannedBarcode = 'Error: $error';
  //       });
  //       print('Barcode scanner error: $error');
  //     },
  //     onDone: () {
  //       // This is called when the stream closes, which might happen if the scanner UI is dismissed
  //       print('Barcode scanning stream finished.');
  //     },
  //   );
  // }

  // void _stopScanning() {
  //   // Explicitly cancel the subscription to stop listening
  //   if (_barcodeSubscription != null) {
  //     _barcodeSubscription!.cancel();
  //     _barcodeSubscription = null; // Clear the reference
  //     setState(() {
  //       //scannedBarcode = 'Scanning stopped manually.';
  //     });
  //     print('Barcode scanning manually stopped.');
  //   } else {
  //     print('No active scanning to stop.');
  //   }
  // }

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
      retrieveCarinfoAPICall();
    });
  }

//retrieveCarinfo
  retrieveCarinfoAPICall() async {
    CustomUI.showProgress(context);
    final venueId = getIntAsync(Constant.VENUEID);
    retrieveCarInfo = await retrieveCarinfoData(barcodeValue, venueId);
    if (mounted) CustomUI.hideProgress(context);
    if (retrieveCarInfo != null) {
      if (retrieveCarInfo!.success == 1) {
        // SelectParkinglotScreen(retrieveCarInfo: retrieveCarInfo)
        //     .launch(context);
        setState(() {});
      } else {
        String msg = retrieveCarInfo!.msg!;
        barcodeValue = "";
        codeController.text = barcodeValue;
        isScanClicked = false;
        isBarcodeDetected = false;
        _showWarningPopup(context, msg);
      }
    }
  }

  retrieveLevel2APICall() async {
    final venueId = getIntAsync(Constant.VENUEID);
    CustomUI.showProgress(context);
    level2Model = await retrieveLevel2Data(venueId, level1Selected!);
    if (mounted) CustomUI.hideProgress(context);
    setState(() {});
  }

  retrieveLevel3APICall() async {
    final venueId = getIntAsync(Constant.VENUEID);
    CustomUI.showProgress(context);
    level3Model = await retrieveLevel3Data(
        venueId, level1Selected ?? '', level2Selected ?? '');
    if (mounted) CustomUI.hideProgress(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = TextEditingController();
    commentController = TextEditingController();
    staffName = getStringAsync(Constant.STAFF);
  }

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text(drop.toUpperCase(), style: boldLargeTextStype),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (isBarcodeDetected == false)
                ? [
                    20.height,
                    RichText(
                      text: TextSpan(
                        style: smallTextStyle,
                        children: [
                          TextSpan(
                              text: welcomeBack, style: boldSmallTextStype),
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
                    Text(onceClickScanned, style: smallTextStyle),
                  ]
                : [
                    20.height,
                    RichText(
                      text: TextSpan(
                        style: smallTextStyle,
                        children: [
                          TextSpan(
                              text: welcomeBack, style: boldSmallTextStype),
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
                    //16.height,
                    //Expanded(child: 0.height),
                    // isBarcodeDetected
                    //     ? PVSolidButton(
                    //         title: proceed,
                    //         onPressed: () {
                    //           retrieveCarinfoAPICall();
                    //           //SelectParkinglotScreen().launch(context);
                    //           //ScanScreen().launch(context, isNewTask: true);
                    //         })
                    //     : 0.height,
                    if (retrieveCarInfo != null) 20.height,
                    if (retrieveCarInfo != null)
                      Text(level1, style: smallTextStyle),
                    if (retrieveCarInfo != null) 4.height,
                    if (retrieveCarInfo != null)
                      PVDropdown(
                        options: retrieveCarInfo!.levels!,
                        hintText: 'Select Level 1',
                        onChanged: (String? newValue) {
                          print('Selected: $newValue');
                          // You can update a state variable here
                          level1Selected = newValue;
                          retrieveLevel2APICall();
                        },
                      ),

                    if (level2Model != null) 20.height,
                    if (level2Model != null)
                      Text(level2, style: smallTextStyle),
                    if (level2Model != null) 4.height,
                    if (level2Model != null)
                      PVDropdown(
                        options: level2Model!.levels2!,
                        hintText: 'Select Level 2',
                        onChanged: (String? newValue) {
                          print('Selected: $newValue');
                          // You can update a state variable here
                          level2Selected = newValue;
                          retrieveLevel3APICall();
                        },
                      ),

                    if (level3Model != null) 20.height,
                    if (level3Model != null)
                      Text(level3, style: smallTextStyle),
                    if (level3Model != null) 4.height,
                    if (level3Model != null)
                      if (level3Model!.levels3 != null)
                        PVDropdown(
                          options: level3Model!.levels3!,
                          hintText: 'Select Level 3',
                          onChanged: (String? newValue) {
                            print('Selected: $newValue');
                            // You can update a state variable here
                            level3Selected = newValue;
                            //retrieveLevel3APICall();
                          },
                        ),
                    if (level3Model != null) 24.height,
                    if (level3Model != null)
                      PVTextFormField(
                        hintText: 'Comment',
                        controller: commentController,
                        textInputType: TextInputType.text,
                      ),
                    if (level3Model != null) 24.height,
                    if (level3Model != null)
                      PVSolidButton(
                        title: proceed,
                        onPressed: () {
                          submitAPICall();
                        },
                      )
                  ],
          ),
        ),
      ),
      bottomSheet: Text(
        copyrightBy,
        style: bottomSheetStyle,
      ),
    )
        //)
        ;
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

  resetFields() {
    isScanClicked = false;
    isBarcodeDetected = false;

    retrieveCarInfo = null;
    level1Selected = null;
    level2Selected = null;
    level3Selected = null;

    level2Model = null;
    level3Model = null;
  }

  submitAPICall() async {
    CustomUI.showProgress(context);
    final id = getIntAsync(Constant.ID);
    response = await staffAppUpdateParkingData(
        retrieveCarInfo?.car?.barcode ?? '',
        id,
        level1Selected ?? '',
        level2Selected ?? '',
        level3Selected ?? '',
        commentController.text);
    if (mounted) CustomUI.hideProgress(context);
    if (response != null) {
      if (response!["success"] == 1) {
        String msg = response!["msg"];
        if (mounted) _showSuccessPopup(context, msg);
      } else if (response!["success"] == 0) {
        String msg = response!["msg"];
        if (mounted) _showWarningPopup(context, msg);
        //     // String msg = response!["msg"];
        //     // if (msg.contains('Staff already registered')) {
        //     //   //Go to Login
        //     // } else {
        //     //   //Show Error
        //     // }
      }
    }
  }
}
