import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/applogo_wigdet.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;


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
            "Cadastre no $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(children: [
              customTextField(hint: emailHint, title: name),
              customTextField(hint: emailHint, title: email),
              customTextField(hint: passwordHint, title: password),
              customTextField(hint: passwordHint, title: retypePassword),
              TextButton(onPressed: () {}, child: forgetPass.text.make()),
              8.heightBox,
              Row(
                children: [
                  Checkbox(
                    checkColor: redColor,
                    value: isCheck,
                    onChanged: (newValue) {
                      setState(() {
                        isCheck = newValue;
                      });
                    },
                  ),
                  10.heightBox,
                  Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                    TextSpan(
                      text: 'Eu concordo com os termos de uso  ',
                      style: TextStyle(
                        fontFamily: regular,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: termsAndConditions,
                      style: TextStyle(
                        fontFamily: regular,
                        color: redColor,
                      ),
                    ),
                    TextSpan(
                      text: " & ",
                      style: TextStyle(
                        fontFamily: regular,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: privacyPolicy,
                      style: TextStyle(
                        fontFamily: regular,
                        color: redColor,
                      ),
                    ),
                  ])))
                ],
              ),
              10.heightBox,
              ourButton(
                      color: isCheck == true ? redColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {})
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
               10.heightBox,   
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: alreadyHaveAccount,
                  style: TextStyle(
                    fontFamily: bold,
                    color: fontGrey,
                  ),
                ),
                TextSpan(
                  text: login,
                  style: TextStyle(
                    fontFamily: bold,
                    color: redColor,
                  ),
                ),
              ])
              ).onTap(() {
                Get.back(result: const LoginScreen());
              }),
            ])
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ],
        ),
      ),
    ));
  }
}
