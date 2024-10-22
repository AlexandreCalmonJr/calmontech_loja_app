import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/chat_screen/components/sender_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Expanded(
                child: Container(
                    color: Colors.teal,
                    child: ListView(
                      children: [
                        senderBubble(),
                        senderBubble(),
                        
                      ]
                      
                    ))),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: textfieldGrey,
                  )),
                  hintText: 'Type a message',
                ))),
                const SizedBox(width: 10),
                IconButton(onPressed: () {}, icon: const Icon(Icons.send))
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
