import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget senderBubble() {
  return Container(
          padding: const EdgeInsets.all(1),

    margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(children: [
        "Message here...".text.white.size(20).make(),
        10.heightBox,
        "11:45 pm.".text.color(whiteColor.withOpacity(0.5)).size(20).make(),
      ]));
}
