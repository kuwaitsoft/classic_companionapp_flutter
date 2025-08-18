import 'package:drivers_companionn/apis/api_methods.dart';
import 'package:drivers_companionn/models/level2model.dart';
import 'package:drivers_companionn/models/level3model.dart';
import 'package:drivers_companionn/models/retrievecarinfo.dart';
import 'package:drivers_companionn/ui/CustomUI.dart';
import 'package:drivers_companionn/ui/PVDialogWithTitle.dart';
import 'package:drivers_companionn/ui/PVDropdown.dart';
import 'package:drivers_companionn/ui/PVSolidButton.dart';
import 'package:drivers_companionn/ui/styles.dart';
import 'package:drivers_companionn/utils/app_strings.dart';
import 'package:drivers_companionn/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectParkinglotScreen extends StatefulWidget {
  RetrieveCarInfo? retrieveCarInfo;
  SelectParkinglotScreen({super.key, required this.retrieveCarInfo});

  @override
  State<SelectParkinglotScreen> createState() => _SelectParkinglotScreenState();
}

class _SelectParkinglotScreenState extends State<SelectParkinglotScreen> {
  String staffName = "";
  String? level1Selected;
  String? level2Selected;
  String? level3Selected;

  Level2Model? level2Model;
  Level3Model? level3Model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    staffName = getStringAsync(Constant.STAFF);
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
  Widget build(BuildContext context) {
    return SafeArea(
      // appBar: AppBar(
      //   title: Text(signUp),
      // ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
              Text(parkingLot, style: smallTextStyle),
              4.height,
              PVDropdown(
                options: widget.retrieveCarInfo!.levels!,
                hintText: 'Level 1',
                onChanged: (String? newValue) {
                  print('Selected: $newValue');
                  // You can update a state variable here
                  level1Selected = newValue;
                  retrieveLevel2APICall();
                },
              ),
              if (level2Model != null) Text(parkingLot, style: smallTextStyle),
              if (level2Model != null) 4.height,
              if (level2Model != null)
                PVDropdown(
                  options: level2Model!.levels2!,
                  hintText: 'Level 2',
                  onChanged: (String? newValue) {
                    print('Selected: $newValue');
                    // You can update a state variable here
                    level2Selected = newValue;
                    retrieveLevel3APICall();
                  },
                ),
              if (level3Model != null) Expanded(child: 0.height),
              if (level3Model != null) 4.height,
              if (level3Model != null)
                PVDropdown(
                  options: level3Model!.levels3!,
                  hintText: 'Level 3',
                  onChanged: (String? newValue) {
                    print('Selected: $newValue');
                    // You can update a state variable here
                    level3Selected = newValue;
                    retrieveLevel3APICall();
                  },
                ),
              PVSolidButton(
                  title: process,
                  onPressed: () {
                    //SelectParkinglotScreen().launch(context);
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
        return PVDialogWithTitle(
            title: alert, message: parkSuccess, btnTitle: continueTxt);
      },
    );
    if (r is String) {
      if (r == 'Continue') {
        log('Go To New Screen');
      }
    }
  }
}
