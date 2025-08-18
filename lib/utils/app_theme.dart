import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppThemeData {
  //
  AppThemeData._();

  // static final ThemeData lightTheme = ThemeData(
  //   scaffoldBackgroundColor: whiteColor,
  //   primaryColor: appStore.appColorPrimary,
  //   primaryColorDark: appStore.appColorPrimary,
  //   //errorColor: Colors.red,
  //   hoverColor: Colors.white54,
  //   dividerColor: viewLineColor,
  //   fontFamily: GoogleFonts.poppins().fontFamily,
  //   appBarTheme: const AppBarTheme(
  //     color: appLayoutBackground,
  //     iconTheme: IconThemeData(color: textPrimaryColor),
  //     systemOverlayStyle:
  //         SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
  //   ),
  //   textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
  //   colorScheme: ColorScheme.light(primary: appStore.appColorPrimary),
  //   cardTheme: const CardTheme(color: Colors.white),
  //   cardColor: Colors.white,
  //   iconTheme: const IconThemeData(color: textPrimaryColor),
  //   bottomSheetTheme: const BottomSheetThemeData(backgroundColor: whiteColor),
  //   textTheme: TextTheme(
  //       /*  button: TextStyle(color: appStore.appColorPrimary),
  //     headline6: const TextStyle(color: textPrimaryColor),
  //     subtitle2: const TextStyle(color: textSecondaryColor),*/
  //       ),
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  // ).copyWith(
  //   pageTransitionsTheme: const PageTransitionsTheme(
  //       builders: <TargetPlatform, PageTransitionsBuilder>{
  //         TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
  //         TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  //         TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
  //         TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
  //       }),
  // );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColor,
    highlightColor: appBackgroundColor,
    //errorColor: const Color(0xFFCF6676),
    appBarTheme: const AppBarTheme(
      color: appBackgroundColor,
      iconTheme: IconThemeData(color: appBackgroundColor),
      // systemOverlayStyle:
      //     SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: appBackgroundColor,
    dividerColor: const Color(0xFFDADADA).withOpacity(0.3),
    primaryColorDark: appBackgroundColor,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    hoverColor: Colors.black12,
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: appBackgroundColor),
    primaryTextTheme: TextTheme(
        /*  headline6: primaryTextStyle(color: Colors.white),
      overline: primaryTextStyle(color: Colors.white),*/
        ),
    cardTheme: const CardTheme(color: appBackgroundColor),
    cardColor: appBackgroundColor,
    iconTheme: const IconThemeData(color: themeColor),
    textTheme: const TextTheme(
        /*  button: TextStyle(color: colorPrimaryBlack),
      headline6: TextStyle(color: whiteColor),
      subtitle2: TextStyle(color: Colors.white54),*/
        ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(
      primary: appBackgroundColor,
      onPrimary: appBackgroundColor,
    ).copyWith(secondary: themeColor),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
        }),
  );
}
