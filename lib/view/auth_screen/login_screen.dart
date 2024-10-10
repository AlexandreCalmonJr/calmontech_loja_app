import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/view/auth_screen/signup_screen.dart';
import 'package:emart_app/view/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_wigdet.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.07).heightBox,
              applogoWidget(),
              10.heightBox,
              "Faça Login no $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(hint: emailHint,title: email),
                  customTextField(hint: passwordHint,title: password),
                  TextButton(onPressed: (){}, child: forgetPass.text.make()),
                  5.heightBox,
                  ourButton(color: redColor, title: login, textColor: whiteColor, onPress: () {
                    Get.to(() => const Home());
                  })
                  .box
                  .width(context.screenWidth -50)
                  .make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(color: lightGrey, title: signup, textColor: redColor, onPress: () {
                    Get.to(() => const SignupScreen());
                  })
                  .box
                  .width(context.screenWidth -50)
                  .make(),
                  15.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(socialIconList[index], 
                        width:30,),
                      ),
                    ) ),
                  ),
                ]
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
          ],
          ),
         ),
        ));
  }
}