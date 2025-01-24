import 'package:flutter/material.dart';
import 'package:flutter_catalog/pages/MainPage.dart';
import 'package:flutter_catalog/pages/user_account/login_page.dart';
import 'package:flutter_catalog/pages/user_account/create_account_page.dart';
import 'package:flutter_catalog/pages/user_account/forgot_password_email.dart';
import 'package:flutter_catalog/pages/user_account/forgot_password_otp.dart';
import 'package:flutter_catalog/pages/user_account/forgot_password_new_password.dart';
import 'package:flutter_catalog/pages/main_pages/result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return newMethod();
  }

  MaterialApp newMethod() {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      themeMode: ThemeMode.system, // Set the theme mode
      darkTheme: ThemeData(brightness: Brightness.dark), // Set the dark theme
      initialRoute: "/", // Initial route
      routes: <String, WidgetBuilder>{
        "/": (context) => MainPage(),
        "/home": (context) => MainPage(),
        "/login": (context) => LoginPage(),
        "/create-account": (context) => CreateAccountPage(),
        "/forgot-password-email": (context) => ForgotPasswordEmailPage(),
        "/forgot-password-otp": (context) => OTPVerificationPage(),
        "/forgot-password-new-password": (context) =>
            ForgotPasswordNewPasswordPage(),
        // "scanpage": (context) => ScanPage(),
        "/result": (context) => ResultPage(
            responseData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>), // Add ResultPage route
      },
    );
  }
}
