import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/applogo_wigdet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
    Get.to(() => const LoginScreen());
  });

  }
  @override
  void initState() {
    super.initState();
    changeScreen();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300,)),
              20.heightBox,
              applogoWidget(),
              10.heightBox,
              appname.text.fontFamily(bold).size(22).white.make(),
              5.heightBox,
              const Text('Flutter Shop Calmon Tech', style: TextStyle(fontSize: 16, color: Colors.white)),
              10.heightBox,
              appversion.text.white.make(),
              const Spacer(),
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox,
              //Splash Screen Complete.
          ],
        ),
      ),
    );
  }
}