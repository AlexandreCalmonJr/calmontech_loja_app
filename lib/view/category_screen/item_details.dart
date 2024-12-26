import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/view/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    final String productId = data['id']; // Certifique-se de que o produto possui um ID

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: title!.text.color(darkFontGrey).fontFamily("bold").make(),
          actions: [
            IconButton(
              onPressed: () {}, // Compartilhar ainda não implementado
              icon: const Icon(Icons.share),
            ),
            Obx(() => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeToWishlist(productId); // Usando o ID correto do produto
                      controller.isFav(false);
                    } else {
                      controller.addToWishlist(productId); // Usando o ID correto do produto
                      controller.isFav(true);
                    }
                  },
                  icon: Icon(
                    controller.isFav.value
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: controller.isFav.value ? Colors.red : Colors.grey,
                  ),
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: data['p_imgs'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ).box.roundedSM
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .clip(Clip.antiAlias)
                              .make();
                        },
                      ).box.roundedSM
                          .padding(const EdgeInsets.all(8))
                          .margin(const EdgeInsets.symmetric(horizontal: 16))
                          .make(),
                      10.heightBox,
                      title!.text.size(16).color(darkFontGrey).make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                5.heightBox,
                                "${data['p_seller']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .size(16)
                                    .make(),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                              size: 20,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => const ChatScreen(),
                              transition: Transition.rightToLeftWithFade,
                              arguments: [
                                data['p_seller'],
                                data['vendor_id'],
                              ],
                            );
                          }).box
                              .padding(const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6))
                              .color(textfieldGrey)
                              .rounded
                              .make(),
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      20.heightBox,
                      // Detalhes do produto, cores, descrição etc.
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: () {
                  controller.addToCart(
                    color: data['p_colors'][controller.colorIndex.value],
                    context: context,
                    img: data['p_imgs'][0],
                    qty: controller.quantity.value,
                    sellername: data['p_seller'],
                    title: data['p_name'],
                    description: data['p_desc'],
                    tprice: controller.totalPrice.value,
                    sellerid: data['vendor_id'], // Certifique-se de que esse campo existe
                  );
                  VxToast.show(context, msg: "Added to cart");
                },
                textColor: whiteColor,
                title: "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
