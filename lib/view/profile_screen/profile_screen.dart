import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/view/profile_screen/components/details_card.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          body: SafeArea(
              // ignore: avoid_unnecessary_containers
              child: Container(
                  
                  child: Column(
                    children: [
                      //edit profile button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.edit, color: whiteColor))
                            .onTap(() {}),
                      ),

// user detalis action
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              imgProfile2,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Calmon Tech"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                5.heightBox,
                                "calmontech@gmail.com".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                child: logout.text.make())
                          ],
                        ),
                      ),
                      40.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(
                              count: "00",
                              title: "in your cart",
                              width: context.screenWidth / 3.2),
                          detailsCard(
                              count: "32",
                              title: "in your whishlist",
                              width: context.screenWidth / 3.2),
                          detailsCard(
                              count: "675",
                              title: "your orders",
                              width: context.screenWidth / 3.2),
                        ],
                      ),
                      40.heightBox,
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(color: lightGrey);
                        },
                        itemCount: profileButtonsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            )
                                .box
                                .rounded
                                .padding(const EdgeInsets.all(8))
                                .make(),
                            title: profileButtonsList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                      )
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(redColor)
                          .make(),
                    ],
                  )))),
    );
  }
}
