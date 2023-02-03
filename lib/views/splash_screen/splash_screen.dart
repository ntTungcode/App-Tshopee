import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tmart_app/consts/consts.dart';
import 'package:tmart_app/views/home_screen/home.dart';
import 'package:tmart_app/views/widgets_common/applogo_widget.dart';

import '../auth_screen/login_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  static const String id ='splash-screen';
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      //using getX
      // Get.to(() => const OnBoardingScreen());
      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else{
          Get.to(() => const Home());
        }
      });
    });
  }

 @override
 void initState(){
    changeScreen();
    super.initState();
 }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,overlays: []);
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg, width: 300),
              ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            // 340.heightBox,
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
