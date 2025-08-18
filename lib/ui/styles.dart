import 'package:flutter/material.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:pinput/pinput.dart';

const bottomSheetStyle =
    TextStyle(fontSize: 11, fontFamily: 'Montserrat', color: appGreyColor);
const boldLargeTextStyle = TextStyle(
    fontSize: 30, fontWeight: FontWeight.w900, fontFamily: 'Montserrat-Bold');
const boldLargeTextStype = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Montserrat');
const boldLargeTextStyleBlack = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Montserrat');
const boldSmallTextStype = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat');
const boldSmallTextStypeBlack = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat');
const mediumTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat',
    color: appGreyColor);
const smallTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    fontFamily: 'Montserrat',
    color: appGreyColor);
// const smallTextStyle = TextStyle(
//     fontSize: 15, fontWeight: FontWeight.normal, fontFamily: 'Montserrat');

PinTheme pinTheme() {
  Color borderColor = appGreyColor;
  return PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: appTextColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
    ),
  );
}
