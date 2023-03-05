import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmart_app/consts/colors.dart';
import 'package:tmart_app/views/screens/on_boarding_screen.dart';
import 'package:tmart_app/views/splash_screen/splash_screen.dart';

import 'consts/strings.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,// xóa logo
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: darkFontGrey,
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent), primarySwatch: Colors.red,
          fontFamily: 'regular'
      ),
      home: const SplashScreen(),
      routes: {
        SplashScreen.id:(context)=> const SplashScreen(),
        OnBoardingScreen.id : (context)=> const OnBoardingScreen(),
        // LoginScreen.id : (context) => const LoginScreen(),
      },
    );
  }
}


