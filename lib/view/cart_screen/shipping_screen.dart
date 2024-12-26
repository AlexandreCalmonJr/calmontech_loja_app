import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/view/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        child: ourButton(
          onPress: () {
            if(controller.adressController.text.length > 10){
              Get.to(()=> const PaymentMethod());

            }else{
              Get.snackbar("Error", "Please enter a valid address");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Prossiga com a Compra.",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            customTextField(hint: "Endereço",isPass :false,title: "Endereço",controller: controller.adressController),
            customTextField(hint: "Cidade",isPass :false,title: "Cidade", controller: controller.cityController),
            customTextField(hint: "Estado",isPass :false,title: "Estado", controller: controller.stateController),
            customTextField(hint: "CEP",isPass :false,title: "CEP", controller: controller.postalcodeController),
            customTextField(hint: "Telefone",isPass :false,title: "Telefone", controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
