import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';



Widget customTextField({String? title,String? hint,controller,}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(18).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontFamily: semibold,
          fontSize: 12,
          color: textfieldGrey,
        ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: redColor, width: 2.0),)
        ),
      )
      // 5.heightBox,
    ],
  );
}
