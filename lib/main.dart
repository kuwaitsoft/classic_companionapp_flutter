import 'package:drivers_companionn/screens/splash_screen.dart';
import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver\'s Companion',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: themeColor,
            foregroundColor: appTextColor,
          ),
          textTheme: const TextTheme().copyWith(
            bodySmall: const TextStyle(color: appTextColor),
            bodyMedium: const TextStyle(color: appTextColor),
            bodyLarge: const TextStyle(color: appTextColor),
            labelSmall: const TextStyle(color: appTextColor),
            labelMedium: const TextStyle(color: appTextColor),
            labelLarge: const TextStyle(color: appTextColor),
            displaySmall: const TextStyle(color: appTextColor),
            displayMedium: const TextStyle(color: appTextColor),
            displayLarge: const TextStyle(color: appTextColor),
          ),
          scaffoldBackgroundColor: appBackgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: appBackgroundColor),
          useMaterial3: true,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: appBackgroundColor)),
      home: SplashScreen(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
