import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = auth.currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocId;

  getChatId() async {
    await chats
        .where('users', isEqualTo: {
          friendId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'create_on': null,
              'last_mgs': '',
              'users': {
                friendId: null,
                currentId: null,
              },
              'toId': '',
              'fromId': '',
              'friend_name': friendName,
              'sender_name': senderName,
              'messages': [],
              }).then((value) {{
                chatDocId = value.id;
              
              }
            });
          }
        });
  }
}
