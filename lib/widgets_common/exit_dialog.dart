import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget exitDialog (context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        children: [
          ourButton(
            color: redColor,
            onPress: (){
              SystemNavigator.pop();
            },
            textColor: whiteColor,
            title: "Yes",
          )
          .box
          .padding(const EdgeInsets.all(12))
          .make(),
          const Spacer(
            flex: 2,
          ),
          ourButton(
            color: lightGrey,
            onPress: (){
              Navigator.pop(context);
            },
            textColor: redColor,
            title: "No",
          )
        ])
      ]
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}