import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/chats_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/view/chat_screen/components/sender_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Usando Obx corretamente para observar o estado de isLoading
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    flex: 1,
                    child: StreamBuilder(
                      stream: FirestoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('Send messages'));
                        } else {
                          return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var data = snapshot.data!.docs[index];
                              return senderBubble(data);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  )),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: textfieldGrey,
                      )),
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    if (controller.msgController.text.isNotEmpty) {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            )
                .box
                .height(90)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
