import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:emart_app/view/profile_screen/components/details_card.dart';
import 'package:emart_app/view/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(auth.currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Verificação de erros e estados de carregamento
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Ocorreu um erro ao carregar os dados."),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("Nenhum dado encontrado."),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                        child: Column(
                      children: [
                        // Botão de editar perfil
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.edit, color: whiteColor),
                          ).onTap(() {
                            // Configurando o controlador com os dados do Firestore
                            controller.nameController.text = "${data['name']}";
                            Get.to(() => EditProfileScreen(data: data));
                          }),
                        ),
                        // Detalhes do usuário
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              // Imagem do usuário
                              data['img'] == ''
                                  ? Image.asset(
                                      imgProfile2,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ).box.roundedSM.clip(Clip.antiAlias).make()
                                  : Image.network(
                                      data['img'],
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ).box.roundedFull.clip(Clip.antiAlias).make(),
                              20.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  5.heightBox,
                                  "${data['email']}".text.white.make(),
                                ],
                              )),
                              OutlinedButton(
                                  onPressed: () {
                                    auth.signOut();
                                    VxToast.show(context, msg: loggedout);
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: whiteColor)),
                                  child: logout.text.make()),
                            ],
                          ),
                        ),
                        20.heightBox,
                        // Cartões de detalhes do usuário
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: data['cart_count'],
                                title: "in your cart",
                                width: context.screenWidth / 3.2),
                            detailsCard(
                                count: data['wishlist_count'],
                                title: "in your wishlist",
                                width: context.screenWidth / 3.2),
                            detailsCard(
                                count: data['order_count'],
                                title: "your orders",
                                width: context.screenWidth / 3.2),
                          ],
                        ),
                        4.heightBox,
                        // Lista de opções do perfil
                        Expanded(
                          child: ListView.separated(
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
                        ),
                      ],
                    ));
                  }
                })));
  }
}
