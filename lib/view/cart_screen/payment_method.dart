import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        child: ourButton(
          onPress: () {
           
          },
          color: redColor,
          textColor: whiteColor,
          title: "Por favor meu pedido",
        ),
      ),
      appBar: AppBar(
        title: "Escolha a forma de pagamento".text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: List.generate(paymentMethodImg.length, (index){
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkFontGrey,
                  style: BorderStyle.solid,
                  width: 2,

                  ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(bottom: 8),
              child: Image.asset(paymentMethodImg[index],width: double.infinity,height: 120,fit: BoxFit.cover,)


            );

          })
        ))
    );
  }
}