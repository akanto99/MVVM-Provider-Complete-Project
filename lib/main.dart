import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_provider_completeproject/provider/dark_light_theme_provider/theme_provider.dart';
import 'package:mvvm_provider_completeproject/res/color.dart';
import 'package:mvvm_provider_completeproject/utils/routes/routes.dart';
import 'package:mvvm_provider_completeproject/view_model/auth_view_model.dart';
import 'package:mvvm_provider_completeproject/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'utils/routes/routes_name.dart';

/** **/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.initializeTheme();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.navColor,
    statusBarColor: AppColors.navColor,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation .portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          print("Current Theme Mode: ${themeProvider.isDarkMode ? 'Dark' : 'Light'}");
          bool isDarkMode = themeProvider.isDarkMode;

          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
              statusBarColor: isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
              statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
              statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
            ),
          );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    ),
  );
}

