import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: title!.text.color(darkFontGrey).fontFamily("bold").make(),
        actions: [
          IconButton(onPressed: () {},icon: const Icon
          (Icons.share,
          )),
          IconButton(onPressed: () {},icon: const Icon
          (Icons.favorite_outline,
          )),
        ],
      ),
      body: Column(
        children: [
          Expanded(child:Container(
            color: Colors.red,
           ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,

            child: ourButton(
            color: redColor,
            onPress: () {},
            textColor: whiteColor,
            title: "Add to cart",
          ),
          ),
        ],
      ),
    );
  }
}