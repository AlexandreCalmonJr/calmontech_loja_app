import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget featureButton ({String? title,icon}){
return Row(
  children: [
    Image.asset(icon, width: 60, fit: BoxFit.fill),
    10.widthBox,
    title!.text.fontFamily(semibold).color(darkFontGrey).make()
  ],
).box.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(8)).roundedSM.shadowSm.make();

}