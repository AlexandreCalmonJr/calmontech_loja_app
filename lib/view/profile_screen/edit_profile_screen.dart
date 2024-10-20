import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.profileImgPath.isEmpty
                      ? Image.asset(
                          imgProfile2,
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.heightBox,
                  ourButton(
                      color: redColor,
                      title: "Mudar Imagem",
                      textColor: whiteColor,
                      onPress: () {
                        controller.changeImage(context);
                      }),
                  const Divider(),
                  10.heightBox,
                  customTextField(
                    controller: controller.nameController,
                    hint: nameHint,
                    title: name,
                    isPass: false,
                  ),
                  const Divider(),
                  10.heightBox,
                  customTextField(
                    controller: controller.oldpasswordController,
                    hint: passwordHint,
                    title: oldpass,
                    isPass: true,
                  ),
                  customTextField(
                    controller: controller.newpasswordController,
                    hint: passwordHint,
                    title: newpass,
                    isPass: true,
                  ),
                  20.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ourButton(
                              color: redColor,
                              title: "Salvar",
                              textColor: whiteColor,
                              onPress: () async {
                                controller.isloading(true);

                                // Se a imagem foi alterada, faça o upload
                                // Compactando lógica de verificação da imagem e senha
                                if (controller.profileImgPath.isNotEmpty) {
                                  await controller.uploadProfileImage();
                                } else {
                                  controller.profileImagemLink.value =
                                      data['img']; // Correção: Usando .value
                                }

// Verificação e atualização do perfil
                                if (data['password'] ==
                                    controller.oldpasswordController.text) {
                                  await controller.changeAuthPassword(
                                    email: data['email'],
                                    password:
                                        controller.oldpasswordController.text,
                                    newpassword:
                                        controller.newpasswordController.text,
                                  );

                                  await controller.updateProfile(
                                    img: controller.profileImagemLink.value,
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpasswordController.text,
                                  );

                                  VxToast.show(context, msg: "Atualizado");
                                } else {
                                  VxToast.show(context, msg: "Não Atualizado");
                                }

// Finalizando carregamento
                                controller.isloading(false);
                              }),
                        ),
                ],
              )
                  .box
                  .white
                  .shadowSm
                  .padding(const EdgeInsets.all(16))
                  .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                  .rounded
                  .make(),
            )));
  }
}
