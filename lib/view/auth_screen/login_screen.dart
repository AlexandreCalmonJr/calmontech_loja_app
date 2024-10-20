import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/view/auth_screen/signup_screen.dart';
import 'package:emart_app/view/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_wigdet.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.07).heightBox,
            applogoWidget(),
            10.heightBox,
            "Faça Login no $appname"
                .text
                .fontFamily(bold)
                .white
                .size(18)
                .make(),
            15.heightBox,
            Obx(
              () => Column(children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    isPass: false,
                    controller: controller.passwordController),
                TextButton(onPressed: () {}, child: forgetPass.text.make()),
                5.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    :
                ourButton(
                    color: redColor,
                    title: login,
                    textColor: whiteColor,
                    onPress: () async {
                      controller.isLoading(true);

                      // Chama o método de login e aguarda o resultado
                      var userCredential =
                          await controller.loginMethod(context: context);

                      // Verifica se o login foi bem-sucedido
                      if (userCredential != null) {
                        // Exibe mensagem de sucesso
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: loggedin);

                        // Redireciona para a tela Home
                        Get.offAll(() => const Home());
                      } else {
                        controller.isLoading(false);
                        // Tratar caso de falha no login, se necessário (opcional)
                        // ignore: use_build_context_synchronously
                        VxToast.show(context,
                            msg: "Falha no login. Verifique suas credenciais.");
                      }
                    }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    color: lightGrey,
                    title: signup,
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => const SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                15.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                ),
              ])
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
