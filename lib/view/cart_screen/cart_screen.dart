import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/view/cart_screen/shipping_screen.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
                    child: ourButton(
                      color: redColor,
                      onPress: () {
                        Get.to(() => const ShippingDetails());
                      },
                      textColor: whiteColor,
                      title: "Proceed to shipping",
                    ),
                  ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Shopping cart",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(color: darkFontGrey),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calcule(data);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network("${data[index]['img']}"),
                          title: "${data[index]['title']} (x${data[index]['quantity']})"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['totalprice']}"
                              .text
                              .color(redColor)
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ), // Substitua pelo seu conteúdo

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total price",
                        style: TextStyle(
                          fontFamily: semibold,
                          color: darkFontGrey,
                        ),
                      ),
                      Obx(() => Text(
                            "${controller.totalP.value}",
                            style: const TextStyle(
                              fontFamily: semibold,
                              color: redColor,
                            ),
                          )),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGrey)
                      .roundedSM
                      .make(),
                  const SizedBox(height: 10),
                  const Divider(),
                  SizedBox(
                    child: ourButton(
                      color: redColor,
                      onPress: () {},
                      textColor: whiteColor,
                      title: "Proceed to shipping",
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
