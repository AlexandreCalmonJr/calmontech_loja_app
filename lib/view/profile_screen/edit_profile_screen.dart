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
            body: Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
                controller.profileImgPath.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(
                          controller.profileImgPath.value,
                        ),
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
                customTextField(
                  controller: controller.passwordController,
                  hint: passwordHint,
                  title: password,
                  isPass: true,
                ),
                20.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    :
                SizedBox(
                  width: double.infinity,
                  child: ourButton(
                      color: redColor,
                      title: "Salvar",
                      textColor: whiteColor,
                      onPress: () async {        
                        controller.isloading(true);            
                        await controller.uploadProfileImage();
                        await controller.updateProfile(
                          imgUrl: controller.profileImagemLink,
                          name: controller.nameController.text,
                          password: controller.passwordController.text,
                        );
                        
                        VxToast.show(context, msg: "Atualizando");
                        
                        


                      }),
                ),
              ])
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
