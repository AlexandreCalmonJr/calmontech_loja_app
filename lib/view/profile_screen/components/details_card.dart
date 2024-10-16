import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget detailsCard({width, String? count, String? title}){
  return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
                          5.heightBox,
                          title!.text.color(darkFontGrey).make(),

                        ]

                      )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(4))
                      .width(width)
                      .height(60)
                      .make();


}